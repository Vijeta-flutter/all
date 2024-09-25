import 'dart:async';
import 'dart:math';
import 'package:firebaseflutterproject/model/carmodel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<OpposingCar> _opposingCars = [];
  final Random _random = Random();
  late Timer _timer;
  final double _carWidth = 100;
  final double _laneWidth = 100; // Assuming each lane has a fixed width
  final double _carHeight = 200;

  @override
  void initState() {
    super.initState();

    // Initialize with 3 opposing cars
    _initializeOpposingCars();

    // Start the movement of opposing cars
    _startOpposingCarMovement();
  }

  void _initializeOpposingCars() {
    for (int i = 0; i < 3; i++) { // 3 opposing cars
      double randomLane = _randomLanePosition();
      _opposingCars.add(
        OpposingCar(
          positionX: randomLane,
          positionY: _randomStartingY(), // Start slightly above the screen
          speed: _randomSpeed(), // Random speed for each car
        ),
      );
    }
  }

  // Random lane position (fixed X positions)
  double _randomLanePosition() {
    double screenWidth = MediaQuery.of(context).size.width;
    return _random.nextInt(3) * _laneWidth + (screenWidth / 4); // Assuming 3 lanes
  }

  // Random speed for the car
  double _randomSpeed() {
    return _random.nextDouble() * 5 + 2; // Speed between 2 and 7
  }

  // Start the car slightly above the screen
  double _randomStartingY() {
    return -_random.nextDouble() * 300; // Start slightly above the screen
  }

  void _startOpposingCarMovement() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        for (var car in _opposingCars) {
          car.positionY += car.speed; // Move car down

          // If car reaches the bottom of the screen, respawn it at the top
          if (car.positionY > MediaQuery.of(context).size.height) {
            car.positionY = _randomStartingY(); // Reset to top
            car.positionX = _randomLanePosition(); // Random new lane
            car.speed = _randomSpeed(); // Assign new speed
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Stop the timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Racing Game'),
        backgroundColor: Colors.grey,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/cars/car_path.png', // Background track image
              fit: BoxFit.cover,
            ),
          ),
          // Draw Opposing Cars
          for (var car in _opposingCars)
            Positioned(
              left: car.positionX,  // Lane X position
              top: car.positionY,   // Vertical position
              child: Image.asset(
                'assets/opposingcars/car_${_random.nextInt(3)}.png', // Use car from opposingcar folder
                width: _carWidth,
                height: _carHeight,
              ),
            ),
        ],
      ),
    );
  }
}
