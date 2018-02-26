from bottle import route, run, template, static_file, error, response, redirect, request, template

@route('/hello')
def hello_again():
    if request.get_cookie("visited"):
        return "Welcome back! Nice to see you again"
    else:
        response.set_cookie("visited", "yes")
        return "Hello there! Nice to meet you"

@route('/')
@route('/hello/<name>/<i:int>')
def greet(i = 1, name = 'Stranger'):
    response.set_header("Content-language", "en")
    
    return (template('Hello {{name}}, how are you?\n', name = name)) * i
        
@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root = './static')

@error(404)
def error(error):
    return 'Error! Alert! Everything is breaking!'

@route('/wrong')
def wrong():
    if request.get_cookie("wronged"):
       return "you have wronged twice. no redirect for you."
    response.set_cookie("wronged", "yes")
    redirect("/hello/errorer/2")

@route('/login')
def login():
    return '''
        <form action="/login" method="post">
            Username: <input name="username" type="text" />
            Password: <input name="password" type="password" />
            <input value="Login" type = "submit" />
        </form>
    '''

@route("/login", method="POST")
def do_login():
    username = request.forms.get('username')
    password = request.forms.get('password')
    return(str(username) + " " + str(password))

@route("/template")
def hello():
    return template("hello_template", name = "world")
    
run(host='localhost', port=8080, debug = True)

