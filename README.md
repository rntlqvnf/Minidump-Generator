# Minidump-Generator

This is minidump generator for arbitrary queries.

## Usage

To generate sql files for generating minidump files:

```
./generator.sh <sql file folder>
```

For example

```
./generator.sh /home/TPCH-Greenplum/dss/queries/
```

To run generated sql files:

```
./runner.sh <host> <dbname> <user> <password> 
```

For example

```
./runner.sh 127.0.0.1 postgres gpadmin gpadmin
```

`runner.sh` will generate minidump files with xmlint and query execution results in `results` folder.

`results/raw_minidumps` contains raw minidump files without xmlint, while `results/minidumps` contains preprocessed minidump files.