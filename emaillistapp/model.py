from MySQLdb import connect, OperationalError
from MySQLdb.cursors import DictCursor


def findall():
    try:
        # 연결
        db = conn()

        # cursor 생성
        cursor = db.cursor(DictCursor)

        # sql 실행
        sql = 'select no, first_name, last_name, email from emaillist order by no desc'
        cursor.execute(sql)

        # 결과 받아오기
        results = cursor.fetchall()

        # 자원정리
        cursor.close()
        db.close()

        # 결과 반환
        return results

    except OperationalError as err:
        print(f'sorry. plz try later :{err}')


def insert(firstname, lastname, email):
    try:
        # 연결
        db = conn()

        # cursor 생성
        cursor = db.cursor()

        # sql 실행
        sql = 'insert into emaillist values(null, %s, %s, %s)'
        count = cursor.excute(sql, (firstname, lastname, email))

        # commit
        db.commit()

        # 자원정리
        cursor.close()
        db.close()

        # 결과 반환
        return count == 1

    except OperationalError as err:
        print(f'sorry. plz try later :{err}')


def conn():
    return connect(
        user='webdb',
        password='webdb',
        host='localhost',
        port=3306,
        db='webdb',
        charset='utf8')