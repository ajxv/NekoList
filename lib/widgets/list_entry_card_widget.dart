import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neko_list/screens/anime_details_screen.dart';
import 'package:neko_list/screens/manga_details_screen.dart';

class ListEntryCard extends StatelessWidget {
  final String entryType;
  final int entryId;
  final String entryTitle;
  final String imageUrl;
  final int? numCompleted;
  final int? numTotal;
  final int? rating;
  // for related entry
  final String? relationType;
  // for recommendation
  final int? numRecommendations;
  final int? labelMaxLines;

  const ListEntryCard({
    super.key,
    required this.entryType,
    required this.entryId,
    required this.entryTitle,
    required this.imageUrl,
    this.numCompleted,
    this.numTotal,
    this.rating,
    this.relationType,
    this.numRecommendations,
    this.labelMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => entryType == 'anime'
                ? AnimeDetailPage(animeId: entryId)
                : MangaDetailPage(mangaId: entryId),
          ),
        );
      },
      onLongPress: () {
        Fluttertoast.showToast(msg: entryTitle);
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 110,
          maxHeight: 230,
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // entry poster
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: Stack(
                  children: [
                    imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            height: 150,
                            width: 115,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/image_placeholder.jpg",
                            height: 150,
                            width: 115,
                            fit: BoxFit.cover,
                          ),
                    if (rating != null)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          width: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black54),
                          child: Text(
                            "$rating",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                child: Text(
                  entryTitle,
                  maxLines: labelMaxLines ?? 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              if (relationType != null)
                Text(
                  "(${relationType!})",
                  style: const TextStyle(
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (numRecommendations != null)
                Wrap(
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
                      numRecommendations.toString(),
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              if (numCompleted != null)
                Text(
                  "$numCompleted/${numTotal != 0 ? numTotal : '?'}",
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder Widget
class ListEntryCardPlaceholder extends StatelessWidget {
  const ListEntryCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      // set opacity
      opacity: 0.1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 124,
          maxHeight: 210,
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                height: 150,
                width: 115,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// for search display
class SimpleListEntryCard extends StatelessWidget {
  final String contentType;
  final int entryId;
  final String entryTitle;
  final String imageUrl;

  const SimpleListEntryCard({
    super.key,
    required this.contentType,
    required this.entryId,
    required this.entryTitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => contentType == 'anime'
                ? AnimeDetailPage(
                    animeId: entryId,
                  )
                : MangaDetailPage(
                    mangaId: entryId,
                  ),
          ),
        );
      },
      onLongPress: () {
        Fluttertoast.showToast(msg: entryTitle);
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 124,
          maxHeight: 210,
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        height: 150,
                        width: 115,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/image_placeholder.jpg",
                        height: 150,
                        width: 115,
                        fit: BoxFit.cover,
                      ),
              ),
              Expanded(
                  child: Center(
                child: Text(
                  entryTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
