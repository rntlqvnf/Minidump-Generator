HOST=$1
DBNAME=$2
USER=$3
PWD=$4

CURRENT_DIR=${MASTER_DATA_DIRECTORY}/minidumps
get_recent_file () {
    FILE=$(ls -Art1 ${CURRENT_DIR} | tail -n 1)
    if [ ! -f ${FILE} ]; then
        CURRENT_DIR="${CURRENT_DIR}/${FILE}"
        get_recent_file
    fi
    echo $FILE
    exit
}

export PGPASSWORD=$PWD

# Generate folder
rm -rf results
mkdir results
mkdir ./results/query_executions
mkdir ./results/raw_minidumps
mkdir ./results/minidumps

# Run queries
for file in ./queries/*
do
    file_name=$(basename $file .sql)
    psql -h $HOST -U $USER $DBNAME < $file > results/query_executions/${file_name} 2>> results/runner.err
    minidump_file=$(get_recent_file)
    echo 'Generating' ${minidump_file}
    cp $minidump_file results/raw_minidumps/${file_name}.mdp
done

echo "Running xmllint..."

# Run prepcoess
for file in ./results/raw_minidumps/*
do
    file_name=$(basename $file .mdp)
    xmllint --format $file > ./results/minidumps/${file_name}.mdp
done