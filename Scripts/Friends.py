#!/usr/bin/python
from __future__ import print_function
from flask import Flask, request
from faker import Factory
from random import randint, choice, sample
import mysql.connector
from mysql.connector import Error
import hashlib
import random

fake = Factory.create('en_US')
cnxn = mysql.connector.connect(host='localhost',
                             database='comp3161finalproject',
                             user='root',
                             password='')
print ("GENERATING THE FRIENDS FOR THE DATABASE!!")
friend_type_lst=["Relative", "School", "Work"]
cursor = cnxn.cursor()
count = 0
for i in range(700000):
    user_id = count
    friend_id = count
    friend_type = friend_type_lst[random.randint(0,2)]
    cursor.execute("INSERT INTO Friends VALUES (%s, %s, %s)", (user_id, friend_id, friend_type))
    cnxn.commit()
    count +=1
print ("DONE CREATING FRIENDS")
print ("")

