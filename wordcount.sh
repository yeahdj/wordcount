#!/bin/bash

# A shell script that will return a word count for a text file provided as an argument.
# The script should be ran in the command line, with the path to a file provided as an argument

# Written by David Jess

#######################

# Check that the correct number of arguments have been provided. If no arguments are provided
# or more than one argument is provided, print an error message and exit.

if [ "$#" -eq 0 ]; then
    echo "Oops! you didn't provide a file for me to check, please run this script again and provide a filename. Like this: $0 warandpeace.txt"
    exit 1
elif [ "$#" -gt 1 ]; then
    echo "Sorry, I only know how to check one file at a time right now, please try again, but only provide one filename. Like this: $0 1984.txt"
    exit 1
fi

# Variables

filename=$1

# Pass the file contents to a variable to be manipulated in the next step

text=$(<"$filename")

# This section 'cleans' our text file and passes it to a variable to be counted. 
# We first echo the 'text' variable we created in the last step, then 
# use translate to remove white space and organise each word in the file into it's 
# own line. Then we use translate again to remove punctuation, and and then a third 
# time to convert all uppercase characters to lowercase. Finally we use sort to 
# sort the words alphabetically.

clean_text=$(echo "$text" | tr -s '[:space:]' '\n' | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | sort)

# This section does our word count and echoes it to a variable to be printed.
# First we echo the 'clean_text" variable we created in the last step, then we
# use uniq -c to count the number of times each word appears in the file, and then
# we use sort -nr to sort the counts in descending order (most to least occurences.)

wordcount=$(echo "$clean_text" | uniq -c | sort -nr)

# This section prints the word count to the command line. First we echo the 
# 'wordcount' variable we created in the last step, then we use awk to print
# print the second column of the wordcount variable (which is the word) 
# and then the first column (which is the count we added in the last step).

echo "$wordcount" | awk '{print $2 ": " $1}'
