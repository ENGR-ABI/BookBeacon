from firebase_admin import credentials, initialize_app, firestore, auth, exceptions
import os
from db.config import config

cred = credentials.Certificate(config)

bookbeacon_fb = initialize_app(cred)

db = firestore.client(app=bookbeacon_fb)

user_auth = auth.Client(app=bookbeacon_fb)

