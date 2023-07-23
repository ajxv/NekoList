import 'package:flutter/material.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<StatefulWidget> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text('Home Feed'),
    );
  }
}
