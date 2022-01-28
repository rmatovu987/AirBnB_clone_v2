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

if __name__ == '__main__':
    app.run()
