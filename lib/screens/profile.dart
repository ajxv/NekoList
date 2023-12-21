import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neko_list/providers/session_provider.dart';
import 'package:neko_list/screens/settings_screen.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<SessionProvider>().fetchUser();
          },
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: value.user.picture.isNotEmpty
                        ? CachedNetworkImageProvider(value.user.picture)
                        : const AssetImage(
                                "assets/images/profile_placeholder.jpeg")
                            as ImageProvider,
                    fit: BoxFit.contain,
                  ),
                  shape: BoxShape.circle,
                ),
                height: 150,
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
              // Text(
              //   value.user.id.toString(),
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(height: 15),

              if (value.user.animeStatistics.isNotEmpty)
                UserAnimeStatsOverview(
                    animeStatistics: value.user.animeStatistics),
              const SizedBox(height: 10),
              if (value.user.animeStatistics.isNotEmpty) ...[
                Divider(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.1),
                  indent: 30,
                  endIndent: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
                  child: Text(
                    "Anime Stats",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                  child: SizedBox(
                    height: 200,
                    child: PieChart(
                      dataMap: value.animeStat,
                      chartType: ChartType.ring,
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValues: false,
                      ),
                      centerText:
                          "Total: ${value.user.animeStatistics['num_items']!.toInt()}",
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.1),
                  indent: 30,
                  endIndent: 30,
                ),
              ],
              IconButton(
                onPressed: () {
                  Share.share(
                      "https://myanimelist.net/profile/${value.user.name}");
                },
                icon: const Icon(
                  Icons.share,
                  size: 20,
                ),
              ),
            ],
          ),
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
