import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Report1 extends StatefulWidget {
  const Report1({super.key});

  @override
  State<Report1> createState() => _Report1State();
}
   

   

class _Report1State extends State<Report1> {

  final _Text_Beg_Date=TextEditingController();
  final _Text_End_Date=TextEditingController();


  @override
  void initState() {
  setState(() {
    _Text_Beg_Date.text=DateFormat('dd/MM/yyyy').format(DateTime.now());
    _Text_End_Date.text=DateFormat('dd/MM/yyyy').format(DateTime.now());
  }); 
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Report Menu'),),
        body: Container(
          
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blueAccent,Colors.yellow])
          ),
          child: 
          Column(
            children: [ 
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              SizedBox(
                width: 120,
                child:
              pickBegDate(),
              ),
              SizedBox(width: 50,child: Text('   To')),
              SizedBox(width:120,
              child: 
              pickEndDate(),
              ),
            ],
          )

            ]
        ),
        )
    );
  }
 
 Widget pickBegDate(){
  return Container(
      child: 
      Card(
        color: Colors.blue,
        child: 
      TextField(
        style: TextStyle(color: Colors.black),
        controller: _Text_Beg_Date,
        decoration: InputDecoration(
          hintText:  'Date',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10)
          ),
          labelStyle: TextStyle(color: Colors.black)
        ),
        onTap: () async {
          DateTime?pickdate=await showDatePicker(context: context,
           firstDate: DateTime(2010), 
           lastDate: DateTime(2040),
           initialDate: DateTime.now(),
   
           );
            if (pickdate!=null)
            {
              final String formatdate=DateFormat('dd/MM/yyyy').format(pickdate);
              setState(() {
               _Text_Beg_Date.text=formatdate;
              });
            }
        },
      ),
      )
  );
 }



 Widget pickEndDate(){
  return Container(
      child: 
      
      TextField(
        style: TextStyle(color: Colors.black),
        controller: _Text_End_Date,
        decoration: InputDecoration(
          hintText:  'Date',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10)
          
          ),
                    
          labelStyle: TextStyle(color: Colors.black)
        ),
        onTap: () async {
          DateTime?pickdate=await showDatePicker(context: context,
           firstDate: DateTime(2010), 
           lastDate: DateTime(2040),
           initialDate: DateTime.now(),
   
           );
            if (pickdate!=null)
            {
              final String formatdate=DateFormat('dd/MM/yyyy').format(pickdate);
              setState(() {
               _Text_End_Date.text=formatdate;
              });
            }
        },
      ),

  );
 }
}