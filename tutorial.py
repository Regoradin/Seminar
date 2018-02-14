from bottle import route, run, template, static_file, error, response

@route('/hello')
def hello():
    return "Hello World"

@route('/')
@route('/hello/<name>/<i:int>')
def greet(i, name = 'Stranger'):
    response.set_header("Content-language", "en")
    
    return (template('Hello {{name}}, how are you?\n', name = name)) * i
        
@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root = './static')

@error(404)
def error(error):
    return 'Error! Alert! Everything is breaking!'

run(host='localhost', port=8080, debug = True)

