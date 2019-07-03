import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'generated/i18n.dart';
import 'provider/main_prodiver.dart';
import 'provider/theme_changer.dart';

void main() {
  return runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => MainProvider(),
        ),
        ChangeNotifierProvider(
          builder: (_) => ThemeChanger(
                ThemeData.dark(),
              ),
        ),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    final i18n = I18n.delegate;

    return MaterialApp(
      localizationsDelegates: [
        i18n,
      ],
      supportedLocales: i18n.supportedLocales,
      localeResolutionCallback: i18n.resolution(
        fallback: new Locale("en", "US"),
      ),
      home: HomeScreen(),
      theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
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
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _home,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FlatButton(
                child: Text('Dark Theme'),
                onPressed: () {
                  _themeChanger.setTheme(
                    ThemeData.dark(),
                  );
                }),
            FlatButton(
                child: Text('Light Theme'),
                onPressed: () {
                  _themeChanger.setTheme(
                    ThemeData.light(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
