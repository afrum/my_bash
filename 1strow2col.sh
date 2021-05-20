#! /bin/bash

grep -m 1 "," "$1" |sed 's/\,/\n/g' > $2

# -m 1 (defines the number of rows to use I'm just using the first row)

# the 3 commands below I used at first because
# it was a way I found to add user defined filename
# the 3 lines below worked fine if there were no spaces 
# in my filename and if I was happy with keeping the 
# output name the same everytime.
#echo filename of your csv?
#read fn
#grep -m 1 , $fn |sed 's/\,/\n/g' > row2col.txt


# I found out later that you can just add inputs 
# when running your script
# e.g. ./myscript.sh input1 input2
# input1 is $1 and input2 is $2 and so on...

# the command below also didn't work if there were spaces
# in the input filename.
#grep -m 1 , $1 |sed 's/\,/\n/g' > $2

# after much trial and error I found out that I needed
# to put speech marks around the pattern which in my case 
# was a comma and the $1 
# As you can see in the command I am using.
