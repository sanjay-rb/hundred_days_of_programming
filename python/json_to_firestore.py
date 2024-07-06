import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import json

# Initialize Firebase Admin SDK
cred = credentials.Certificate("/Users/sanjayrb/projects/hundred_days_of_programming/serviceAccountKey.json")
firebase_admin.initialize_app(cred)


# Initialize Firestore client
db = firestore.client()

# Example JSON data
with open("/Users/sanjayrb/projects/hundred_days_of_programming/user.json") as f:
    json_data = f.read()

# Convert JSON string to Python dictionary
data = json.loads(json_data)

# Upload data to Firestore
for collection, docs in data.items():
    for doc_id, doc_data in docs.items():
        doc_ref = db.collection(collection).document(doc_id)
        doc_ref.set(doc_data)

print("Data uploaded to Firestore successfully.")
