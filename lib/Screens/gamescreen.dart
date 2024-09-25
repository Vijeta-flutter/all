import 'package:firebaseflutterproject/theme/color.dart';
import 'package:firebaseflutterproject/wigdets/custombottomnavItem.dart';
import 'package:firebaseflutterproject/wigdets/customdrawer.dart';
import 'package:firebaseflutterproject/wigdets/customfloatingactionbutton.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _selectedIndex = 0;
  String? _selectedCar;
  double _carPosition = 0.0;
  final double _carPositionY = 304.0;
  final _formKey = GlobalKey<FormState>();
  final _playerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final double _carWidth = 100;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _moveCarRight(double screenWidth) {
    setState(() {
      if (_carPosition + 20 <= 170) {
        _carPosition += 20;
      }
    });
  }

  void _moveCarLeft(double screenWidth) {
    setState(() {
      if (_carPosition - 20 >= -170) {
        _carPosition -= 20;
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final playerName = _playerNameController.text;
      final email = _emailController.text;
      print('Player Name: $playerName');
      print('Email: $email');
    }
  }

  @override
  void initState() {
    super.initState();
    _carPosition = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth =  (MediaQuery.of(context).size.width)/4; // Get screen width

    return Scaffold(
      appBar: AppBar(
        title: Text('Racing Game', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.grey,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assests/cars/car_path.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(),
                  ),
                  SizedBox(height: 20),
                  if (_selectedCar != null)
                    Column(
                      children: [
                        Transform.translate(
                          offset: Offset(_carPosition, 0),
                          child: Image.asset(
                            _selectedCar!,
                            height: 200,
                            width: 180,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_left,size: 100,color: Colors.white,),
                              onPressed: () => _moveCarLeft(screenWidth),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_right,size: 100,color: Colors.white,),
                              onPressed: () => _moveCarRight(screenWidth),
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(4, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey,
                          width: 4,
                        ),
                      ),
                      child: Text('No car selected - - - - >',
                          style: TextStyle(fontSize: 18)),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      drawer: CustomGameDrawer(),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print('Car model $index selected');
                        setState(() {
                          _selectedCar = 'assests/cars/car_$index.png';
                        });
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assests/cars/car_$index.png',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              );
            },
          );
        }, child: Icon(Icons.directions_car_filled),
      ),
    );
  }
}

