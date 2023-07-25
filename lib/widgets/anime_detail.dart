import 'package:flutter/material.dart';
import 'package:neko_list/services/mal_services.dart';

import '../models/anime_info.dart';

class AnimeDetailPage extends StatefulWidget {
  final int animeId;
  const AnimeDetailPage({super.key, required this.animeId});

  @override
  State<StatefulWidget> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  late Future<AnimeInfo> _futureAnimeInfo;

  @override
  void initState() {
    super.initState();
    _futureAnimeInfo = MyAnimelistApi().getAnimeInfo(animeId: widget.animeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.chevron_left),
          ),
        ),
        body: FutureBuilder(
          future: _futureAnimeInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Basic Details with image
                    BasicDetailSection(
                      imageUrl: data.mainPicture.large,
                      animeTitle: data.title,
                      meanScore: data.mean,
                      mediaType: data.mediaType,
                      airingStatus: data.status,
                      numEpisodes: data.numEpisodes,
                    ),
                    // Tags
                    TagsSection(
                      genres: data.genres,
                    ),
                    // Summary
                    DescriptionTextWidget(
                      text: data.synopsis,
                    ),
                    // More info
                    // related anime
                    // reccomendations
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              // By default, show a loading spinner.
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class BasicDetailSection extends StatelessWidget {
  final String imageUrl;
  final String animeTitle;
  final String mediaType;
  final String airingStatus;
  final double meanScore;
  final int numEpisodes;

  const BasicDetailSection(
      {super.key,
      required this.imageUrl,
      required this.animeTitle,
      required this.mediaType,
      required this.airingStatus,
      required this.meanScore,
      required this.numEpisodes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network(
              imageUrl,
              height: 200,
              width: 130,
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    animeTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(Icons.movie),
                      const SizedBox(width: 10),
                      Text(
                        mediaType.toUpperCase(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(Icons.timer),
                      const SizedBox(width: 10),
                      Text(
                        "$numEpisodes episodes",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(Icons.signal_cellular_alt),
                      const SizedBox(width: 10),
                      Text(
                        airingStatus.replaceAll('_', ' '),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(Icons.star),
                      const SizedBox(width: 10),
                      Text(
                        meanScore.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TagsSection extends StatelessWidget {
  final List genres;

  const TagsSection({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: genres
            .map((genre) => Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Chip(
                    label: Text(genre.name),
                    padding: const EdgeInsets.all(5),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget({super.key, required this.text});

  @override
  State<DescriptionTextWidget> createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 300) {
      firstHalf = widget.text.substring(0, 300);
      secondHalf = widget.text.substring(300, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: <Widget>[
                Text(flag ? ("$firstHalf...") : (firstHalf + secondHalf)),
                InkWell(
                  splashColor: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        flag
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
