import 'dart:math';
import 'package:flutter/material.dart';
import 'package:neko_list/providers/list_provider.dart';
import 'package:provider/provider.dart';

import '../providers/entry_status_provider.dart';

class StatusUpdateModal extends StatelessWidget {
  final bool isAnime;
  final int entryId;
  const StatusUpdateModal({
    super.key,
    required this.isAnime,
    required this.entryId,
  });

  @override
  Widget build(BuildContext context) {
    var myListStatus = Provider.of<EntryStatusProvider>(context).myListStatus;

    onDelete() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Remove Anime',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              content: const Text(
                  'Do you want to remove this anime from your list ?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<EntryStatusProvider>().removeEntry(
                          entryId,
                          isAnime,
                          isAnime
                              ? context.read<AnimeListProvider>().refresh
                              : context.read<MangaListProvider>().refresh,
                        );
                    Navigator.of(context)
                      ..pop()
                      ..pop()
                      ..pop();
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red.shade300),
                  ),
                )
              ],
            );
          });
    }

    return Column(
      children: [
        // actions
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<EntryStatusProvider>().updateStatus(
                        entryId,
                        isAnime,
                        isAnime
                            ? context.read<AnimeListProvider>().refresh
                            : context.read<MangaListProvider>().refresh,
                      );
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.lightGreen.shade200,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListStatusSelector(
          status: myListStatus['status'],
          isAnime: isAnime,
        ),
        const SizedBox(height: 25),
        CompletionCounter(
          totalCount: myListStatus['totalCount'],
          completedCount: myListStatus['completed'],
        ),
        const SizedBox(height: 25),
        ScoreSlider(initialScore: myListStatus['score']),
        const SizedBox(height: 25),
        TextButton(
          onPressed: onDelete,
          style: ButtonStyle(
            fixedSize: const MaterialStatePropertyAll(Size(200, 10)),
            backgroundColor: MaterialStatePropertyAll(Colors.red.shade400),
          ),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class ListStatusSelector extends StatelessWidget {
  final String status;
  final bool isAnime;

  const ListStatusSelector({
    super.key,
    required this.status,
    required this.isAnime,
  });

  @override
  Widget build(BuildContext context) {
    var entryStatusProvider =
        Provider.of<EntryStatusProvider>(context, listen: false);

    // outlined button style
    ButtonStyle getOutlinedButtonStyle(buttonLabel) {
      return OutlinedButton.styleFrom(
        backgroundColor:
            status == buttonLabel ? Theme.of(context).highlightColor : null,
        foregroundColor: status == buttonLabel
            ? Theme.of(context).colorScheme.onPrimary
            : null,
        side: BorderSide(
          color: Colors.grey.shade900,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton.outlined(
            tooltip: "Current",
            onPressed: () {
              entryStatusProvider.setMyListStatus(
                  status: isAnime ? 'watching' : 'reading');
            },
            style: getOutlinedButtonStyle(isAnime ? 'watching' : 'reading'),
            icon: const Icon(
              Icons.play_circle_outline_rounded,
            ),
          ),
          IconButton.outlined(
            tooltip: "Planned",
            onPressed: () {
              entryStatusProvider.setMyListStatus(
                  status: isAnime ? 'plan_to_watch' : 'plan_to_read');
            },
            style: getOutlinedButtonStyle(
                isAnime ? 'plan_to_watch' : 'plan_to_read'),
            icon: const Icon(
              Icons.timer_outlined,
            ),
          ),
          IconButton.outlined(
            tooltip: "Completed",
            onPressed: () {
              entryStatusProvider.setMyListStatus(status: 'completed');
            },
            style: getOutlinedButtonStyle('completed'),
            icon: const Icon(
              Icons.check_circle_outline_rounded,
            ),
          ),
          IconButton.outlined(
            tooltip: "On Hold",
            onPressed: () {
              entryStatusProvider.setMyListStatus(status: 'on_hold');
            },
            style: getOutlinedButtonStyle('on_hold'),
            icon: const Icon(
              Icons.pause_circle_outline_rounded,
            ),
          ),
          IconButton.outlined(
            tooltip: "Dropped",
            onPressed: () {
              entryStatusProvider.setMyListStatus(status: 'dropped');
            },
            style: getOutlinedButtonStyle('dropped'),
            icon: const Icon(
              Icons.delete_outline_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class CompletionCounter extends StatelessWidget {
  final int totalCount;
  final int completedCount;

  final TextEditingController _controller = TextEditingController();

  CompletionCounter({
    super.key,
    required this.totalCount,
    required this.completedCount,
  });

  @override
  Widget build(BuildContext context) {
    _controller.text = completedCount.toString();
    var entryStatusProvider = context.read<EntryStatusProvider>();

    void decrement() {
      FocusScope.of(context).unfocus();
      entryStatusProvider.setMyListStatus(
          completed: max(completedCount - 1, 0));
    }

    void increment() {
      FocusScope.of(context).unfocus();
      entryStatusProvider.setMyListStatus(
          completed: totalCount != 0
              ? min(completedCount + 1, totalCount)
              : (completedCount + 1));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: (decrement), icon: const Icon(Icons.remove)),
        Container(
          width: 180,
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: TextFormField(
            readOnly: true,
            controller: _controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              labelText: 'completed',
              counterText: '',
              suffixText: '/ ${totalCount.toString()}',
            ),
            style: const TextStyle(fontSize: 15),
            maxLength: 4,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(onPressed: increment, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class ScoreSlider extends StatelessWidget {
  final int initialScore;

  const ScoreSlider({
    super.key,
    required this.initialScore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'Score: $initialScore',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Slider(
          activeColor: Theme.of(context).highlightColor,
          value: initialScore.toDouble(),
          onChanged: (value) {
            context
                .read<EntryStatusProvider>()
                .setMyListStatus(score: value.toInt());
          },
          max: 10,
          divisions: 10,
          label: initialScore.round().toString(),
        )
      ],
    );
  }
}
