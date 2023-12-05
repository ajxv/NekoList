import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neko_list/providers/list_provider.dart';
import 'package:neko_list/services/mal_services.dart';
import 'package:neko_list/widgets/list_entry_card_widget.dart';
import 'package:neko_list/widgets/manga_status_update_widget.dart';
import 'package:provider/provider.dart';

import '../models/manga_info_model.dart';

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

const headingTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 17,
);

class MangaDetailPage extends StatefulWidget {
  final int mangaId;
  const MangaDetailPage({super.key, required this.mangaId});

  @override
  State<StatefulWidget> createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  late Future<MangaInfo> _futureMangaInfo;
  late MyListStatus myListStatus;
  var listStatusLoaded = false; // show floatingActionButton only if true
  late int totalChapters;

  @override
  void initState() {
    super.initState();
    _futureMangaInfo = MyAnimelistApi().getMangaInfo(mangaId: widget.mangaId);
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
        future: _futureMangaInfo.then((value) {
          setState(() {
            myListStatus = value.myListStatus ??
                MyListStatus(status: '', score: 0, numChaptersRead: 0);
            listStatusLoaded = true;
            totalChapters = value.numChapters;
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
                    mangaTitle: data.title,
                    meanScore: data.mean,
                    mediaType: data.mediaType,
                    publishingStatus: data.status,
                    numChapters: data.numChapters,
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
                  const Text(
                    "More Info",
                    style: headingTextStyle,
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
                            const Text("Authors"),
                            Text(
                              data.authors
                                  .map((e) =>
                                      "${e.node.firstName} ${e.node.lastName} (${e.role})")
                                  .toList()
                                  .join(','),
                              style: boldText,
                            )
                          ],
                        ),
                        // rowSpacer2,
                        // TableRow(
                        //   children: [
                        //     const Text("Studio"),
                        //     Text(
                        //       data.studios.isNotEmpty
                        //           ? data.studios[0].name
                        //           : '',
                        //       style: boldText,
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  // Divider(
                  //   color: Theme.of(context).colorScheme.primary,
                  //   height: 25,
                  //   thickness: 1,
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  // OP/ED
                  // if (data.openingThemes != null)
                  //   Padding(
                  //     padding: const EdgeInsets.all(15),
                  //     child: Table(
                  //       children: [
                  //         const TableRow(
                  //           children: [
                  //             Text(
                  //               "Opening Themes",
                  //               style: headingTextStyle,
                  //               textAlign: TextAlign.center,
                  //             )
                  //           ],
                  //         ),
                  //         rowSpacer1,
                  //         ...data.openingThemes!.map(
                  //           (op) => TableRow(
                  //             children: [
                  //               Text("• ${op['text']}"),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // if (data.endingThemes != null)
                  //   Padding(
                  //     padding: const EdgeInsets.all(15),
                  //     child: Table(
                  //       children: [
                  //         rowSpacer1,
                  //         const TableRow(children: [
                  //           Text(
                  //             "Ending Themes",
                  //             style: headingTextStyle,
                  //             textAlign: TextAlign.center,
                  //           )
                  //         ]),
                  //         rowSpacer1,
                  //         ...data.endingThemes!.map(
                  //           (ed) => TableRow(children: [
                  //             Text("• ${ed['text']}"),
                  //           ]),
                  //         ),
                  //         rowSpacer1,
                  //       ],
                  //     ),
                  //   ),

                  // Divider(
                  //   color: Theme.of(context).colorScheme.primary,
                  //   height: 25,
                  //   thickness: 1,
                  // ),

                  // related manga
                  if (data.relatedManga.isNotEmpty)
                    const Text(
                      "Related Manga",
                      style: headingTextStyle,
                    ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: data.relatedManga
                            .map(
                              (e) => ListEntryCard(
                                entryType: 'manga',
                                entryId: e.node.id,
                                entryTitle: e.node.title,
                                imageUrl: e.node.mainPicture.medium,
                                relationType: e.relationTypeFormatted,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),

                  // related anime
                  if (data.relatedAnime.isNotEmpty)
                    const Text(
                      "Related Anime",
                      style: headingTextStyle,
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
                                entryTitle: e.node.title,
                                imageUrl: e.node.mainPicture.medium,
                                relationType: e.relationTypeFormatted,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),

                  // reccomendations
                  if (data.recommendations.isNotEmpty)
                    const Text(
                      "Recommendations",
                      style: headingTextStyle,
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
                                entryType: 'manga',
                                entryId: e.node.id,
                                entryTitle: e.node.title,
                                imageUrl: e.node.mainPicture.medium,
                                numRecommendations: e.numRecommendations,
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
                              mangaId: widget.mangaId,
                              myListStatus: myListStatus,
                              totalChapters: totalChapters,
                            ),
                          );
                        },
                      ).whenComplete(() {
                        // reload animeinfo after update (when closing bottomSheet)
                        setState(() {
                          _futureMangaInfo = MyAnimelistApi()
                              .getMangaInfo(mangaId: widget.mangaId);
                        });
                      });
                    }
                  // condition: anime not in list
                  : () {
                      MyAnimelistApi()
                          .updateListManga(
                        mangaId: widget.mangaId,
                        status: 'plan_to_read',
                        chapsRead: 0,
                        score: 0,
                      )
                          .then((value) {
                        // refresh list
                        Provider.of<MangaListProvider>(context, listen: false)
                            .refresh('plan_to_read');
                        // show toast
                        Fluttertoast.showToast(msg: "Added to List");
                        // reload animeinfo after update
                        setState(() {
                          _futureMangaInfo = MyAnimelistApi()
                              .getMangaInfo(mangaId: widget.mangaId);
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
  final String mangaTitle;
  final String mediaType;
  final String publishingStatus;
  final double meanScore;
  final int numChapters;

  const BasicDetailSection({
    super.key,
    required this.imageUrl,
    required this.mangaTitle,
    required this.mediaType,
    required this.publishingStatus,
    required this.meanScore,
    required this.numChapters,
  });

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
                    mangaTitle,
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
                        "$numChapters chapters",
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
                        publishingStatus.replaceAll('_', ' '),
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
