import 'package:flutter/material.dart';
import 'package:myproject/providers/counter_provider.dart';
import 'package:myproject/providers/timer_provider.dart';
import 'package:myproject/themes/style.dart';
import 'package:myproject/utils/app_router.dart';
import 'package:myproject/utils/utility.dart';
import 'package:provider/provider.dart';

var InitialRoute;
void main() async {
  //test logger
  Utility.testLogger();

  WidgetsFlutterBinding.ensureInitialized();

  await Utility.initiSharedPrefs();

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  final loginStatus = Utility.getSharedPreferance('loginStatus');
  final welcomeStatus = Utility.getSharedPreferance('WelcomeStatus');

  if (loginStatus == true) {
    InitialRoute = AppRouter.dashboard;
  } else if (welcomeStatus == true) {
    InitialRoute = AppRouter.login;
  } else {
    InitialRoute = AppRouter.welcome;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => TimerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: InitialRoute,
        routes: AppRouter.routes,
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
      
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {

//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//       appBar: AppBar(

//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,

//         title: Text(widget.title),
//       ),
//       body: Center(

//         child: Column(
         
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), 
//     );
//   }
// }
