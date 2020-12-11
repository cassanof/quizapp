import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:quizapp/services/auth.dart';

import 'screens/screens.dart';
import 'services/services.dart';

void main() => runApp(MyApp());

// TODO: Topics Screen

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        StreamProvider<FirebaseUser>.value(value: AuthService().user)
      ],

      child: MaterialApp(
        // Firebase Analytics
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
        ],

        routes: {
          '/': (context) => LoginScreen(),
          '/topics': (context) => TopicsScreen(),
          '/profile': (context) => ProfileScreen(),
          '/about': (context) => AboutScreen(),
        },

        // Theme
        theme: ThemeData(
          fontFamily: 'Nunito',
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.black87,
          ),
          brightness: Brightness.dark,
          textTheme: TextTheme(
            // used body1,body2 which is deprecated
            bodyText1: TextStyle(fontSize: 18),
            bodyText2: TextStyle(fontSize: 16),
            button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
            headline5: TextStyle(fontWeight: FontWeight.bold),
            subtitle1: TextStyle(color: Colors.grey),
          ),
        ),
      ), // MaterialApp
    );
  }
}

// Shared Data
class QuizState with ChangeNotifier {
  double _progress = 0;
  Option _selected;

  final PageController controller = PageController();

  get progress => _progress;

  get selected => _selected;

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  set selected(Option newValue) {
    _selected = newValue;
    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}