from flask import Flask
from redis import StrictRedis

app = Flask(__name__)

rr = StrictRedis(host='redis', port='6379', db=0)

@app.route('/')
def hello_world():
    count = rr.incr('web_count')
    return '<img src="/static/quay-logo.png"/><br/><br/>Hello World with static resource!! This is a demo.<br/>Count = %d' % count


if __name__ == '__main__':
    print 'Starting HTTP server'
    app.run(port=80, debug=True, host='0.0.0.0')
