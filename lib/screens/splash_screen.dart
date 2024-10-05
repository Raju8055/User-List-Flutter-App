// animated_splash_screen.dart
  //Name: Raju s
  //phone Number: 8861308362
  //mail id: raju.be.cse78@gmail.com
import 'package:appscrip/bloc/user_bloc.dart';
import 'package:appscrip/bloc/user_event.dart';
import 'package:appscrip/repositories/user_repository.dart';
import 'package:appscrip/screens/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';


class AnimatedSplashScreen extends StatefulWidget {
  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Set up animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // Start animation
    _controller.forward();

    // Navigate to UserListScreen after the animation is complete
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  BlocProvider(
          create: (context) => UserBloc(userRepository: context.read<UserRepository>())..add(FetchUsers()),
          child: UserListScreen(), // Use AnimatedSplashScreen here
        ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Opacity(
          opacity: _animation.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.jpg', height: 100),
              SizedBox(height: 20),
              Text(
                'Welcome to User List App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
