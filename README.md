<h2 align="left">BookBeacon</h2>
<h3 align="left">Where stories shine, BookBeacon leads the way.</h3>

<img src="https://firebasestorage.googleapis.com/v0/b/abis-bookbeacon.appspot.com/o/boobkbeacon-desktop.png?alt=media&token=d32591ea-6e8e-4a67-b1b3-d5876f5d21a3" alt="BookBeacon">

<img src="https://firebasestorage.googleapis.com/v0/b/abis-bookbeacon.appspot.com/o/boobkbeacon-desktop-2.png?alt=media&token=d5b13d2a-7ce9-4906-944b-7d09f2d53a74" alt="BookBeacon">

<img src="https://firebasestorage.googleapis.com/v0/b/abis-bookbeacon.appspot.com/o/boobkbeacon-mobile.png?alt=media&token=174ccdea-c7b4-4e96-bedb-40bcc5dae6f4" alt="BookBeacon">

This project is a book recommendation service that suggests books based on a user's inputted genre and book titles. It's built upon a database of 7000 books retrieved from Kaggle. Using Ada v2 as the large language model, vector embeddings were created with the Kaggle dataset to allow for quick vector search to find semantically similar books through natural language input. The frontend is built using Dart & Flutter.

Features
Input genre and book titles to get book recommendations
Vector Search on Weaviate Vector database of 7000 books
Cross-platform User Interface, thanks to Flutter
Python, Flask are used for handling backend (API gateway service)
Python is used for building the recommendation service (handling the semantic search)

Future scale:
The project is built upon microservice architecture, hence it can be easily scale to a high robust system by implementing more funcctionality and deploying the services, 

Referrences:

Weaviate Documentation URL: https://weaviate.io/?utm_source=google&utm_medium=cpc&utm_campaign=17432327206&utm_content=142705996452&utm_term=weaviate%20vector&gclid=CjwKCAiAx_GqBhBQEiwAlDNAZoJ9RJTyEF-BpuGM6xwVTrdA4FlZnupyWM3LTQfUqS4gJ9QoD7IsMBoCPnQQAvD_BwE

Books datasets URL: https://www.kaggle.com/datasets/dylanjcastillo/7k-books-with-metadata
