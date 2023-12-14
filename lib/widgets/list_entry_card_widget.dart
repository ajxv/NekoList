import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/entry_details_screen.dart';

class ListEntryCard extends StatelessWidget {
  final bool isAnime;
  final int entryId;
  final String imageUrl;
  final String title;
  final Widget? subtitle;
  final int? userRating;
  final double? avgRating;
  final bool? isAiring;
  final int? labelMaxLines;

  const ListEntryCard({
    super.key,
    required this.isAnime,
    required this.entryId,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    this.userRating,
    this.avgRating,
    this.isAiring,
    this.labelMaxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => isAnime
                ? EntryDetailPage(
                    entryId: entryId,
                    isAnime: true,
                  )
                : EntryDetailPage(
                    entryId: entryId,
                    isAnime: false,
                  ),
          ),
        );
      },
      onLongPress: () {
        Fluttertoast.showToast(msg: title);
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 110,
          maxHeight: labelMaxLines == 2 && subtitle != null ? 230 : 210,
        ),
        child: Card(
          color: Theme.of(context).colorScheme.background,
          elevation: 0.2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // entry poster
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  children: [
                    imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            height: 150,
                            width: 115,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Image.asset(
                            "assets/images/image_placeholder.jpg",
                            height: 150,
                            width: 115,
                            fit: BoxFit.cover,
                          ),
                    // gradient shadow on image bottom
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.2)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.8, 0.99]),
                        ),
                      ),
                    ),
                    if (userRating != null)
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
                            "$userRating",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    if (avgRating != null)
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Text(
                          "★ $avgRating",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                    if (isAiring != null && isAiring!)
                      const Positioned(
                        bottom: 5,
                        left: 5,
                        child: Icon(
                          Icons.live_tv_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                child: Text(
                  title,
                  maxLines: labelMaxLines ?? 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              if (subtitle != null) subtitle!,
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
