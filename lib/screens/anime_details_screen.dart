import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neko_list/services/mal_services.dart';
import 'package:neko_list/widgets/list_entry_card_widget.dart';
import 'package:neko_list/widgets/anime_status_update_widget.dart';
import 'package:provider/provider.dart';

import '../models/anime_info_model.dart';
import '../providers/list_provider.dart';

const rowSpacer1 = TableRow(children: [
  SizedBox(
    height: 10,
  )
]);

const rowSpacer2 = TableRow(children: [
  SizedBox(
    height: 10,
  ),
  SizedBox(
    height: 10,
  )
]);

const boldText = TextStyle(
  fontWeight: FontWeight.w500,
);

class AnimeDetailPage extends StatefulWidget {
  final int animeId;
  const AnimeDetailPage({super.key, required this.animeId});

  @override
  State<StatefulWidget> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  late Future<AnimeInfo> _futureAnimeInfo;
  late MyListStatus myListStatus;
  var listStatusLoaded = false; // show floatingActionButton only if true
  late int totalEpisodes;

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
        future: _futureAnimeInfo.then((value) {
          setState(() {
            myListStatus = value.myListStatus ??
                MyListStatus(status: '', score: 0, numEpisodesWatched: 0);
            listStatusLoaded = true;
            totalEpisodes = value.numEpisodes;
          });
          return value;
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 30),
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
                  Text(
                    "More Info",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            const Text("Synonyms"),
                            Text(
                              data.alternativeTitles.synonyms.join(',\n'),
                              style: boldText,
                            )
                          ],
                        ),
                        rowSpacer2,
                        TableRow(
                          children: [
                            const Text("English"),
                            Text(
                              data.alternativeTitles.en,
                              style: boldText,
                            )
                          ],
                        ),
                        rowSpacer2,
                        TableRow(
                          children: [
                            const Text("Japanese"),
                            Text(
                              data.alternativeTitles.ja,
                              style: boldText,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            const Text("Start Date"),
                            Text(
                              data.startDate.toString().split(' ')[0],
                              style: boldText,
                            )
                          ],
                        ),
                        rowSpacer2,
                        TableRow(
                          children: [
                            const Text("End Date"),
                            Text(
                              data.endDate.toString().split(' ')[0],
                              style: boldText,
                            )
                          ],
                        ),
                        rowSpacer2,
                        TableRow(
                          children: [
                            const Text("Season"),
                            Text(
                              data.startSeason != null
                                  ? "${data.startSeason!.season.toUpperCase()} ${data.startSeason!.year}"
                                  : "",
                              style: boldText,
                            )
                          ],
                        ),
                        rowSpacer2,
                        TableRow(
                          children: [
                            const Text("Duration"),
                            Text(
                              "${(data.averageEpisodeDuration / 60).round().toString()} min",
                              style: boldText,
                            )
                          ],
                        ),
                        rowSpacer2,
                        TableRow(
                          children: [
                            const Text("Source"),
                            Text(
                              data.source == null
                                  ? ''
                                  : data.source!.replaceAll('_', ' '),
                              style: boldText,
                            )
                          ],
                        ),
                        rowSpacer2,
                        TableRow(
                          children: [
                            const Text("Studio"),
                            Text(
                              data.studios.isNotEmpty
                                  ? data.studios[0].name
                                  : '',
                              style: boldText,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // OP/ED
                  if (data.openingThemes != null)
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              Text(
                                "Opening Themes",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          rowSpacer1,
                          ...data.openingThemes!.map(
                            (op) => TableRow(
                              children: [
                                Text("• ${op['text']}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (data.endingThemes != null)
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Table(
                        children: [
                          rowSpacer1,
                          TableRow(children: [
                            Text(
                              "Ending Themes",
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            )
                          ]),
                          rowSpacer1,
                          ...data.endingThemes!.map(
                            (ed) => TableRow(children: [
                              Text("• ${ed['text']}"),
                            ]),
                          ),
                          rowSpacer1,
                        ],
                      ),
                    ),

                  // related anime
                  if (data.relatedAnime.isNotEmpty)
                    Text(
                      "Related Anime",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: data.relatedAnime
                            .map(
                              (e) => ListEntryCard(
                                entryType: 'anime',
                                entryId: e.node.id,
                                title: e.node.title,
                                imageUrl: e.node.mainPicture.medium,
                                subtitle: Text(
                                  "(${e.relationTypeFormatted})",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),

                  // reccomendations
                  if (data.recommendations.isNotEmpty)
                    Text(
                      "Recommendations",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: data.recommendations
                            .map(
                              (e) => ListEntryCard(
                                entryType: 'anime',
                                entryId: e.node.id,
                                title: e.node.title,
                                imageUrl: e.node.mainPicture.medium,
                                subtitle: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.thumbs_up_down_rounded,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      e.numRecommendations.toString(),
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
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
      ),
      floatingActionButton: listStatusLoaded
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              // add anime to list if not already on list else open edit modal
              onPressed: myListStatus.status != ''
                  // condition: anime already on list
                  ? () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 400,
                            child: StatusUpdateModal(
                              animeId: widget.animeId,
                              myListStatus: myListStatus,
                              totalEpisodes: totalEpisodes,
                            ),
                          );
                        },
                      ).whenComplete(() {
                        // reload animeinfo after update (when closing bottomSheet)
                        setState(() {
                          _futureAnimeInfo = MyAnimelistApi()
                              .getAnimeInfo(animeId: widget.animeId);
                        });
                      });
                    }
                  // condition: anime not in list
                  : () {
                      MyAnimelistApi()
                          .updateListAnime(
                        animeId: widget.animeId,
                        status: 'plan_to_watch',
                        epsWatched: 0,
                        score: 0,
                      )
                          .then((value) {
                        // refresh list
                        Provider.of<AnimeListProvider>(context, listen: false)
                            .refresh('plan_to_watch');
                        // show toast
                        Fluttertoast.showToast(msg: "Added to List");
                        // reload animeinfo after update
                        setState(() {
                          _futureAnimeInfo = MyAnimelistApi()
                              .getAnimeInfo(animeId: widget.animeId);
                        });
                      });
                    },
              child: myListStatus.status == ''
                  ? const Icon(Icons.add)
                  : const Icon(Icons.mode_edit_outline_rounded),
            )
          : const SizedBox(),
    );
  }
}

class BasicDetailSection extends StatelessWidget {
  final String imageUrl;
  final String animeTitle;
  final String mediaType;
  final String airingStatus;
  final double meanScore;
  final int numEpisodes;

  const BasicDetailSection({
    super.key,
    required this.imageUrl,
    required this.animeTitle,
    required this.mediaType,
    required this.airingStatus,
    required this.meanScore,
    required this.numEpisodes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 200,
                    width: 130,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image.asset(
                    "assets/images/image_placeholder.jpg",
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
                        "${numEpisodes == 0 ? '?' : numEpisodes} episodes",
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
    return Align(
      alignment: genres.length > 4 ? Alignment.centerLeft : Alignment.center,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 10),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: genres
              .map((genre) => Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Chip(
                      label: Text(genre.name),
                      padding: const EdgeInsets.all(5),
                    ),
                  ))
              .toList(),
        ),
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
