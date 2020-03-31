#!/bin/bash

#/opt/exodus/bin/python3.7 -c "import urllib.request; print(urllib.request.urlopen('http://google.com').read())"
#exit $?

# Check if python is now runnable again :)
python3.7 -c "import urllib.request; print(urllib.request.urlopen('http://google.com').read())"
exit $?

