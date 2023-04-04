import 'package:flutter/material.dart';
import 'package:playandwin/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    // Initialize the animation
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller!);

    // Start the animation
    _controller!.forward();

    // Navigate to the HomePage after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation!,
          builder: (BuildContext context, Widget? child) {
            return Transform.scale(
              scale: _animation!.value,
              child: Image.network(
                'https://yt3.googleusercontent.com/ytc/AL5GRJVFUbrqLgTKs3qvoiGiZDvJHXkB_pzHwyussmGX=s900-c-k-c0x00ffffff-no-rj',
                width: 150.0,
                height: 150.0,
              ),
            );
          },
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
