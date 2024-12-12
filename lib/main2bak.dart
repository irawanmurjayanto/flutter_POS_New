import 'package:flutter/material.dart';
import 'package:flutter_pos_new/component/form/finance.dart';
import 'package:flutter_pos_new/component/form/report.dart';
import 'package:flutter_pos_new/component/mainmenu.dart';
import 'package:flutter_pos_new/main.dart';

class Main2 extends StatefulWidget {
  const Main2({super.key});

  @override
  State<Main2> createState() => _Main2State();
}

class _Main2State extends State<Main2> {

  
final List<Widget> _children=[
const MainMenu(),
const Report1(),
const Finance1()
];

int _currentIndex = 0;

void onBarTapped(int index){
  setState(() {
    _currentIndex=index;
  });
}

  @override
  Widget build(BuildContext context) {

         
        final screenHeight=MediaQuery.of(context).size.height;
        
    return
    WillPopScope( onWillPop: ()async =>false, 
    child: 
     Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
         floatingActionButton: FloatingActionButton(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Log OUT',style: TextStyle(fontSize: 12),)
        ],
      ),
      onPressed: () {
       Navigator.push(context, MaterialPageRoute(builder: (context) => const MainApp()));
     },
     
     ),

      
      body:  _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onBarTapped,
           selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 8,
        unselectedFontSize: 8,
          items: [
             BottomNavigationBarItem(
      icon: const Icon(Icons.home,size: 40),
      label: 'Home'
    ),
    BottomNavigationBarItem(
        icon: const Icon(Icons.newspaper,size: 40),
        label: 'Report'
    ),
    BottomNavigationBarItem(
        icon: const Icon(Icons.monetization_on,size: 40),
        label: 'Finance'
    ),
   
          ]
      ),
    )
    );
  
   
  }
}