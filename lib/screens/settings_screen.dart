import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neko_list/providers/session_provider.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../services/oauth_services.dart';
import 'auth/login.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle subtitleStyle = TextStyle(
      fontSize: 12,
      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
    );

    bool showNSFW = context.watch<SessionProvider>().showNSFW;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display settings
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Display",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SwitchListTile(
                  title: const Text("Dark Mode"),
                  subtitle: Text(
                    Provider.of<ThemeProvider>(context).themeData.brightness ==
                            Brightness.dark
                        ? "Dark Mode"
                        : "Light Mode",
                    style: subtitleStyle,
                  ),
                  secondary: const Icon(Icons.dark_mode_outlined),
                  value: Provider.of<ThemeProvider>(context)
                          .themeData
                          .brightness ==
                      Brightness.dark,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(),
                  activeColor: Colors.green.shade300,
                  activeTrackColor: Colors.green.shade200.withOpacity(0.5),
                ),
                // Content settings
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Content",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SwitchListTile(
                  title: const Text("Show NSFW entries"),
                  subtitle: Text(
                    showNSFW ? "Allowed" : "Hidden",
                    style: subtitleStyle,
                  ),
                  secondary: const Icon(Icons.error_outline),
                  value: showNSFW,
                  onChanged: (value) {
                    context.read<SessionProvider>().setShowNSFW(value);
                  },
                  activeColor: Colors.green.shade300,
                  activeTrackColor: Colors.green.shade200.withOpacity(0.5),
                ),
                // Miscellaneous Settings
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "misc.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onLongPress: () async {
                    await Clipboard.setData(
                      const ClipboardData(text: 'github.com/ajxv/NekoList'),
                    );
                    Fluttertoast.showToast(msg: "Link copied to clipboard");
                  },
                  child: ListTile(
                    title: const Text('Github'),
                    subtitle: Text(
                      'github.com/ajxv/NekoList',
                      style: subtitleStyle,
                    ),
                    leading: const Icon(Icons.link_rounded),
                  ),
                ),
                ListTile(
                  title: const Text('Check for Updates'),
                  subtitle: Text(
                    'Feature not added',
                    style: subtitleStyle,
                  ),
                  leading: const Icon(Icons.update_rounded),
                  onTap: () {},
                  enabled: false,
                ),
                // Logout Button
                const Spacer(),
                Center(
                  heightFactor: 2,
                  child: TextButton.icon(
                    onPressed: () {
                      signOut().then(
                        (value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const LoginPage()),
                          ),
                        ),
                      );
                    },
                    label: const Text('Logout'),
                    icon: const Icon(Icons.logout_rounded),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      fixedSize: const MaterialStatePropertyAll(Size(150, 10)),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.red.shade400),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
