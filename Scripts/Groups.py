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
group_name_lst=["Annihilators", "Avengers", "Bad to The Bone", "Black Panthers", "Black Widows","Blitzkrieg", "Braindead Zombies","Brewmaster Crew", "Brute Force", "Butchers", "0% Risk", "100% Administration", "Advocates", "Ambassadors", "American Patriots", "A-Team", "Barons and Duchesses", "Challengers", "Conquerors", "Apple Sour", "Backstreet Girls", "Bad Girlz", "Blueberries", "Bubblicious", "Butterflies", "Charlie’s Angels", "Charmers", "Coffee Lovers", "Alpha Team", "Aztecs", "Bachelors", "Bad Boys", "Berets", "Bredrin", "Champions", "CIA", "Cobras", "Code Black", "404! Group name does not exist", "A Team with No Name", "Abusement Park", "Alcoholism Is The Real Winner", "All Pain, No Gain", "Are We There Yet?", "Ask Me How I Made $20 Today", "Bacon Water", "Bad Hair Day", "Bed Bath and Beyoncé"]
cursor = cnxn.cursor()
count = 0
for i in range(700000):
    user_id = count
    group_id = count
    group_name = fake.group_name()
    group_description = fake.group_description()
    cursor.execute("INSERT INTO Groups VALUES (%s, %s, %s, %s)", (user_id, group_id, group_name, group_description))
    cnxn.commit()
    count +=1
print ("DONE CREATING GROUPS")
print ("")

