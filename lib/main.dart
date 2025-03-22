import 'package:brain_curve/Provider/recommended_videos.dart';
import 'package:brain_curve/Screens/home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Helper/showSnackbar.dart';
import 'Provider/home.dart';
import 'Provider/theme.dart';
import 'Utils/colorful.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadTheme()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => RecommendedVideoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brain Curve',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: const MyApp(),
    );
  }
}

class InternetWrapper extends StatefulWidget {
  const InternetWrapper({super.key});

  @override
  State<InternetWrapper> createState() => _InternetWrapperState();
}

class _InternetWrapperState extends State<InternetWrapper> {
  late Connectivity _connectivity;
  late Stream<List<ConnectivityResult>> _connectivityStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeConnectivity();
    });
  }

  initializeConnectivity() async {
    _connectivity = Connectivity();
    _connectivityStream = _connectivity.onConnectivityChanged;
    _connectivityStream.listen((connectivityResult) {
      if (connectivityResult.isNotEmpty) {
        if (connectivityResult[0] == ConnectivityResult.wifi ||
            connectivityResult[0] == ConnectivityResult.mobile) {
          printGreen('Internet connection restored');
          if (mounted) {
            showSnackBar('You are connected to the internet!', context,
                bgColor: Colors.green);
            if (RecommendedVideoProvider().videos.isEmpty) {
              RecommendedVideoProvider().fetchVideos(context);
            }
          }
        } else {
          printRed('No internet connection');

          if (mounted) {
            showSnackBar("No internet connection", context,
                bgColor: Colors.red);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
