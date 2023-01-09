#!/bin/sh

FOLDER=$1

echo "Generating minidump generating sql files"

rm -rf queries
mkdir queries
cd queries

for file in $FOLDER/*
do
    # Get filename
    short_file=$(basename "$file")
    # dump minidump setup sql
    cat ../minidump_setup.sql >> $short_file
    # dump actual sql
    cat $file >> $short_file
done