#!/usr/bin/python
from __future__ import print_function
from flask import Flask, request
from faker import Factory
from random import randint, choice, sample
import mysql.connector
from mysql.connector import Error
import hashlib

fake = Factory.create('en_US')
cnxn = mysql.connector.connect(host='localhost',
                             database='mybook',
                             user='root',
                             password='')
print ("GENERATING THE USERS FOR THE DATABASE!!")
cursor = cnxn.cursor()
count = 506212
for i in range(5207):
    user_id = count
    user_fname = fake.first_name()
    user_lname = fake.last_name()
    user_dob = fake.date_of_birth()
    user_password = fake.password(length = 4)
    user_addr = fake.address()
    cursor.execute("INSERT INTO Users VALUES (%s, %s, %s, %s, %s, %s)", (user_id, user_fname, user_lname, user_dob, user_password, user_addr))
    cnxn.commit()
    count +=1
print ("DONE CREATING USERS")
print ("")

