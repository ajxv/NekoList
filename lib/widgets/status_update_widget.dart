import 'package:flutter/material.dart';

class StatusUpdateModal extends StatefulWidget {
  const StatusUpdateModal({super.key});

  @override
  State<StatefulWidget> createState() => _StatusUpdateModalState();
}

class _StatusUpdateModalState extends State<StatusUpdateModal> {
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
                child: const Text("cancel"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("apply"),
              ),
            ],
          ),
        ),
        const SetListStatus(),
        const SizedBox(height: 20), // add space between widgets
        const EpisodeCounter(totalEpisodes: 12),
        const SizedBox(height: 20), // add space between widgets
        const ScoreSlider(initialScore: 0),
        const SizedBox(height: 20), // add space between widgets
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
              fixedSize: const MaterialStatePropertyAll(Size(200, 10)),
              backgroundColor: MaterialStatePropertyAll(Colors.red.shade300)),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}

class SetListStatus extends StatefulWidget {
  const SetListStatus({super.key});

  @override
  State<StatefulWidget> createState() => _SetListStatusState();
}

class _SetListStatusState extends State<SetListStatus> {
  String _selected = 'plan-to-watch';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton.outlined(
            onPressed: () {
              setState(() {
                _selected = "watching";
              });
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: _selected == 'watching'
                  ? Theme.of(context).highlightColor
                  : null,
            ),
            icon: const Icon(
              Icons.play_circle_outline_rounded,
            ),
          ),
          IconButton.outlined(
            onPressed: () {
              setState(() {
                _selected = "plan-to-watch";
              });
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: _selected == 'plan-to-watch'
                  ? Theme.of(context).highlightColor
                  : null,
            ),
            icon: const Icon(
              Icons.timer_outlined,
            ),
          ),
          IconButton.outlined(
            onPressed: () {
              setState(() {
                _selected = "completed";
              });
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: _selected == 'completed'
                  ? Theme.of(context).highlightColor
                  : null,
            ),
            icon: const Icon(
              Icons.check_circle_outline_rounded,
            ),
          ),
          IconButton.outlined(
            onPressed: () {
              setState(() {
                _selected = "on-hold";
              });
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: _selected == 'on-hold'
                  ? Theme.of(context).highlightColor
                  : null,
            ),
            icon: const Icon(
              Icons.pause_circle_outline_rounded,
            ),
          ),
          IconButton.outlined(
            onPressed: () {
              setState(() {
                _selected = "dropped";
              });
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: _selected == 'dropped'
                  ? Theme.of(context).highlightColor
                  : null,
            ),
            icon: const Icon(
              Icons.delete_outline_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class EpisodeCounter extends StatefulWidget {
  final int totalEpisodes;

  const EpisodeCounter({super.key, required this.totalEpisodes});

  @override
  State<StatefulWidget> createState() => _EpisodeCounterState();
}

class _EpisodeCounterState extends State<EpisodeCounter> {
  final TextEditingController _controller = TextEditingController();
  int _currentValue = 0;

  void _increment() {
    FocusScope.of(context).unfocus();
    setState(() {
      if (_currentValue < widget.totalEpisodes) {
        _currentValue++;
      }
      _controller.text = _currentValue.toString();
    });
  }

  void _decrement() {
    FocusScope.of(context).unfocus();
    setState(() {
      if (_currentValue > 0) {
        _currentValue--;
      }
      _controller.text = _currentValue.toString();
    });
  }

  @override
  void initState() {
    super.initState();
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
              labelText: 'watched',
              counterText: '',
              suffixText: '/ ${widget.totalEpisodes.toString()}',
            ),
            style: const TextStyle(fontSize: 15),
            maxLength: 4,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              int parsedValue = int.tryParse(value) ?? _currentValue;

              if (parsedValue <= widget.totalEpisodes && parsedValue > 0) {
                setState(() {
                  _currentValue = parsedValue;
                });
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

class ScoreSlider extends StatefulWidget {
  final int initialScore;

  const ScoreSlider({super.key, required this.initialScore});

  @override
  State<StatefulWidget> createState() => _ScoreState();
}

class _ScoreState extends State<ScoreSlider> {
  int _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialScore;
  }

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
          value: _currentValue.toDouble(),
          onChanged: (value) => setState(() {
            _currentValue = value.toInt();
          }),
          max: 10,
          divisions: 10,
          label: _currentValue.round().toString(),
        )
      ],
    );
  }
}