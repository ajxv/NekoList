import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neko_list/providers/session_provider.dart';
import 'package:neko_list/screens/settings_screen.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Consumer<SessionProvider>(builder: (context, value, child) {
        return ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              child: ClipOval(
                child: value.user.picture.isNotEmpty
                    ? CachedNetworkImage(imageUrl: value.user.picture)
                    : Image.asset("assets/images/profile_placeholder.jpeg"),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              value.user.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              value.user.id.toString(),
              textAlign: TextAlign.center,
            ),
            if (value.user.animeStatistics.isNotEmpty)
              UserAnimeStatsOverview(
                  animeStatistics: value.user.animeStatistics),
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }
}

class UserAnimeStatsOverview extends StatelessWidget {
  final Map<String, double> animeStatistics;
  const UserAnimeStatsOverview({super.key, required this.animeStatistics});

  @override
  Widget build(BuildContext context) {
    // define vertical divider
    VerticalDivider vdivider = VerticalDivider(
      width: 20,
      thickness: 1,
      indent: 10,
      endIndent: 10,
      color: Colors.grey.shade800,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Theme.of(context).colorScheme.background,
              elevation: 0,
              child: SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.done_all_rounded),
                    Text(
                      '${animeStatistics['num_episodes']!.toInt()}',
                    ),
                    const Text('Episodes'),
                  ],
                ),
              ),
            ),
            vdivider,
            Card(
              color: Theme.of(context).colorScheme.background,
              elevation: 0,
              child: SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.tv_rounded),
                    Text(
                      '${animeStatistics['num_items_completed']!.toInt()}',
                    ),
                    const Text('Anime'),
                  ],
                ),
              ),
            ),
            vdivider,
            Card(
              color: Theme.of(context).colorScheme.background,
              elevation: 0,
              child: SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.thumb_up_alt_rounded),
                    Text(
                      '${animeStatistics['mean_score']!.toInt()}',
                    ),
                    const Text('Mean Score'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
