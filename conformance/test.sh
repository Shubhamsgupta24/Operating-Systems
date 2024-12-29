#!/bin/bash

# Compile C programs
gcc -o read100 read100.c
gcc -o read510 read510.c
gcc -o write10end write10end.c
gcc -o copy copy.c
gcc -o rename rename.c

# Test read510
echo "----------------------"
echo "Testing read510..."
echo "----------------------"
echo "1234567890" > /tmp/testfile
./read510 /tmp/testfile
if [ $? -eq 0 ]; then
    expected_result="567890"
    actual_result=$(cat /tmp/testfile | tail -c 6)
    if [ "$actual_result" == "$expected_result" ]; then
        echo "read510: FAIL - Unexpected content"
    else
        echo "read510: PASS"
    fi
else
    echo "read510: FAIL - Program execution error"
fi

# Clean up
rm /tmp/testfile

# Test rename
echo "----------------------"
echo "Testing rename..."
echo "----------------------"
echo "012345" > /tmp/testfile
./rename /tmp/testfile /tmp/newname
if [ $? -eq 0 ]; then
    if [ -f /tmp/newname ]; then
        echo "rename: PASS"
    else
        echo "rename: FAIL - New file does not exist"
    fi
else
    echo "rename: FAIL - Program execution error"
fi

# Clean up
rm -f /tmp/newname

# Test read100
echo "----------------------"
echo "Testing read100..."
echo "----------------------"
string="Lorem ipsum dolor sit amet, consectetur adipiscing elit."
./read100 /tmp/testfile "$string"
if [ $? -eq 0 ]; then
    if [ -f /tmp/testfile ]; then
        file_data=$(cat /tmp/testfile)
        if [ "$file_data" == "$string" ]; then
            echo "read100: PASS"
        else
            echo "read100: FAIL - Content mismatch"
        fi
    else
        echo "read100: FAIL - File does not exist"
    fi
else
    echo "read100: FAIL - Program execution error"
fi

# Clean up
rm /tmp/testfile

# Test write10end
echo "----------------------"
echo "Testing write10end..."
echo "----------------------"
echo "0123456789" > /tmp/testfile
./write10end /tmp/testfile
if [ $? -eq 0 ]; then
    if [ -f /tmp/testfile ]; then
        data=$(tail -c 10 /tmp/testfile)
        if [ "$data" == "abcdefghij" ]; then
            echo "write10end: PASS"
        else
            echo "write10end: FAIL - Data read is incorrect"
        fi
    else
        echo "write10end: FAIL - File does not exist"
    fi
else
    echo "write10end: FAIL - Program execution error"
fi

# Clean up
rm /tmp/testfile

# Test copy
echo "----------------------"
echo "Testing copy..."
echo "----------------------"
echo "012345" > /tmp/testfile
./copy /tmp/testfile /tmp/copiedfile
if [ $? -eq 0 ]; then
    if [ -f /tmp/testfile ] && [ -f /tmp/copiedfile ]; then
        if diff -qs /tmp/testfile /tmp/copiedfile >/dev/null; then
            echo "copy: PASS"
        else
            echo "copy: FAIL - Contents of source and copied files differ"
        fi
    else
        echo "copy: FAIL - Source or destination file does not exist"
    fi
else
    echo "copy: FAIL - Program execution error"
fi

# Clean up
rm /tmp/testfile /tmp/copiedfile
