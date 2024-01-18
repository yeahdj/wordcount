#!/bin/bash

# A shell script that will return a word count for a text file provided as an argument.
# The script should be ran in the command line, with the path to a file provided as an argument

# Written by David Jess

#######################

# Variables

filename=$1

# Check that the correct number of arguments have been provided. If no arguments are provided
# or more than one argument is provided, print an error message and exit.

if [ "$#" -eq 0 ]; then
    echo "Oops! you didn't provide a file for me to check, please run this script again and provide a filename. Like this: sh $0 warandpeace.txt"
    exit 1
elif [ "$#" -gt 1 ]; then
    echo "Sorry, I only know how to check one file at a time right now, please try again, but only provide one filename. Like this: sh $0 1984.txt"
    exit 1
fi

# Check that the argument provided is a valid filename, and that we have permission to read it

if [ ! -f "$filename" ]; then
    echo "Oops, it looks like $filename doesn't point to a file. Please check you've entered the right path."
    exit 1
elif [ ! -r "$filename" ]; then
    echo "Sorry, I cannot read $filename, please check that you have permission to access this file."
    exit 1
fi

# Check that the file provided is not empty.

if [ ! -s "$filename" ]; then
    echo "$filename is empty, no words to count, I'll take the rest of today off! :D"
fi

# Pass the file contents to a variable to be manipulated in the next step

text=$(<"$filename")

if ! clean_text=$(echo "$text" | tr -s '[:space:]' '\n' 2>/dev/null); then
    echo "Sorry, I can't process files of this type, I work best un-encoded text files like txt, yaml, etc, I can even work with .csv. But things like docx, pdf are not supported. Sorry!"
    exit 1
fi

# This section 'cleans' our text file by first echoing the 'text' variable created.
# Then we use awk to remove any trailing or leading whitespace. Then we use transform
# to replace any spaces in between words with a newline character. Leaving us
# with a list of words, one per line. Then we use sed to remove any empty lines.
# Then we use transform to remove any punctuation. Then we use transform to convert
# all uppercase letters to lowercase. Finally we use sort to sort the words in
# alphabetical order.

clean_text=$(echo "$text" | awk '{$1=$1;print}' | tr -s '[:space:]' '\n' | sed '/^[[:space:]]*$/d' | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | sort)


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
