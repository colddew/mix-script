#!/usr/bin/python2
# -*- coding: UTF-8 -*-

# install
# sudo pip install pymongo
# sudo pip install MySQL-python
# sudo install_name_tool -change libmysqlclient.18.dylib /usr/local/mysql/lib/libmysqlclient.18.dylib /Library/Python/2.7/site-packages/_mysql.so
# sudo pip install requests
# sudo pip install threadpool
# sudo pip install apscheduler

# command
python -V

import sys, pprint
pprint.pprint(sys.path)

dir(copy)
help(copy.copy)
print copy.__doc__
print copy.__file__

import webbrowser
webbrowser.open("http://www.baidu.com")

import urllib
html = urllib.urlopen("http://www.baidu.com").read()
temp_file = urllib.urlretrieve("http://www.baidu.com")
urllib.urlcleanup()

# script
for letter in 'Python':
    print 'current letter:', letter

fruits = ['banana', 'apple',  'mango']
for index in range(len(fruits)):
    print 'current fruit:', fruits[index]

with open("/tmp/file.txt") as file:
    do(file)

f = open(filename)
for line in f.readlines():
    process(line)
f.close()

import fileinput
for line in fileinput.input(line):
    process(line)

f = open(filename)
for line in f:
    process(line)
f.close()
