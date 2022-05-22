#!/usr/bin/python3
import urllib.request
import xml.dom.minidom as minidom
import psycopg2
#import sys
from datetime import date, timedelta

conn = psycopg2.connect(
   database="mytestdb", user='postgres', password='ubuntu20', host='192.168.1.90', port='5432'
)
conn.autocommit = True
cursor = conn.cursor()
# Added code from "create table.py" start ===========================================================
#Droping EMPLOYEE table if already exists.
cursor.execute("DROP TABLE IF EXISTS EXCHANGE_RATE")

#Creating table as per requirement
sql ='''CREATE TABLE EXCHANGE_RATE(
   Date CHAR(10) NOT NULL,
   ID CHAR(10) NOT NULL,
   NumCode CHAR(4) NOT NULL,
   CharCode CHAR(4) NOT NULL,
   Nominal CHAR(10) NOT NULL,
   Name CHAR(40) NOT NULL,
   Value CHAR(10) NOT NULL
)'''
cursor.execute(sql)
print("Table created successfully........")
conn.commit()

today = date.today()
f_day = date.today().replace(day=1)
delta = timedelta(days=1)
last_day = today.strftime('%d')
last_day = int(last_day)
month = today.strftime('%m')
month = int(month)
year = today.strftime('%Y')
year = int(year)

print('====================================================')

delta = timedelta(days=1)

while f_day <= today:

    x_date = f_day.strftime("%d/%m/%Y")

    def get_data(xml_url):
        try:
            web_file = urllib.request.urlopen(xml_url)
            return web_file.read()
        except:
            pass

    def get_currencies_dictionary(xml_content):
        dom = minidom.parseString(xml_content)
        dom.normalize()

        elements = dom.getElementsByTagName("Valute")
        currency_dict = {}
        currency_dict_all = {}

        for node in elements:
            v_id = node.getAttribute("ID")
            numcode = node.getElementsByTagName("NumCode")[0]
            charcode = node.getElementsByTagName("CharCode")[0]
            nominal = node.getElementsByTagName("Nominal")[0]
            name = node.getElementsByTagName("Name")[0]
            value = node.getElementsByTagName("Value")[0]

            currency_dict["ID"] = v_id
            currency_dict["NumCode"] = numcode.firstChild.data
            currency_dict["CharCode"] = charcode.firstChild.data
            currency_dict["Nominal"] = nominal.firstChild.data
            currency_dict["Name"] = name.firstChild.data
            currency_dict["Value"] = value.firstChild.data
    #    return currency_dict
            val_to_db = [str(v) for k,v in currency_dict.items()]

            row_test = (x_date, val_to_db[0], val_to_db[1], val_to_db[2], val_to_db[3], val_to_db[4], val_to_db[5])
            print(row_test)
            # Creating a cursor object using the cursor() method
            cursor = conn.cursor()
            cursor.execute('''INSERT INTO EXCHANGE_RATE(Date, ID, NumCode, CharCode, Nominal, Name, Value)
             VALUES(%s, %s, %s, %s, %s, %s, %s)''', row_test)

            # Commit your changes in the database
            conn.commit()
            print("Records inserted........")

    if __name__ == '__main__':
        url = 'http://www.cbr.ru/scripts/XML_daily.asp?date_req=%s' % x_date

        currency_dict = get_currencies_dictionary(get_data(url))

    f_day += delta
conn.close()



