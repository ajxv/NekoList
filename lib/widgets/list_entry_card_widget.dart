import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neko_list/screens/anime_details_screen.dart';

class ListEntryCard extends StatelessWidget {
  final int animeId;
  final String animeTitle;
  final String imageUrl;
  final int? numEpsWatched;
  final int? numEpisodes;
  final int? rating;
  // for related anime
  final String? relationType;
  // for recommendation
  final int? numRecommendations;
  final int? labelMaxLines;

  const ListEntryCard({
    super.key,
    required this.animeId,
    required this.animeTitle,
    required this.imageUrl,
    this.numEpsWatched,
    this.numEpisodes,
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
            builder: (context) => AnimeDetailPage(
              animeId: animeId,
            ),
          ),
        );
      },
      onLongPress: () {
        Fluttertoast.showToast(msg: animeTitle);
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
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Image.network(
                      imageUrl,
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
                  animeTitle,
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
              if (numEpsWatched != null)
                Text(
                  "$numEpsWatched/${numEpisodes != 0 ? numEpisodes : '?'}",
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
                : const Text("not an anime"),
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
