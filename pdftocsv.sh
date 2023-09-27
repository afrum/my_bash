#!/bin/bash

# Name of the CSV file
CSV_FILE="output.csv"

# Check if the CSV file exists, if not, create it
[ ! -f "$CSV_FILE" ] && touch "$CSV_FILE"

# Loop through all .pdf and .PDF files in the current directory
for file in *.{pdf,PDF}; do
    # Check if the file exists
    if [ -f "$file" ]; then
        # Convert the PDF to text, replace characters, and append to CSV
        content=$(pdftotext "$file" - | tr '\n\r\t' ',,,' | sed -e :a -e '/./,$!d;/^\n*$/{$d;N;};/\n$/ba')
        if [[ ! -z "$content" ]]; then
            echo "$file,$content" >> "$CSV_FILE"
        fi
    fi
done
