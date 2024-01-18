# wordcount

This shell script calculates the word count for a text file provided as an argument. The script should be run in the command line, with the path to a file provided as an argument.

## Compatibility

The script should work natively on any unix based operating system, although i have only tested it on Mac and Ubuntu. 

The script will only work with un-encoded text files, like txt, yaml etc. things like docx, pdf etc are currently not supported.

## Usage

1. **Clone the Repository:**

First, clone the repository to your machine.

   ```bash
   git clone https://github.com/yeahdj/wordcount.git
   cd wordcount
   ```

2. **Run the Script:**

Or you can make it executable if you prefer, it should be executable if you pulled it from git. Use chmod +x if you need to.

   ```bash
   ./wordcount.sh your_text_file.txt
   ```

3. **Errors:**

The script will show an error if any of the following conditions are met.

* If no argument is provided
* If more than one argument is provided
* If an argument is provided that doesn't point to a file
* If there is a permissions error on the file provided in the argument
* If the file is empty
* If the script finds a file that it can't supprt (images, docx files, any other encoded text files, anything that isn't raw text)

 Stay tuned for more improvements!
