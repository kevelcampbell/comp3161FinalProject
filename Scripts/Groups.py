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
print ("GENERATING THE GROUPS FOR THE DATABASE!!")


group_name_lst=["Annihilators", "Avengers", "Bad to The Bone", "Black Panthers", "Black Widows", "Blitzkrieg", "Braindead Zombies", "Brewmaster Crew", "Brute Force", "Butchers"]


cursor = cnxn.cursor()
count = 0
for i in range(20):
    user_id = count
    group_id = count
    group_name = group_name_lst[random.randint(0,9)]
    group_description = group_description()
    cursor.execute("INSERT INTO Groups VALUES (%s, %s, %s, %s)", (user_id, group_id, group_name, group_description))
    cnxn.commit()
    count +=1
print ("DONE CREATING GROUPS")
print ("")

