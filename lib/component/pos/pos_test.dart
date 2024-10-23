import 'package:flutter/material.dart';
import 'package:flutter_pos_new/component/format/number.dart';
import 'package:get_storage/get_storage.dart';

class Pos_Test extends StatefulWidget {
  const Pos_Test({super.key});

  @override
  State<Pos_Test> createState() => _Pos_TestState();
}

class _Pos_TestState extends State<Pos_Test> {
  final box=GetStorage();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.blue,
        elevation: 0,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: 
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Text('Grand Total (Rp.)',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                ),

                SizedBox(width: 5,),
                  Expanded(
                
                  child: 
                Container(
                   padding: EdgeInsets.all(5),
                   decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  
                //  child: Text(CurrencyFormat.convertToIdr(int.parse(box.read('subtot')), 0),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.right,),
                )
                  )
               ],
            ),
            SizedBox(height: 3,),
            //total Transaction
             Row(
              children: [
                SizedBox(
                  width: 150,
                  child: 
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Text('Transaction Total',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                ),

                SizedBox(width: 5,),
                  Expanded(
 
                  child: 
                Container(
                   padding: EdgeInsets.all(5),
                   decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                 // child: Text(CurrencyFormat.convertToIdr(box.read('hitpos'), 0).toString()+ (box.read('hitpos')==1?' (item)':' (items)').toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.right,),
                )
                  )
               ],
            )
          ],
        )
      ),
      appBar: AppBar(
        title: const Text(
          'Pos Transaction',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
               // scanBarcodeNormal();
              
              },
              icon: Icon(Icons.barcode_reader)),
          IconButton(
              onPressed: () {
                //getCustomer();
              },
              icon: Icon(Icons.barcode_reader))
        ],
      ),
    );
  }
}