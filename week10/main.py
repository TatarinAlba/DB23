from pymongo import MongoClient

client = MongoClient('localhost', 27017)
db = client['test']


def first_task(db):
    print('First subtask')
    cursor = db.restaurants.find({'cuisine': 'Irish'})
    for el in cursor:
        print(el)
    print('Second subtask')
    cursor = db.restaurants.find({'cuisine': {'$in' : ['Irish', 'Russian']}})
    for el in cursor:
        print(el)
    print('Third subtask')
    cursor = db.restaurants.find({'address.': 'Irish'})
    for el in cursor:
        print(el)
first_task(db)