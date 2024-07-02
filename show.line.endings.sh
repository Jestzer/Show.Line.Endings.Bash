#!/bin/bash

# Check if a file has been provided as an argument.
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 filename"
    exit 1
fi

# Check if the file exists.
if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
fi

# Read the file and replace line endings and tabs. This is done line by line.
while IFS= read -r -d '' line || [[ -n "$line" ]]; do
    # Replace tabs with \t.
    line=$(echo "$line" | sed $'s/\t/\\\\t/g')
    # Replace carriage return with \r.
    line=$(echo "$line" | sed 's/\r/\\r/g')
    # Print the line with \n at the end.
    echo -n "$line\\n"
done < <(sed 's/$/\x00/' "$1")
