import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static ThemeMode themeMode = ThemeMode.system;

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: const SettingsPage2(),
    );
  }
}

class SettingsPage2 extends StatefulWidget {
  const SettingsPage2({Key? key}) : super(key: key);

  @override
  State<SettingsPage2> createState() => _SettingsPage2State();
}

class _SettingsPage2State extends State<SettingsPage2> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  GestureDetector(
                    child: _CustomListTile(
                        title: "Notificaciones",
                        icon: Icons.notifications_none_rounded,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const _SingleSection(
                title: "Organización",
                children: [
                  _CustomListTile(
                    title: "Desarrolladores",
                    icon: Icons.person_outline_rounded,
                  ),
                  _CustomListTile(
                    title: "Contactenos",
                    icon: Icons.phone,
                  ),
                ],
              ),
              const Divider(),
              _SingleSection(
                children: [
                  _CustomListTile(
                    title: "Help and Feedback",
                    icon: Icons.help_outline_rounded,
                  ),
                  _CustomListTile(
                    title: "Acerca de",
                    icon: Icons.info_outline_rounded,
                  ),
                  _CustomListTile(
                    title: "Cerrar Sesión",
                    icon: Icons.exit_to_app_rounded,
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, "/login");
                      } catch (e) {
                        print("Error signing out: $e");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDarkMode() {
    setState(() {
      if (_isDark) {
        MyApp.themeMode = ThemeMode.dark;
      } else {
        MyApp.themeMode = ThemeMode.light;
      }
    });
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final Function()? onTap;

  const _CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}
