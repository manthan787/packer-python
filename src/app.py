from flask import Flask, render_template, request
from models import Todo
from datetime import datetime


app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def home():
    if request.method == 'POST':
        todo_text = request.form.get('todo-text')
        if todo_text:
            todo = Todo(id='todo-{}'.format(datetime.now()), text=todo_text)
            todo.save()
    todos = Todo.scan()
    return render_template('index.html', todos=todos)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
