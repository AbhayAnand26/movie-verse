import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/api_helper.dart';
import '../models/show_models.dart';
import '../providers/favorites_provider.dart';
import '../components/show_details_page.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Show> searchResults = [];
  bool isLoading = false;
  final TextEditingController _controller = TextEditingController();

  Future<void> searchShows(String query) async {
    setState(() => isLoading = true);
    try {
      searchResults = await ApiHelper.searchShows(query);
    } catch (e) {
      debugPrint("Error searching shows: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Shows"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search shows...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => searchShows(_controller.text),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onSubmitted: searchShows,
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: Lottie.asset('assets/loading.json', width: 150, height: 150))
                : searchResults.isEmpty
                ? Center(child: Lottie.asset('assets/empty.json', width: 200, height: 200))
                : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final show = searchResults[index];
                final isFav = favoritesProvider.isFavorite(show);

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
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      if (isFav) {
                        favoritesProvider.removeFavorite(show);
                      } else {
                        favoritesProvider.addFavorite(show);
                      }
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
          ),
        ],
      ),
    );
  }
}
