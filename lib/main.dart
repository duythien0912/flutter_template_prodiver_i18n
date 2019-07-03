import 'package:audio_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'generated/i18n.dart';
import 'provider/main_prodiver.dart';
import 'provider/theme_changer.dart';
import 'theme/dart.dart';
import 'theme/light.dart';

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
                lightTheme,
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
        fallback: Locale("en", "US"),
      ),
      home: MusicScreen(),
      theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

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
                    darkTheme,
                  );
                }),
            FlatButton(
                child: Text('Light Theme'),
                onPressed: () {
                  _themeChanger.setTheme(
                    lightTheme,
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key key}) : super(key: key);

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dheight = MediaQuery.of(context).size.height;
    double headerh = dheight * 1 / 3;

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.play_arrow),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            top: 0,
            left: 0,
            child: Center(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    // title: titleText(),
                    expandedHeight: headerh,
                    // pinned: true,
                    floating: false,
                    flexibleSpace: new FlexibleSpaceBar(
                        background: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.0),
                              // bottomRight: Radius.circular(25.0),
                            ),
                            child: Image.asset(
                              "assets/img/music4.jpg",
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //       colors: [
                        //         const Color(0x00000000),
                        //         const Color(0x00000000),
                        //         const Color(0x00000000),
                        //         const Color.fromRGBO(255, 193, 46, 0.3),
                        //       ],
                        //     ),
                        //   ),
                        //   // height: screenHeight * 0.45,
                        // ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: titleText(),
                          ),
                        )
                      ],
                    )),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    sliver: SliverList(
                      delegate: new SliverChildBuilderDelegate(
                        (context, index) {
                          if (index > 3) return null;
                          return buildItemMusic(index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildFab(headerh),
        ],
      ),
    );
  }

  Widget buildItemMusic(int index) => Container(
        margin: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 14.0,
                  spreadRadius: 4.0,
                  color: Colors.black12,
                  offset: new Offset(-3.0, 3.0),
                )
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7.0),
                  bottomRight: Radius.circular(7.0),
                  topLeft: Radius.circular(7.0),
                  topRight: Radius.circular(7.0),
                ),
                child: Image.asset(
                  "assets/img/music1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Paul Jones",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Nicole",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "5:32",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      );

  Widget _buildFab(headerh) {
    //starting fab position
    final double defaultTopMargin = headerh - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 96.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return new Positioned(
      top: top,
      right: 16.0,
      child: new Transform(
        transform: new Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: new FloatingActionButton(
          onPressed: () => {},
          child: new Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }

  Text titleText() {
    return Text(
      "Awwitfi aassuu",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
