import 'package:flutter/material.dart';
import 'package:flutter_pos_new/component/report/rpt_omzetbydate.dart';
import 'package:flutter_pos_new/component/report/rpt_return_bydate.dart';
import 'package:flutter_pos_new/component/warning.dart';
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
    _Text_Beg_Date.text=DateFormat('dd-MM-yyyy').format(DateTime.now());
    _Text_End_Date.text=DateFormat('dd-MM-yyyy').format(DateTime.now());
  }); 
    // TODO: implement initState
    super.initState();
  }

  int selectedOption=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Report Menu'),
        automaticallyImplyLeading: false,
        ),
        
        body: Container(
          
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blueAccent,Colors.yellow])
          ),
          child: 
          Column(
            children: [ 
          SizedBox(height: 20,),

          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.cyan,Colors.deepOrange]),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(style: BorderStyle.solid)
            ),
            
            child: 
          
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
          ),
           SizedBox(height: 10,), 
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(style: BorderStyle.solid,color: Colors.white),
              color: Colors.blue
            ),
            child: 
            Column(children: [
           SizedBox(height:10),
    
             RadioListTile(
              title: Text('Omzet by Date',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              activeColor: Colors.amber,
              fillColor:  WidgetStateColor.resolveWith((states) => Colors.white),
              value:1, 
              groupValue: selectedOption, 
              onChanged: (value) {
               setState(() {
                 selectedOption=value!;
               });
             },),
              SizedBox(height: 5,),
              RadioListTile(
              activeColor: Colors.amber,
              fillColor:  WidgetStateColor.resolveWith((states) => Colors.white),  
              title: Text('Transaction Return by Date',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              value:2, 
              groupValue: selectedOption, 
              onChanged: (value) {
                setState(() {
                  selectedOption=value!;
                });
             },),

            SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
   
              if (selectedOption==1)
              {
           setMessage2( _Text_Beg_Date.text+'-'+ _Text_End_Date.text+'-');
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => InAppWebViewExampleScreen_omzetbydate(date1: _Text_Beg_Date.text, date2: _Text_End_Date.text, kodecab: 'HO', nohp: 'xx'),));
              }else if (selectedOption==2){
     //Navigator.push(context, MaterialPageRoute(builder: (context) => InAppWebViewExampleScreen_returnbydate(date1: _Text_Beg_Date.text, date2: _Text_End_Date.text, kodecab: 'HO', nohp: 'xx'),));
              }
            }, child: Text('Process'))
            
            ]
            ))

            ]
          
        ),
        )
    );
  }
 
 Widget pickBegDate(){
  return Container(
      child: 
      Container(
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
              final String formatdate=DateFormat('dd-MM-yyyy').format(pickdate);
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
              final String formatdate=DateFormat('dd-MM-yyyy').format(pickdate);
              setState(() {
               _Text_End_Date.text=formatdate;
              });
            }
        },
      ),

  );
 }
}