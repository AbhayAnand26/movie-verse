import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../components/show_details_page.dart';
import 'package:lottie/lottie.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favoritesProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Favorites"),
      ),
      body: favorites.isEmpty
          ? Center(
        child: Lottie.asset(
          'assets/empty.json',
          width: 200,
          height: 200,
        ),
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final show = favorites[index];

          return ListTile(
            leading: Hero(
              tag: 'show_${show.id}',
              child: show.imageUrl != null
                  ? Image.network(show.imageUrl!, width: 50, fit: BoxFit.cover)
                  : Container(
                width: 50,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported),
              ),
            ),
            title: Text(show.name),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                favoritesProvider.removeFavorite(show);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowDetailsPage(show: show),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
