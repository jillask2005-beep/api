import 'package:api/task3.dart';
import 'package:flutter/material.dart';
class darkandlight extends StatefulWidget {
  const darkandlight({super.key});

  @override
  State<darkandlight> createState() => _darkandlightState();
}

class _darkandlightState extends State<darkandlight> {
  bool isDark=false;
  String username="Srikanth";
  String useremail="sikanth@gmail.com";
  double fontsize=16;
  String lauguage="English";
  String Notification="normal";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "my Dashboard",
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),

      themeMode: isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: DashboardScreen(
        isDark:isDark,
        username:username,
        useremail:useremail,
        fontsize:fontsize,
        lauguage:lauguage,
        Notification:Notification,

        onThemeChanged:(value){
          setState(() {
            isDark=value;
          });
        },
        onFontChanged:(value){
          setState(() {
            fontsize=value;

          });
        },
        onLanguegeChanged:(value){
          setState(() {
            lauguage=value;
          });
        },
        onNotificationChanged:(value){
          setState(() {
            Notification=value;
          });
        },
        onLogout:(){
          setState(() {
            username="srikanth";
            useremail="srikanth@gamil.com";
          });
          Navigator.push(context, MaterialPageRoute(builder: (context)=>task2()),);
        }
      ),

    );
  }
}
class DashboardScreen extends StatelessWidget {
  final bool isDark;
  final String username;
  final String useremail;
  final double fontsize;
  final String lauguage;
  final String Notification;

  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<double> onFontChanged;
  final ValueChanged<String> onLanguegeChanged;
  final ValueChanged<String> onNotificationChanged;
  final VoidCallback onLogout;

  const DashboardScreen({
    super.key,
    required this.isDark,
    required this.username,
    required this.useremail,
    required this.fontsize,
    required this.lauguage,
    required this.Notification,
    required this.onThemeChanged,
    required this.onFontChanged,
    required this.onLanguegeChanged,
    required this.onNotificationChanged,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(username),
              accountEmail: Text(useremail),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Notifications"),
              onTap: () {},
            ),

            SwitchListTile(
              title: const Text("Dark Mode"),
              value: isDark,
              onChanged: onThemeChanged,
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: onLogout,
            ),
          ],
        ),
      ),

      body: Center(
        child: Text(
          "Welcome $username",
          style: TextStyle(
            fontSize: fontsize,
          ),
        ),
      ),
    );
  }
}
