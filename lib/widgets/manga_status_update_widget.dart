import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neko_list/models/manga_info_model.dart';
import 'package:neko_list/services/mal_services.dart';

class StatusUpdateModal extends StatefulWidget {
  final MyListStatus myListStatus;
  final int mangaId;
  final int totalChapters;

  const StatusUpdateModal({
    super.key,
    required this.mangaId,
    required this.myListStatus,
    required this.totalChapters,
  });

  @override
  State<StatefulWidget> createState() => _StatusUpdateModalState();
}

class _StatusUpdateModalState extends State<StatusUpdateModal> {
  String _selectedStatus = 'plan-to-read';
  int _chaptersRead = 0;
  int _selectedScore = 0;

  void _manageStatusChange(String status) {
    setState(() {
      _selectedStatus = status;
    });
  }

  void _manageEpisodesChange(int chaps) {
    setState(() {
      _chaptersRead = chaps;
    });
  }

  void _manageScoreChange(int score) {
    setState(() {
      _selectedScore = score;
    });
  }

  void onUpdate() {
    if (_selectedStatus == '') {
      _selectedStatus = 'plan_to_read';
    }

    MyAnimelistApi()
        .updateListManga(
      mangaId: widget.mangaId,
      status: _selectedStatus,
      chapsRead: _chaptersRead,
      score: _selectedScore,
    )
        .then((value) {
      Fluttertoast.showToast(msg: "Updated");
      Navigator.of(context).pop();
    }).catchError((error) {
      Fluttertoast.showToast(msg: "Update Failed: ${error.toString()}");
      Navigator.of(context).pop();
    });
  }

  onDelete() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Remove Manga',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            content:
                const Text('Do you want to remove this manga from your list ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    MyAnimelistApi()
                        .removeListManga(mangaId: widget.mangaId)
                        .then((value) {
                      Fluttertoast.showToast(msg: "Removed from List");
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    }).catchError((error) {
                      Fluttertoast.showToast(
                          msg: "Update Failed: ${error.toString()}");
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('Delete'))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    // load list status
    _selectedStatus = widget.myListStatus.status;
    _chaptersRead = widget.myListStatus.numChaptersRead;
    _selectedScore = widget.myListStatus.score;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              TextButton(
                onPressed: onUpdate,
                child: _selectedStatus == ''
                    ? Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.lightGreen.shade200,
                        ),
                      )
                    : Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.lightGreen.shade200,
                        ),
                      ),
              ),
            ],
          ),
        ),
        SetListStatus(
          status: _selectedStatus,
          notifyParent: _manageStatusChange,
        ),
        const SizedBox(height: 20), // add space between widgets
        ChapterCounter(
          totalChapters: widget.totalChapters,
          chaptersRead: _chaptersRead,
          notifyParent: _manageEpisodesChange,
        ),
        const SizedBox(height: 20), // add space between widgets
        ScoreSlider(
          initialScore: _selectedScore,
          notifyParent: _manageScoreChange,
        ),
        const SizedBox(height: 20), // add space between widgets
        TextButton(
          onPressed: onDelete,
          style: ButtonStyle(
            fixedSize: const MaterialStatePropertyAll(Size(200, 10)),
            backgroundColor: MaterialStatePropertyAll(Colors.red.shade300),
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

typedef ValueChanged<T> = void Function(T value);

class SetListStatus extends StatelessWidget {
  final String status;
  final ValueChanged<String> notifyParent;

  const SetListStatus({
    super.key,
    required this.status,
    required this.notifyParent,
  });

  @override
  Widget build(BuildContext context) {
    // outlined button style
    ButtonStyle getOutlinedButtonStyle(buttonLabel) {
      return OutlinedButton.styleFrom(
        backgroundColor:
            status == buttonLabel ? Theme.of(context).highlightColor : null,
        side: BorderSide(
          color: Colors.grey.shade900,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton.outlined(
            onPressed: () {
              notifyParent('reading');
            },
            style: getOutlinedButtonStyle('reading'),
            icon: const Icon(
              Icons.play_circle_outline_rounded,
            ),
          ),
          IconButton.outlined(
            onPressed: () {
              notifyParent('plan_to_read');
            },
            style: getOutlinedButtonStyle('plan_to_read'),
            icon: const Icon(
              Icons.timer_outlined,
            ),
          ),
          IconButton.outlined(
            onPressed: () {
              notifyParent('completed');
            },
            style: getOutlinedButtonStyle('completed'),
            icon: const Icon(
              Icons.check_circle_outline_rounded,
            ),
          ),
          IconButton.outlined(
            onPressed: () {
              notifyParent('on_hold');
            },
            style: getOutlinedButtonStyle('on_hold'),
            icon: const Icon(
              Icons.pause_circle_outline_rounded,
            ),
          ),
          IconButton.outlined(
            onPressed: () {
              notifyParent('dropped');
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

class ChapterCounter extends StatefulWidget {
  final int totalChapters;
  final int chaptersRead;
  final ValueChanged<int> notifyParent;

  const ChapterCounter({
    super.key,
    required this.totalChapters,
    required this.chaptersRead,
    required this.notifyParent,
  });

  @override
  State<StatefulWidget> createState() => _ChapterCounterState();
}

class _ChapterCounterState extends State<ChapterCounter> {
  final TextEditingController _controller = TextEditingController();
  int _currentValue = 0;

  void _increment() {
    FocusScope.of(context).unfocus();
    setState(() {
      if (_currentValue < widget.totalChapters) {
        _currentValue++;
      }
      widget.notifyParent(_currentValue);
      _controller.text = _currentValue.toString();
    });
  }

  void _decrement() {
    FocusScope.of(context).unfocus();
    setState(() {
      if (_currentValue > 0) {
        _currentValue--;
      }
      widget.notifyParent(_currentValue);
      _controller.text = _currentValue.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _currentValue = widget.chaptersRead;
    _controller.text = _currentValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: _decrement, icon: const Icon(Icons.remove)),
        Container(
          width: 180,
          padding: const EdgeInsets.only(left: 5, right: 5),
          // decoration: BoxDecoration(
          //   border: Border.all(),
          //   borderRadius: BorderRadius.circular(15),
          // ),
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              labelText: 'Read',
              counterText: '',
              suffixText: '/ ${widget.totalChapters.toString()}',
            ),
            style: const TextStyle(fontSize: 15),
            maxLength: 4,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              int parsedValue = int.tryParse(value) ?? _currentValue;

              if (parsedValue <= widget.totalChapters && parsedValue > 0) {
                setState(() {
                  _currentValue = parsedValue;
                });
                widget.notifyParent(_currentValue);
              } else {
                _controller.text = _currentValue.toString();
                FocusScope.of(context).unfocus();
              }
            },
          ),
        ),
        IconButton(onPressed: _increment, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class ScoreSlider extends StatelessWidget {
  final int initialScore;
  final ValueChanged<int> notifyParent;

  const ScoreSlider({
    super.key,
    required this.initialScore,
    required this.notifyParent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'Score:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Slider(
          value: initialScore.toDouble(),
          onChanged: (value) {
            return notifyParent(value.toInt());
          },
          max: 10,
          divisions: 10,
          label: initialScore.round().toString(),
        )
      ],
    );
  }
}
