import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void setMessage(String pesan,BuildContext context){
  final kirim =  SnackBar(content:Text(pesan,style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
  behavior: SnackBarBehavior.floating,
 
  backgroundColor: Colors.teal,
  shape: StadiumBorder(side: BorderSide(width:2,style: BorderStyle.solid,strokeAlign: BorderSide.strokeAlignCenter)),
  margin: EdgeInsets.only(
    left:30,right:30,bottom: MediaQuery.of(context).size.height-450
  ),
  );
  
  ScaffoldMessenger.of(context).showSnackBar(kirim);
   

}

void setMessageAll(BuildContext context,String ttl,String warn){
  showDialog(context:context, builder: (context) {
       return AlertDialog(
          //  title: Text(ttl,textAlign: TextAlign.center,),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(7),
                 decoration: BoxDecoration(
                   color: Colors.white ,
                   borderRadius: BorderRadius.circular(15)
                 ),
                  child:            
                Column(
                  children: [

                    Text(warn,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                    ElevatedButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text('Close'))
                  ]
                
                )
                )
              ],
            ),  
            
         );
       },);
}