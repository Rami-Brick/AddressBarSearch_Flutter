import 'package:flutter/material.dart';
// import 'main.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IP Address Validation',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 196, 15, 178)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Souha APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final String expectedIp = "192.168.1.1";

  void ipCheck(String ipAddress) async {
    final urlString = 'http://$ipAddress';
    final chromePackage = 'com.android.chrome';
    if (await canLaunchUrl(Uri.parse(urlString))) {
      try {
        await launch(
          urlString,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'package': chromePackage},
        );
      } catch (e) {
        print('Error launching URL: $e');
      }
    } else {
      print('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter your IP address:',
            ),
            TextField(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (ipAddress) {
                ipCheck(ipAddress);
              },
            ),
          ],
        ),
      ),
    );
  }
}
