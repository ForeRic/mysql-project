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

    # cursor 생성
    cursor = db.cursor()

    #sql 실행
    sql = 'insert into emaillist values(null,"마","이콜","jeongjiyoon93@gmail.com")'
    count = cursor.execute(sql)

    #commit
    db.commit()

    # result 받아오기
    results = cursor.fetchall()

    #자원정리
    cursor.close()
    db.close()

    # 결과보기
    print(f'result: {count==1}')
    
except OperationalError as err:
    print(f'sorry. plz try later :{err}')


