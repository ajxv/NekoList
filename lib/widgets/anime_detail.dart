import 'package:flutter/material.dart';

class AnimeDetailPage extends StatefulWidget {
  const AnimeDetailPage({super.key});

  @override
  State<StatefulWidget> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Basic Details with image
            const BasicDetailSection(),
            // Tags
            TagsSection(),
            // Summary

            // More info
            // related anime
            // reccomendations
          ],
        ),
      ),
    );
  }
}

class BasicDetailSection extends StatelessWidget {
  const BasicDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network(
              'https://cdn.myanimelist.net/r/192x272/images/anime/10/75262.webp?s=554fe4e72985b0e67b8b3c290f3a228a',
              height: 200,
              width: 130,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 5, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mob Psycho 100 II",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 9),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.movie),
                    SizedBox(width: 10),
                    Text(
                      "TV",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 9),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.timer),
                    SizedBox(width: 10),
                    Text(
                      "12 episodes",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 9),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.signal_cellular_alt),
                    SizedBox(width: 10),
                    Text(
                      "Airing",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 9),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.star),
                    SizedBox(width: 10),
                    Text(
                      "8.0",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TagsSection extends StatelessWidget {
  final List<String> _tags = [
    'comedy',
    'action',
    'thriller',
    'drama',
    'fantasy'
  ];

  TagsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: _tags
              .map((genre) => Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Chip(
                      label: Text(genre),
                      padding: const EdgeInsets.all(5),
                    ),
                  ))
              .toList()),
    );
  }
}
