import 'dart:async';
import 'package:get_it/get_it.dart';

import 'package:audio_app/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'provider/main_prodiver.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton(ThemeManager());
}

void main() {
  setupLocator();

  return runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => MainProvider(),
        ),
        Provider.value(value: ThemeManager()),
        StreamProvider<ThemeData>(
            builder: (context) =>
                Provider.of<ThemeManager>(context, listen: false).theme)
      ],
      child: Consumer<ThemeData>(builder: (context, theme, child) {
        return MaterialApp(
          localizationsDelegates: [
            i18n,
          ],
          supportedLocales: i18n.supportedLocales,
          localeResolutionCallback: i18n.resolution(
            fallback: new Locale("en", "US"),
          ),
          title: 'Flutter Demo',
          theme: theme,
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String _home = I18n.of(context).home;
    ThemeManager themeM = Provider.of<ThemeManager>(context);
    if (themeM._currentTheme == 0) themeM.changeTheme();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          _home,
        ),
      ),
      body: Container(
        child: Text(
          _home,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ThemeManager>(context).changeTheme();
        },
      ),
    );
  }
}

class ThemeManager {
  StreamController<ThemeData> _themeController = StreamController<ThemeData>();
  List<ThemeData> _availableThemes = [
    ThemeData(
      backgroundColor: Colors.black,
      accentColor: Colors.white,
      // appBarTheme: AppBarTheme(
      //   color: Colors.white,
      //   textTheme: TextTheme(
      //     title: TextStyle(
      //       color: Colors.black,
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      // textTheme: TextTheme(
      //   title: TextStyle(
      //     color: Colors.white,
      //   ),

      // ),
    ),
    ThemeData(
      backgroundColor: Colors.white,
      accentColor: Colors.black,
      // appBarTheme: AppBarTheme(
      //   color: Colors.black,
      // ),
      // textTheme: TextTheme(
      //   title: TextStyle(
      //     color: Colors.black,
      //   ),
      // ),
    ),
    // ThemeData(backgroundColor: Colors.purple, accentColor: Colors.pink),
    // ThemeData(backgroundColor: Colors.blue, accentColor: Colors.red),
  ];
  Stream<ThemeData> get theme => _themeController.stream;
  int _currentTheme = 0;

  Future changeTheme() async {
    _currentTheme++;
    if (_currentTheme >= _availableThemes.length) {
      _currentTheme = 0;
    }

    // Get the theme to apply
    var themeToApply = _availableThemes[_currentTheme];
    Future _updateStatusBarColor(ThemeData themeToApply) async {
      // Set status bar color
      await FlutterStatusbarcolor.setStatusBarColor(
          themeToApply.backgroundColor);

      // Check the constrast between the colors and set the status bar icons colors to white or dark
      if (useWhiteForeground(themeToApply.backgroundColor)) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      }
    }

    // Update status bar color
    await _updateStatusBarColor(themeToApply);
    // Broadcast new theme
    _themeController.add(themeToApply);
  }
}
