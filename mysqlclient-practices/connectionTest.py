from MySQLdb import connect, OperationalError

try:
    #연결
    db = connect (
        user='webdb',
        password='webdb',
        host='localhost',
        port=3306,
        db='webdb',
        charset='utf8')
    print('ok')
except
    OperationalError as err:
    print('sorry. plz try later')

print(db)
