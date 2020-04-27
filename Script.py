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
                             database='comp3161finalproject',
                             user='root',
                             password='')
print ("GENERATING THE USERS FOR THE DATABASE!!")
cursor = cnxn.cursor()
count = 0
for i in range(100):
    user_id = count
    user_f_name = fake.first_name()
    user_l_name = fake.last_name()
    user_email = fake.email()
    cursor.execute("INSERT INTO Users VALUES (%s, %s, %s, %s)", (user_id, user_f_name, user_l_name, user_email))
    cnxn.commit()
    count +=1
print ("DONE CREATING USERS")
print ("")

# user_dob, user_tel, user_addr,user_password,
