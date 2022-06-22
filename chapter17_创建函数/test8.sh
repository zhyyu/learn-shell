#!/bin/bash
# using a global variable to pass a value
function dbl {
 value=$[ $value * 2 ]
 invalue=123
}
read -p "Enter a value: " value
dbl
echo "The new value is: $value"
echo $invalue
