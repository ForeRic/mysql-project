from MySQLdb import connect, OperationalError
from MySQLdb.cursors import DictCursor

try:
    #연결
    db = connect (
        user='webdb',
        password='webdb',
        host='localhost',
        port=3306,
        db='webdb',
        charset='utf8')

    # cursor 생성
    cursor = db.cursor(DictCursor)

    #sql 실행
    sql = 'select no, first_name, last_name, email from EmailList order by no desc'
    cursor.execute(sql)

    # result 받아오기
    results = cursor.fetchall()

    #자원정리
    cursor.close()
    db.close()

    # 결과보기
    for result in results:
        # print(result['no']) --> 2 1 로 나옴
        print(result)
except OperationalError as err:
    print(f'sorry. plz try later :{err}')


