from flask import Flask, make_response
import os

app = Flask(__name__)

@app.route('/')
def hello_from_cloud():
    cloud_name = os.getenv('CLOUD_NAME')
    return make_response(f'Hello from {cloud_name}!', 200)

@app.route('/healthz')
def healthz():
    return make_response('OK', 200)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
