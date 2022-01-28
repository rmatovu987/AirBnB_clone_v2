#!/usr/bin/python3
""" script that starts a flask web application """

from flask import Flask

app = Flask(__name__)

@app.route('/', strict_slashes=False)
def default_route():
    """ Default route
    """
    return 'Hello HBNB!';

@app.route('/hbnb', strict_slashes=False)
def hbnb_route():
    """hbnb route
    """
    return 'HBNB'

@app.route('/c/<text>', strict_slashes=False)
def hbnb_c(text):
    """hbnb c
    """
    return 'C {}'.format(text.replace('_',' '))

@app.route('/python/', strict_slashes=False)
@app.route('/python/<text>', strict_slashes=False)
def hbnb_python(text='is cool'):
    """hbnb python
    """
    return 'Python {}'.format(text.replace('_',' '))


if __name__ == '__main__':
    app.run()
