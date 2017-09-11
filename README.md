# Unit Test Script for C/C++

Unit Test Script for C/C++ is a Bash script that allows quickly running multiple tests on a single program.



## Instructions

### Installation

Simply copy script to `/usr/local/bin` or any other folder included in `PATH`.

### Usage

In order to run the script, a test suit which follows the XML syntax and includes `<Suit>` and `<Test>` tags for specifying the test suit and particular tests to be executed, should be created, as well as a pre-built binary of the program. Text between `<Test>` tags is to be passed to the `stdin` of the tested program. Sample test suit as well as a test program can be found in the `Sample` directory.

After the suit is ready and the program is compiled, simply run the script with the following line:

```bash
unit-test <program> <test-suit>
```

Script output includes information about testing process as well as all the output of the tested program. The last line of the output contains numbers of tests that returned with a non-zero code if there were any.

## Bugs
If you find any bug, please report it at https://github.com/paper-lark/unit-test/issues

## Suggestion
If you have any suggestions about the project or new features, feel free to contact me.

## License
Unit test script for C/C++ is available under the terms of the MIT License. See ```LICENSE``` for more.