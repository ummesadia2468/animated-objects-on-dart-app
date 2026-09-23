import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(AnimationApp());

class AnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedObjectsScreen(),
    );
  }
}

class AnimatedObjectsScreen extends StatefulWidget {
  @override
  _AnimatedObjectsScreenState createState() => _AnimatedObjectsScreenState();
}

class _AnimatedObjectsScreenState extends State<AnimatedObjectsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pictureController;
  late final AnimationController _birdController;
  late final AnimationController _balloonController;
  late final AnimationController _personController;
  late final AnimationController _circleController;

  late final Animation<Offset> _pictureAnimation;
  late final Animation<double> _birdAnimation;
  late final Animation<Offset> _balloonAnimation;
  late final Animation<Offset> _personAnimation;
  late final Animation<double> _circleAnimation;

  @override
  void initState() {
    super.initState();

    // Picture Moving Animation
    _pictureController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _pictureAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset(1.0, 0.0),
    ).animate(
        CurvedAnimation(parent: _pictureController, curve: Curves.easeInOut));

    // Bird Zoom Animation
    _birdController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _birdAnimation = Tween<double>(
      begin: 0.5,
      end: 1.5,
    ).animate(
        CurvedAnimation(parent: _birdController, curve: Curves.easeInOut));

    // Balloon Flying Animation
    _balloonController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: false);
    _balloonAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, -1.0),
    ).animate(
        CurvedAnimation(parent: _balloonController, curve: Curves.easeIn));

    // Person Walking Animation
    _personController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _personAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset(1.0, 0.0),
    ).animate(CurvedAnimation(parent: _personController, curve: Curves.linear));

    // Circle Rotating Animation
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _circleAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _circleController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _pictureController.dispose();
    _birdController.dispose();
    _balloonController.dispose();
    _personController.dispose();
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Objects Example'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Picture Moving
          SlideTransition(
            position: _pictureAnimation,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/picture.png', width: 100),
            ),
          ),

          // Bird Zooming
          ScaleTransition(
            scale: _birdAnimation,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/bird.png', width: 100),
            ),
          ),

          // Balloon Flying
          SlideTransition(
            position: _balloonAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/balloon.png', width: 100),
            ),
          ),

          // Person Walking
          SlideTransition(
            position: _personAnimation,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset('assets/person.png', width: 100),
            ),
          ),

          // Circle Rotating
          AnimatedBuilder(
            animation: _circleAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _circleAnimation.value,
                child: Align(
                  alignment: Alignment(0.5, 0.5),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
