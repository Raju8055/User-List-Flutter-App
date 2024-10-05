import 'package:appscrip/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/user_bloc.dart';
import 'repositories/user_repository.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
  //Name: Raju s
  //phone Number: 8861308362
  //mail id: raju.be.cse78@gmail.com
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        BlocProvider(
          create: (context) => UserBloc(userRepository: context.read<UserRepository>()),
        ),
      ],

      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'User List App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AnimatedSplashScreen(), 
        );
      },
    );
  }
}
