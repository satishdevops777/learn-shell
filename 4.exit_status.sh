sample() {
  echo Hello
  return 1
  echo Bye
}

sample
echo Function Exit status - $?

echo Hello
exit 100
echo Bye


# One-line difference
return → exits a function
exit → exits the entire script


#!/bin/bash

if [ ! -f /etc/passwd ]; then
  echo "Critical file missing"
  exit 1
fi

echo "This line will run only if file exists"
