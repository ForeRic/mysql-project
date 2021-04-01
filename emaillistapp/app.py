# from emaillistapp.model import findall
from emaillistapp import model


def run_list():
    # results = findall()
    results = model.findall()

    for index, result in enumerate(results):
        print(f'{index+1}:{result["first_name"]}{result["last_name"]}:{result["email"]}')


def run_add():
    firstname = input('first name: ')
    lastname = input('last name: ')
    email = input('email: ')

    model.insert(firstname,lastname,email)

    run_list() # 리스트를 다시 불러주면 좋을 듯. 보기 위해서: 함수를 다시 콜

def run_delet():
    email = input('email:')
    #model.deletbyemail(email)
    run_list()

def main():
    while True:
        cmd = input(f'(l)list, (a)dd, (d)elet, (q)uit >')

        if cmd == 'q':
            break
        elif cmd == 'l':
            run_list()
        elif cmd == 'a':
            run_add()
        elif cmd == 'd':
            run_delet()
        else:
            print('Error')



# if __name__ == '__main__':
#   main()
# if문 대신 더 좋은 것은
__name__ == '__main__' and main()

# true and true = true
# true and false = false
# false and false = false
# false and true = false
# 앞이 false 면 뒤를 실행 할 필요가 없으나 앞이 true 면 앞을 실행 후에 뒤에 실행. 그 구문 쓴것.
