from flask import Flask, request
from db.db import user_auth, exceptions, db

app = Flask(__name__)

@app.route('/search', methods=['POST'])
def recommend():
    try:
        queryText = request.json['query-text']
        if not queryText:
            return 'Invalid request', 401
        return queryText.split(',')
    except:
        return 'Invalid credentials', 401

@app.route('/phone-login-register', methods=['POST'])
def login():
    try:
        pass
    except:
        return 'Invalid credentials', 401

@app.route('/authenticate', methods=['POST'])
def authenticate():
    try:
        
        authorization = request.headers['Authorization']

        supported_auth_type = authorization.split(' ')[0] == 'Bearer'

        token = authorization.split(' ')[1]

        if not token or not supported_auth_type:
            return 'Invalid credentials', 401
        
        try:

            decoded_token = user_auth.verify_id_token(token)

            uid = decoded_token['uid']

            print(decoded_token)

            return uid, 200

        except exceptions.FirebaseError as e:

            print(f'{e.cause} : {e.code}')

            return 'Not authorized', 403
        
    except:
        return 'Missing credentials', 401


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
