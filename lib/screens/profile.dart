import 'package:flutter/material.dart';
import 'package:neko_list/models/user_model.dart';
import 'package:neko_list/services/mal_services.dart';
import 'package:neko_list/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserDetails> _futureUserDetails;

  @override
  void initState() {
    super.initState();
    _futureUserDetails = MyAnimelistApi().getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: FutureBuilder<UserDetails>(
          future: _futureUserDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 60,
                    child: ClipOval(
                      child: snapshot.data!.picture.isNotEmpty
                          ? Image.network(snapshot.data!.picture)
                          : Image.asset(
                              "assets/images/profile_placeholder.jpeg"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    snapshot.data!.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    snapshot.data!.id.toString(),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 25,
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                  IconButton(
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                      icon: const Icon(
                        Icons.dark_mode,
                      ))
                ],
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
          }),
    );
  }
}
