import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  bool _progress=false;

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
              gradient: LinearGradient(colors: [const Color.fromARGB(255, 224, 230, 231),const Color.fromARGB(255, 243, 206, 194)]),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(style: BorderStyle.solid)
            ),
            
            child: 
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              SizedBox(
                width: 120,
                child:
              pickBegDate(),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: 
              SizedBox(
                width: 30,
                child:  
              Text('   To',style: TextStyle(fontWeight: FontWeight.bold),)),
              ),
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
                gradient: LinearGradient(colors: [const Color.fromARGB(255, 224, 230, 231),const Color.fromARGB(255, 243, 206, 194)]),
            ),
            child: 
            Column(children: [
           SizedBox(height:10),
              
             RadioListTile(
              title: Text('Omzet by Date',style:TextStyle(color: const Color.fromARGB(255, 43, 25, 25),fontWeight: FontWeight.bold)),
              activeColor: Colors.amber,
              fillColor:  WidgetStateColor.resolveWith((states) => const Color.fromARGB(255, 29, 26, 26)),
              value:1, 
              groupValue: selectedOption, 
              onChanged: (value) {
               setState(() {
                 selectedOption=value!;
               });
             },),
           
              RadioListTile(
              activeColor: Colors.amber,
              fillColor:  WidgetStateColor.resolveWith((states) => const Color.fromARGB(255, 22, 19, 19)),  
              title: Text('Transaction Return by Date',style:TextStyle(color: const Color.fromARGB(255, 7, 4, 4),fontWeight: FontWeight.bold)),
              value:2, 
              groupValue: selectedOption, 
              onChanged: (value) {
                setState(() {
                  selectedOption=value!;
                });
             },),

            SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              setState(() {
                _progress=true;
              });
              if (selectedOption==1)
              {
           //setMessage2( _Text_Beg_Date.text+'-'+ _Text_End_Date.text+'-');
           EasyLoading.show(status: 'Processing..');
           Navigator.push(context, MaterialPageRoute(builder: (context) => InAppWebViewExampleScreen_omzetbydate(date1: _Text_Beg_Date.text, date2: _Text_End_Date.text, kodecab: 'HO', nohp: 'xx'),));
           setState(() {
             _progress=false;
           });
              }else if (selectedOption==2){
                EasyLoading.show(status: 'Processing..');
                
           Navigator.push(context, MaterialPageRoute(builder: (context) => InAppWebViewExampleScreen_returnbydate(date1: _Text_Beg_Date.text, date2: _Text_End_Date.text, kodecab: 'HO', nohp: 'xx'),));
           setState(() {
             _progress=false;
           });
              }
            }, child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Visibility(
                
                visible: _progress,
                child: 
                SizedBox(
                  width: 25,
                  height: 25,
                  child: 
                CircularProgressIndicator.adaptive(strokeWidth: 1,backgroundColor: const Color.fromARGB(255, 39, 19, 19),)
                )
              ),
            SizedBox(width: 5,),  
            Text('Process')
            ]
            )
            
            )
            
            ]
            )
            
            )

            ]
          
        ),
        )
    );
  }
 
 Widget pickBegDate(){
  return Container(
      child: 
      Container(
        alignment: Alignment.center,

              // constraints: BoxConstraints(
              //   minHeight: 10,
              //   maxHeight: 40,
              //   minWidth: 10,
              //   maxWidth: 10
              // ),
          
                decoration: BoxDecoration(
                //     color: Colors.white,
                //  border: Border.all(style: BorderStyle.solid),
                //  borderRadius: BorderRadius.circular(5)
                //shape: BoxShape.rectangle
                ),
        child: 
       
         
         TextField(
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
        style: TextStyle(color: Colors.black,fontSize: 14,decoration: TextDecoration.none,fontWeight: FontWeight.bold),
        controller: _Text_Beg_Date,
        decoration: InputDecoration(
           
          hintText:  'Date',
          // filled: true,
          // fillColor: Colors.white,
          // border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid),
          // borderRadius: BorderRadius.circular(10),
          
          // ),
         labelStyle: TextStyle(color: Colors.black,decoration:TextDecoration.none)
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
    alignment: Alignment.center,
      child: 
      
      TextField(
           textAlign: TextAlign.center,
           textAlignVertical: TextAlignVertical.center,
           style: TextStyle(color: Colors.black,fontSize: 14,decoration: TextDecoration.none,fontWeight: FontWeight.bold),
        controller: _Text_End_Date,
        decoration: InputDecoration(
          hintText:  'Date',
          // filled: true,
          // fillColor: Colors.white,
          // border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid),
          //           borderRadius: BorderRadius.circular(10)
          
          // ),
                    
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