import 'package:audio_app/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/main_prodiver.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => MainProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          i18n,
        ],
        supportedLocales: i18n.supportedLocales,
        localeResolutionCallback: i18n.resolution(
          fallback: new Locale("en", "US"),
        ),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          I18n.of(context).home,
        ),
      ),
      body: Container(
        child: Text(
          I18n.of(context).home,
        ),
      ),
    );
  }
}
