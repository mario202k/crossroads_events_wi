import 'package:crossroads_events/generated/i18n.dart';
import 'package:crossroads_events/screens/login.dart';
import 'package:crossroads_events/screens/reset_password.dart';
import 'package:crossroads_events/screens/sign_up.dart';
import 'package:crossroads_events/screens/walkthrough.dart';
import 'package:crossroads_events/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/base_screen.dart';




void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {

  final SharedPreferences prefs;
  MyApp({this.prefs});


  final ColorScheme _colorScheme = ColorScheme(
    primary: const Color(0xFF5D1049),
    primaryVariant: const Color(0xFF5D1049),
    secondary: Colors.red,
    secondaryVariant: const Color(0xFF1CDEC9),
    background: const Color(0xFF451B6F),
    surface: const Color(0xFFFFFFFF),
    onBackground: Colors.black,
    error: Colors.red.shade800,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: const Color(0xFF5D1049),
    brightness: Brightness.dark,
  );



  @override
  Widget build(BuildContext context) {

    return Material(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/walkthrough': (BuildContext context) => Walkthrough(),
          '/home' : (BuildContext context) => BaseScreens(),
          '/signUp' : (BuildContext context) => SignUp(),
          '/resetpsw': (BuildContext context) => ResetPassword(),

        },

        theme: ThemeData(
            colorScheme: _colorScheme,
            primaryColor: _colorScheme.primary,
            accentColor: _colorScheme.secondary,
            backgroundColor: _colorScheme.background,

            textTheme: TextTheme(
              display1: GoogleFonts.raleway(fontSize: 25.0,color: _colorScheme.onSurface,),
              display2: GoogleFonts.raleway(fontSize: 28.0,color: _colorScheme.onSurface,),
              display3: GoogleFonts.raleway(fontSize: 61.0,color: _colorScheme.onPrimary,),
              display4: GoogleFonts.raleway(fontSize: 98.0,color: _colorScheme.onPrimary,),
              caption: GoogleFonts.sourceCodePro(fontSize: 11.0,color: _colorScheme.onPrimary,),
              headline: GoogleFonts.raleway(fontSize: 35.0,color: _colorScheme.onPrimary,),
              subhead: GoogleFonts.sourceCodePro(fontSize: 16.0,color: _colorScheme.onPrimary,),
              overline: GoogleFonts.sourceCodePro(fontSize: 11.0,color: _colorScheme.onPrimary,),
              body2: GoogleFonts.sourceCodePro(fontSize: 17.0,color: _colorScheme.onPrimary,),
              subtitle: GoogleFonts.sourceCodePro(fontSize: 14.0,color: _colorScheme.onPrimary,),
              body1: GoogleFonts.sourceCodePro( fontSize: 15.0,color: _colorScheme.onPrimary,),
              title: GoogleFonts.sourceCodePro(fontSize: 16.0,color: _colorScheme.onPrimary,),
              button: GoogleFonts.sourceCodePro(fontSize: 15.0,color: _colorScheme.onPrimary,),
            ),


            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
                splashColor: _colorScheme.primary,
                colorScheme: _colorScheme,
                buttonColor: _colorScheme.surface,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                foregroundColor: _colorScheme.secondary),
            inputDecorationTheme: InputDecorationTheme(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
            cardTheme: CardTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),dividerColor: _colorScheme.secondary),

        home: _handleCurrentScreen(),
      ),
    );
  }

  Widget _handleCurrentScreen() {
    bool seen = prefs.getBool('seen') ?? false;
    if (seen) {
      return Login(AuthService());
    } else {
      return Walkthrough(prefs: prefs);
    }
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    Firestore.instance.collection('books').document()
        .setData({ 'title': 'android', 'author': 'author' });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
