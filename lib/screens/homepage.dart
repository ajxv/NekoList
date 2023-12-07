import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/session_provider.dart';
import 'search_screen.dart';
import 'home/anime_list_screen.dart';
import 'home/home_feed_screen.dart';
import 'home/manga_list_screen.dart';
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
    Provider.of<SessionProvider>(context, listen: false).fetchUser();
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
            icon: CircleAvatar(
                radius: 15,
                backgroundImage: Provider.of<SessionProvider>(context)
                        .user
                        .picture
                        .isNotEmpty
                    ? CachedNetworkImageProvider(
                        context.read<SessionProvider>().user.picture)
                    : const AssetImage("assets/images/profile_placeholder.jpeg")
                        as ImageProvider
                // NetworkImage(
                //     Provider.of<SessionProvider>(context).user.picture),
                )
            // const Icon(Icons.manage_accounts_rounded),
            ),
        title: Text(
          "ฅᨐฅ",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: NekoSearchDelgate(),
              );
            },
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
        margin: const EdgeInsets.fromLTRB(50, 0, 50, 30),
        height: 65,
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
