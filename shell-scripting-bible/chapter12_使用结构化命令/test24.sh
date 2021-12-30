#!/bin/bash
# using pattern matching
if [[ $USER == r* ]]
then
  echo "Hello $USER"
else 5
  echo "Sorry, I do not know you"
fi
