import 'package:flutter/material.dart';
import 'package:movie_verse/screens/favourites_Screen.dart';
import 'package:movie_verse/screens/search_screen.dart';
import 'package:movie_verse/screens/settings_page.dart';
import 'package:provider/provider.dart';
import '../helpers/api_helper.dart';
import '../models/show_models.dart';
import '../providers/favorites_provider.dart';
import '../components/show_details_page.dart';

enum ShowCategory { all, trending, popular, upcoming }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Show> shows = [];
  bool isLoading = true;
  bool isLoadingMore = false;
  ShowCategory selectedCategory = ShowCategory.all;
  int currentPage = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadShows();


    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 &&
          !isLoadingMore) {
        loadMoreShows();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> loadShows() async {
    setState(() => isLoading = true);
    try {
      shows = await ApiHelper.fetchShows(page: currentPage);
    } catch (e) {
      debugPrint("Error fetching shows: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> loadMoreShows() async {
    setState(() => isLoadingMore = true);
    currentPage++;
    try {
      List<Show> newShows = await ApiHelper.fetchShows(page: currentPage);
      if (newShows.isNotEmpty) {
        shows.addAll(newShows);
      }
    } catch (e) {
      debugPrint("Error loading more shows: $e");
    } finally {
      setState(() => isLoadingMore = false);
    }
  }

  List<Show> get filteredShows {
    switch (selectedCategory) {
      case ShowCategory.all:
        return shows;
      case ShowCategory.trending:
        return shows.take(10).toList();
      case ShowCategory.popular:
        return shows.skip(10).take(10).toList();
      case ShowCategory.upcoming:
        return shows.skip(20).take(10).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("MovieVerse"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: const Icon(Icons.movie,size: 50,),
                  ),
                  subtitle: const Text('MOVIE VERSE',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                ),
              )
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('HOME'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('SEARCH'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('SETTINGS'),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            )
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text("All"),
                    selected: selectedCategory == ShowCategory.all,
                    onSelected: (_) {
                      setState(() => selectedCategory = ShowCategory.all);
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text("Trending"),
                    selected: selectedCategory == ShowCategory.trending,
                    onSelected: (_) {
                      setState(() =>
                      selectedCategory = ShowCategory.trending);
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text("Popular"),
                    selected: selectedCategory == ShowCategory.popular,
                    onSelected: (_) {
                      setState(() =>
                      selectedCategory = ShowCategory.popular);
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text("Upcoming"),
                    selected: selectedCategory == ShowCategory.upcoming,
                    onSelected: (_) {
                      setState(() =>
                      selectedCategory = ShowCategory.upcoming);
                    },
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(8),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: filteredShows.length +
                  (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == filteredShows.length) {
                  return const Center(
                      child: CircularProgressIndicator());
                }

                final show = filteredShows[index];
                final isFav = favoritesProvider.isFavorite(show);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ShowDetailsPage(show: show),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Hero(
                              tag: 'show_${show.id}',
                              child: show.imageUrl != null
                                  ? Image.network(
                                show.imageUrl!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                                  : Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            show.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        IconButton(
                          icon: Icon(
                            isFav
                                ? Icons.favorite
                                : Icons.favorite_border,
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
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
