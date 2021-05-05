#! /usr/bin/env bash

# you need to have pdftotext installed
# link for where I found this command https://askubuntu.com/questions/211870/how-to-convert-all-pdf-files-to-text-within-a-folder-with-one-command

for file in *.pdf;
	do pdftotext -raw "$file" "$file.txt";
done

# link where I found this command:https://stackoverflow.com/questions/2150614/concatenating-multiple-text-files-into-a-single-file-in-bash
cat *.txt >> all.txt
