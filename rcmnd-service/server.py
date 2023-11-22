import os
import weaviate
from flask import Flask, request

# from dotenv import load_dotenv

# load_dotenv()


app = Flask(__name__)

@app.route('/search', methods=['POST'])
def recommend():

    try:
        queryText = request.json['query-text']
        if not queryText:
            return 'Invalid request', 401
        
        queryList = queryText.split(',')

        response = requestRecommendation(queryList)

        return response
    
    except:
        return 'Invalid credentials', 401

def requestRecommendation(query):
    WEAVIATE_CLUSTER_URL = os.getenv('WEAVIATE_CLUSTER_URL')
    WEAVIATE_API_KEY = os.getenv('WEAVIATE_API_KEY') 
    OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')
    COHERE_API_KEY = os.getenv('COHERE_API_KEY')
    client = weaviate.Client(
        url=WEAVIATE_CLUSTER_URL,
        auth_client_secret=weaviate.AuthApiKey(api_key=WEAVIATE_API_KEY),
        additional_headers={"X-OpenAI-Api-Key": OPENAI_API_KEY, "X-Cohere-Api-Key": COHERE_API_KEY})

    nearText = {
        "concepts":
        query
    }

    generate_prompt = "Explain why this book might be interesting to someone who likes playing the violin, rock climbing, and doing yoga. the book's title is {title}, with a description: {description}, and is in the genre: {categories}."
    
    try:
        response = (client.query.get("Book", [
            "title",
            "isbn10",
            "isbn13",
            "categories",
            "thumbnail",
            "description",
            "num_pages",
            "average_rating",
            "ratings_count",
            "published_year",
            "authors",
        ]).with_generate(single_prompt=generate_prompt).with_near_text(nearText).with_limit(10).do())
    except:
        return 'Server error', 500
    books = response['data']['Get']['Book']
    if not books:
        return 'Server error', 500
    return books, 200

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)