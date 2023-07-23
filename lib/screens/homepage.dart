import 'package:flutter/material.dart';
import 'home/anime_list.dart';
import 'home/home_feed.dart';
import 'home/manga_list.dart';
import '/screens/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navSelectedIndex = 1;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _navSelectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      // AppBar on top
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Profile(),
              ),
            );
          },
          icon: const Icon(Icons.account_circle),
        ),
        title: const Text("n e k o"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),

      // Main Content
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          AnimeList(),
          HomeFeed(),
          MangaList(),
        ],
      ),

      // Bottom Navogation Bar Material 3 design
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: NavigationBar(
            selectedIndex: _navSelectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _navSelectedIndex = index;
                _pageController.jumpToPage(index);
              });
            },
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.tv_outlined),
                label: "Anime",
              ),
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.book_outlined),
                label: "Manga",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
