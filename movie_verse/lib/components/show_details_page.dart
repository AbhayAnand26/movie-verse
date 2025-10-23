import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/show_models.dart';
import '../providers/favorites_provider.dart';

class ShowDetailsPage extends StatelessWidget {
  final Show show;
  const ShowDetailsPage({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFav = favoritesProvider.isFavorite(show);

    return Scaffold(
      appBar: AppBar(
        title: Text(show.name),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.red),
            onPressed: () {
              if (isFav) {
                favoritesProvider.removeFavorite(show);
              } else {
                favoritesProvider.addFavorite(show);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'show_${show.id}',
              child: show.imageUrl != null
                  ? Image.network(show.imageUrl!)
                  : Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              show.name,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (show.genres.isNotEmpty)
              Text(
                "Genres: ${show.genres.join(', ')}",
                style: const TextStyle(fontSize: 16),
              ),
            if (show.rating != null)
              Text(
                "Rating: ${show.rating}",
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 16),
            if (show.summary != null)
              Text(
                show.summary!,
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
