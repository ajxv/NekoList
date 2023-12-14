import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../services/mal_services.dart';
import '../widgets/list_entry_card_widget.dart';
import '../providers/entry_status_provider.dart';
import '../providers/list_provider.dart';
import '../widgets/status_update_widget.dart';

const rowSpacer = TableRow(children: [
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

class EntryDetailPage extends StatefulWidget {
  final int entryId;
  final bool isAnime;

  const EntryDetailPage({
    super.key,
    required this.entryId,
    required this.isAnime,
  });

  @override
  State<StatefulWidget> createState() => _EntryDetailPageState();
}

class _EntryDetailPageState extends State<EntryDetailPage> {
  late Future _futureEntryInfo;
  late dynamic _myListStatus;
  late int _totalCount;

  bool _isLoading = true; // show floatingActionButton only if true

  @override
  void initState() {
    super.initState();
    _futureEntryInfo = widget.isAnime
        ? MyAnimelistApi().getAnimeInfo(animeId: widget.entryId).then((data) {
            setState(() {
              _isLoading = false;
              _myListStatus = data.myListStatus;
              _totalCount = data.numEpisodes;
            });
            return data;
          })
        : MyAnimelistApi().getMangaInfo(mangaId: widget.entryId).then((data) {
            setState(() {
              _isLoading = false;
              _myListStatus = data.myListStatus;
              _totalCount = data.numChapters;
            });
            return data;
          });
  }

  void _reload() {
    // reload screen
    setState(() {
      _futureEntryInfo = widget.isAnime
          ? MyAnimelistApi().getAnimeInfo(animeId: widget.entryId).then((data) {
              setState(() {
                _isLoading = false;
                _myListStatus = data.myListStatus;
                _totalCount = data.numEpisodes;
              });
              return data;
            })
          : MyAnimelistApi().getMangaInfo(mangaId: widget.entryId).then((data) {
              setState(() {
                _isLoading = false;
                _myListStatus = data.myListStatus;
                _totalCount = data.numChapters;
              });
              return data;
            });
    });
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
      ),
      body: FutureBuilder(
        future: _futureEntryInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var entryDetails = snapshot.data!;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  // basic details
                  BasicDetailSection(
                    imageUrl: entryDetails.mainPicture.large,
                    animeTitle: entryDetails.title,
                    mediaType: entryDetails.mediaType,
                    airingStatus: entryDetails.status,
                    meanScore: entryDetails.mean,
                    totalCount: widget.isAnime
                        ? entryDetails.numEpisodes
                        : entryDetails.numChapters,
                    countLabel: widget.isAnime ? "episodes" : "chapters",
                  ),
                  // tags
                  TagsSection(
                    genres: entryDetails.genres,
                  ),
                  // synopsis
                  DescriptionTextWidget(
                    text: entryDetails.synopsis,
                  ),
                  // more info
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
                              entryDetails.alternativeTitles.synonyms
                                  .join(',\n'),
                              style: boldText,
                            )
                          ],
                        ),
                        rowSpacer,
                        TableRow(
                          children: [
                            const Text("English"),
                            Text(
                              entryDetails.alternativeTitles.en,
                              style: boldText,
                            )
                          ],
                        ),
                        rowSpacer,
                        TableRow(
                          children: [
                            const Text("Japanese"),
                            Text(
                              entryDetails.alternativeTitles.ja,
                              style: boldText,
                            )
                          ],
                        ),
                        rowSpacer,
                        TableRow(
                          children: [
                            const Text("Start Date"),
                            Text(
                              entryDetails.startDate.toString().split(' ')[0],
                              style: boldText,
                            )
                          ],
                        ),
                        rowSpacer,
                        TableRow(
                          children: [
                            const Text("End Date"),
                            Text(
                              entryDetails.endDate.toString().split(' ')[0],
                              style: boldText,
                            )
                          ],
                        ),
                        // more anime specific details
                        if (widget.isAnime) ...[
                          rowSpacer,
                          TableRow(
                            children: [
                              const Text("Season"),
                              Text(
                                entryDetails.startSeason != null
                                    ? "${entryDetails.startSeason!.season.toUpperCase()} ${entryDetails.startSeason!.year}"
                                    : "",
                                style: boldText,
                              )
                            ],
                          ),
                          rowSpacer,
                          TableRow(
                            children: [
                              const Text("Duration"),
                              Text(
                                "${(entryDetails.averageEpisodeDuration / 60).round().toString()} min",
                                style: boldText,
                              )
                            ],
                          ),
                          rowSpacer,
                          TableRow(
                            children: [
                              const Text("Source"),
                              Text(
                                entryDetails.source == null
                                    ? ''
                                    : entryDetails.source!.replaceAll('_', ' '),
                                style: boldText,
                              )
                            ],
                          ),
                          rowSpacer,
                          TableRow(
                            children: [
                              const Text("Studio"),
                              Text(
                                entryDetails.studios.isNotEmpty
                                    ? entryDetails.studios[0].name
                                    : '',
                                style: boldText,
                              )
                            ],
                          ),
                        ]
                        // more manga specific details
                        else ...[
                          rowSpacer,
                          TableRow(
                            children: [
                              const Text("Authors"),
                              Text(
                                entryDetails.authors
                                    .map((e) =>
                                        "${e.node.firstName} ${e.node.lastName} (${e.role})")
                                    .toList()
                                    .join(','),
                                style: boldText,
                              )
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // OP/ED
                  if (widget.isAnime && entryDetails.openingThemes != null) ...[
                    Text(
                      "Opening Themes",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    DescriptionTextWidget(
                      text: entryDetails.openingThemes!
                          .map((op) => op['text'])
                          .join('\n'),
                    ),
                  ],

                  if (widget.isAnime && entryDetails.endingThemes != null) ...[
                    Text(
                      "Ending Themes",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    DescriptionTextWidget(
                      text: entryDetails.endingThemes!
                          .map((ed) => ed['text'])
                          .join('\n'),
                    ),
                  ],
                  // related anime
                  if (entryDetails.relatedAnime.isNotEmpty) ...[
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
                          children: entryDetails.relatedAnime
                              .map<Widget>(
                                (e) => ListEntryCard(
                                  isAnime: true,
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
                  ],

                  // related manga
                  if (entryDetails.relatedManga.isNotEmpty) ...[
                    Text(
                      "Related Manga",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: entryDetails.relatedManga
                              .map<Widget>(
                                (e) => ListEntryCard(
                                  isAnime: false,
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
                  ],

                  // reccomendations
                  if (entryDetails.recommendations.isNotEmpty) ...[
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
                          children: entryDetails.recommendations
                              .map<Widget>(
                                (e) => ListEntryCard(
                                  isAnime: widget.isAnime,
                                  entryId: e.node.id,
                                  title: e.node.title,
                                  imageUrl: e.node.mainPicture.medium,
                                  subtitle: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
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
      floatingActionButton: _isLoading
          ? const SizedBox()
          : FloatingActionButton(
              onPressed: () {
                if (_myListStatus == null) {
                  // add to list
                  context.read<EntryStatusProvider>().setMyListStatus(
                        status:
                            widget.isAnime ? 'plan_to_watch' : 'plan_to_read',
                        score: 0,
                        completed: 0,
                      );
                  context.read<EntryStatusProvider>().updateStatus(
                        widget.entryId,
                        widget.isAnime,
                        widget.isAnime
                            ? context.read<AnimeListProvider>().refresh
                            : context.read<MangaListProvider>().refresh,
                      );

                  // reload animeinfo after update
                  _reload();
                } else {
                  context.read<EntryStatusProvider>().loadListStatus(
                      widget.isAnime, _myListStatus, _totalCount);
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 400,
                        child: StatusUpdateModal(
                          isAnime: widget.isAnime,
                          entryId: widget.entryId,
                        ),
                      );
                    },
                  ).whenComplete(() {
                    // reload animeinfo after update (when closing bottomSheet)
                    _reload();
                  });
                }
              },
              child: _myListStatus == null
                  ? const Icon(Icons.add)
                  : const Icon(Icons.edit),
            ),
    );
  }
}

class BasicDetailSection extends StatelessWidget {
  final String imageUrl;
  final String animeTitle;
  final String mediaType;
  final String airingStatus;
  final double meanScore;
  final int totalCount;
  final String countLabel;

  const BasicDetailSection({
    super.key,
    required this.imageUrl,
    required this.animeTitle,
    required this.mediaType,
    required this.airingStatus,
    required this.meanScore,
    required this.totalCount,
    required this.countLabel,
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
                  GestureDetector(
                    onLongPress: () async {
                      await Clipboard.setData(ClipboardData(text: animeTitle));
                      Fluttertoast.showToast(msg: "Title copied to clipboard");
                    },
                    child: Text(
                      animeTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                        "${totalCount == 0 ? '?' : totalCount} $countLabel",
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
      alignment: Alignment.centerLeft,
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
