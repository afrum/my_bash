#! /bin/bash
echo filename of your csv?
read fn

# -m 1 (defines the number of rows to use is 1)
grep -m 1 , $fn |sed 's/\,/\n/g' > row2col.txt
