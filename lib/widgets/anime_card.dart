import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neko_list/widgets/anime_detail.dart';

class AnimeCard extends StatelessWidget {
  final int animeId;
  final String animeTitle;
  final String imageUrl;
  final int numEpsWatched;
  final int numEpisodes;
  final int rating;

  const AnimeCard({
    super.key,
    required this.animeId,
    required this.animeTitle,
    required this.imageUrl,
    required this.numEpsWatched,
    required this.numEpisodes,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AnimeDetailPage(),
          ),
        );
      },
      onLongPress: () {
        Fluttertoast.showToast(msg: animeTitle);
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
                  child: Stack(
                    children: [
                      Image.network(
                        imageUrl,
                        height: 150,
                        width: 115,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            width: 25,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black54),
                            child: Text(
                              "$rating",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ))
                    ],
                  )),
              Text(
                animeTitle,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "$numEpsWatched/$numEpisodes",
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder Widget
class AnimeCardPlaceholder extends StatelessWidget {
  const AnimeCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      // set opacity
      opacity: 0.2,
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
                color: Colors.grey.shade400,
              ),
              Expanded(
                  child: Container(
                color: Colors.grey.shade600,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
