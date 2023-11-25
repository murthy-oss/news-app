// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: const NewsList(),
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use a ListView.builder to display the news items
    return ListView.builder(
      itemCount: 10, // Replace with the actual number of news articles
      itemBuilder: (context, index) {
        return NewsCard(
          title: 'News Title $index',
          description: 'This is a sample news description.',
          imageUrl: 'https://placekitten.com/200/200',
          articleUrl: 'https://example.com/article$index',
        );
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String articleUrl;

  const NewsCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.articleUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailView(
                    title: title,
                    description: description,
                    imageUrl: imageUrl,
                    articleUrl: articleUrl,
                  ),
                ),
              );
            },
            child: Image.network(
              imageUrl,
              height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FavoriteButton(articleUrl: articleUrl),
            ],
          ),
        ],
      ),
    );
  }
}

class NewsDetailView extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String articleUrl;

  const NewsDetailView({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.articleUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            height: 150.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InAppWebViewPage(articleUrl: articleUrl),
                  ),
                );
              },
              child: Text('Read Full Article'),
            ),
          ),
        ],
      ),
    );
  }
}

class InAppWebViewPage extends StatelessWidget {
  final String articleUrl;

   InAppWebViewPage({required this.articleUrl});
WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
      
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://flutter.dev'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Article'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  final String articleUrl;

  const FavoriteButton({required this.articleUrl});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });

        FirebaseFirestore.instance
            .collection('favorites')
            .doc(widget.articleUrl)
            .set({
          'isFavorite': isFavorite,
        });
      },
    );
  }
}
