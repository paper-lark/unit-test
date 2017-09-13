# Unit Test Script for C/C++

Unit Test Script for C/C++ is a Bash script that allows to easily test a program written in C/C++.

**_Note:_** Although script was written for C/C++, it may in theory work with any other compiled programming language.

## Instructions

### Installation

Simply copy script to `/usr/local/bin` or any other folder included in `PATH`.

### Usage

In order to run the script, a text file (also known as a "test suit") should be created, as well as a binary of the program. Test suit follows the XML syntax and includes `<Suit>`, `<Test>`, and `<Result>` tags for specifying the test suit itself, particular tests to be executed within it, and their expected results. Text between `<Test>` tags consists of the arguments to be passed to the `stdin` stream of the tested program, and the expected result. The result is specified inside `<Result>` tags. Sample test suit along with a test program can be all found in the `Sample` directory.

After the suit is ready and the program is compiled, simply run the script with the following line:

```bash
unit-test <program> <suit>
```

Script prints information about the testing process as well as the output of the tested program to `stderr`. The last line of the output contains numbers of tests that were not passed, if there were any. All the information about errors is included into the `log.test` file.

## Bugs
If you find any bugs, please report them at https://github.com/paper-lark/unit-test/issues

## Suggestion
If you have any suggestions about the project or new possible features, feel free to contact me.

## License
Unit test script for C/C++ is available under the terms of the MIT License. See ```LICENSE``` for more.
