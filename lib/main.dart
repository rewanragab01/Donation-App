import 'package:donation/features/auth/presentation/views/authscreen.dart';
import 'package:donation/features/home/data/repos/donor_repo.dart';
import 'package:donation/features/home/presentation/viewmodels/cubit/users_cubit.dart';
import 'package:donation/features/home/presentation/views/home.dart';
import 'package:donation/features/splash/presentation/views/splashscreen.dart';
import 'package:donation/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/authscreen': (context) => Authscreen(),
        '/home': (context) => BlocProvider(
            create: (context) => UsersCubit(DonarRepository())..fetchdonors(),
            child: HomeScreen())
      },
    );
  }
}
