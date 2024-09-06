import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For converting the API response
import 'main_drawer.dart'; // Import the main drawer

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  List articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHealthArticles(); // Fetch health-related articles when the screen loads
  }

  // Function to fetch health articles from NewsAPI
  Future<void> fetchHealthArticles() async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=health&country=us&apiKey=bdd282e938bf412db1b2fcbc142f74e6'); // Your API key

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          articles = data['articles'];
          isLoading = false;
        });
      } else {
        print('Failed to load articles');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Articles'),
        backgroundColor: Colors.teal[100],
        foregroundColor: Colors.teal[900],
      ),
      drawer: MainDrawer(firstName: 'User'),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner while fetching
          : articles.isEmpty
          ? Center(child: Text('No articles available.'))
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ArticleCard(article: article); // Improved Article UI
        },
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final Map article;

  const ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailScreen(article: article),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article['title'] ?? 'No Title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                article['description'] ?? 'No Description',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 10),
              Text(
                article['publishedAt'] != null
                    ? 'Published on: ${article['publishedAt'].substring(0, 10)}'
                    : '',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleDetailScreen extends StatelessWidget {
  final Map article;

  const ArticleDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title'] ?? 'Article'),
        backgroundColor: Colors.teal[100],
        foregroundColor: Colors.teal[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article['urlToImage'] != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article['urlToImage'],
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 16),
              Text(
                article['title'] ?? 'No Title',
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 16),
              Text(
                article['content'] ?? 'Content not available',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 16),
              Text(
                'Read more at: ${article['url'] ?? ''}',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
