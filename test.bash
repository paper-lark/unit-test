#!/bin/bash

# Test suit integrity error
int_err() {
    echo '> error: test suit integrity error'
    exit 4
}

# Process tests from the file
process() {

    # Initialize variables 
    ARGS=""
    CURRENT_TEST=0
    STATE=0 # 0 - initial state, 1 - suit running, 2 - test running 
    LEN=${#CONTENTS[@]}

    # Examine suit file line by line
    for (( i = 0; i < LEN; i++ )); do

        # Delete leading spaces and tabs
       CONTENTS[$i]=`echo "${CONTENTS[$i]}" | sed -e 's/^[ \t]*//'`

        # Process line
        if [ "${CONTENTS[$i]}" == '<Suit>' ]; then # Suit started
            if [ "${STATE}" -ne 0 ]; then
                int_err
            fi
            STATE=1
        elif [ "${CONTENTS[$i]}" == '<Test>' ]; then # Test start found
            if [ "${STATE}" -ne 1 ]; then
                int_err
            fi
            STATE=2
            ARGS=""
            (( CURRENT_TEST++ ))        
        elif [ "${CONTENTS[$i]}" == '</Test>' ]; then # Test end found
            if [ "${STATE}" -ne 2 ]; then
                int_err
            fi
            STATE=1
            echo -e "> test #${CURRENT_TEST} with arguments: \"`echo ${ARGS} | sed -e 's/[\t\n]*/ /' | sed -e 's/^ *//'`\" is running..."
            echo '> unit output:'
            ./"${BINARY}" <<< "${ARGS}"
            EXIT_CODE="$?"
            if (( EXIT_CODE == 0 )); then
                echo '> test succesfully completed'
            else
                echo '> test failed!'
                FAILED="${FAILED}#${CURRENT_TEST} "
            fi
        elif [ "${CONTENTS[$i]}" == '</Suit>' ]; then # Test suit end found
            if [ "${STATE}" -ne 1 ]; then
                int_err
            fi
            STATE=0
        else # Argument or empty line found
            if [ "${STATE}" -ne 2 ] && [ "${CONTENTS[$i]}" != '' ]; then
                int_err
            fi
            ARGS="${ARGS}${CONTENTS[$i]}"$'\n'
        fi
    done

    if [ ${STATE} -ne 0 ]; then # Test suit end was not found
        int_err
    fi
}

# Check whether the file name was provided
if [ $# -ne 2 ]; then
    echo '> error: Wrong number of arguments. Usage: test [program] [test_suit].'
    exit 1
elif [ ! -x $1 ]; then
    echo '> error: Program is not an exectutable file. Usage: test [program] [test_suit].'
    exit 2
elif [ ! -f $2 ]; then
    echo '> error: Test suit not found. Usage: test [program] [test_suit].'
    exit 3
else
    echo '> unit testing is running...'
fi  

# Set variables
BINARY="$1"
TESTS="$2"
FAILED=""

# Read contents
CONTENTS=()
OIFS="${IFS}"
IFS=$'\n'
read -d '' -r -a CONTENTS < ${TESTS}
IFS="${OIFS}"
process
echo '> unit testing has finished!'
if [ FAILED == "" ]; then
    echo '> all tests are successfully passed'
else
    echo "> test(s) ${FAILED}were failed"
fi
