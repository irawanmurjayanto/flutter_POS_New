import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_pos_new/component/format/number.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'dart:convert';

import 'package:flutter_pos_new/component/warning.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_pos_new/currecy_format.dart';

class Pos_Tran extends StatefulWidget {
  const Pos_Tran({super.key});

  @override
  State<Pos_Tran> createState() => _Pos_TranState();
}

class _Pos_TranState extends State<Pos_Tran> {
  final box=GetStorage();

  final _Text_Cust = TextEditingController();
  final _Text_Qty = TextEditingController();
  final _Text_Disc = TextEditingController();

  getEditPos(String qty,String disc_val,String idno,String item_desc) async{
   
    setState(() {
      _Text_Qty.text=qty;
      _Text_Disc.text=disc_val;
    });

    showDialog(context: context, builder: (context) {
      
      return AlertDialog(
        title: Text('Edit : ('+idno+')'+item_desc,style: TextStyle(fontSize: 12),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              //edit qty
              TextFormField(
                
                controller: _Text_Qty,
                decoration: InputDecoration(
                  
                      suffixIcon: IconButton(onPressed: () {
                      setState(() {
                      _Text_Qty.text='';
                    });
                  }, icon: Icon(Icons.edit_document)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    
                    borderSide: BorderSide(style: BorderStyle.solid,color: Colors.black)
                  )
                ),
                onChanged: (value) {
                  setState(() {
                     _Text_Qty.text=value;
                  });
                 
                },
                onTap: () => _Text_Qty.selection = TextSelection(baseOffset: 0, extentOffset: _Text_Qty.value.text.length),
              ),

                SizedBox(height: 5,),
                  //edit discval
              TextFormField(
                controller: _Text_Disc,
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: () {
                    setState(() {
                      _Text_Disc.text='';
                    });
                  }, icon: Icon(Icons.edit_document)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    
                    borderSide: BorderSide(style: BorderStyle.solid,color: Colors.black)
                  )
                ),
                onChanged: (value) {
                  setState(() {
                    _Text_Disc.text=value;
                  });
                    
                },
                         onTap: () => _Text_Disc.selection = TextSelection(baseOffset: 0, extentOffset: _Text_Disc.value.text.length),
              )
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(onPressed: () async {
                await Provider.of<MultiDatas>(context,listen: false).Update_Tranpos(idno, _Text_Qty.text, _Text_Disc.text);
                await Provider.of<MultiDatas>(context,listen: false).ListBarcodePos(no_pos!, kodecab);
                Navigator.pop(context);
              }, icon: Icon(Icons.save)),
                SizedBox(width: 5,),
               IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.close))
            ],
          )
        ],
      );
    },);
  }

  getCustomer() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Customer Name'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _Text_Cust,
                decoration: InputDecoration(
                    hintText: 'Customer Name Search',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(style: BorderStyle.solid))),
              )
            ],
          ),
        );
      },
    );
  }

  final _barcodecode = TextEditingController();
  int? _jumlah;
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff0000", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _barcodecode.text = barcodeScanRes;
      _jumlah = 1;
    });
  }

  final NoRef = DateTime.now();

  String? no_pos;
  final String kodecab='HO';

  getNoref() async {
    setState(() {
      int n2 = NoRef.millisecondsSinceEpoch;
      no_pos = 'POS-$n2';
    });

    return no_pos!;
  }

  getTotal()async{
    await Provider.of<MultiDatas>(context,listen: false).ListBarcodePos('POS000000024', 'HO');
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  void initState() {
    getTotal();
    getNoref();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Text(CurrencyFormat.convertToIdr(int.parse(box.read('subtot')==null?'0':box.read('subtot')), 0),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.right,),
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
                 child: Text(CurrencyFormat.convertToIdr(box.read('hitpos')==null?'0':box.read('hitpos'), 0).toString()+ (box.read('hitpos')==1?' (item)':' (items)').toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.right,),
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
                scanBarcodeNormal();
              },
              icon: Icon(Icons.barcode_reader)),
          IconButton(
              onPressed: () {
                getCustomer();
              },
              icon: Icon(Icons.barcode_reader))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(style: BorderStyle.solid)),
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                  child: WCust_Name(),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  no_pos!,
                  style: const TextStyle(color: Colors.white),
                ),
                Header(),
                const SizedBox(
                  height: 5,
                ),
                WDetail()
              ],
            )),
      ),
    );
  }

  Widget WDetail() {
    return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height / 1.8,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  style: BorderStyle.solid,
                )),
            child: FutureBuilder(
              future: Provider.of<MultiDatas>(context, listen: false)
                  .ListBarcodePos('POS000000024', 'HO'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Consumer<MultiDatas>(
                    builder: (context, provx, child) {
                      return ListView.builder(
                        itemCount: provx.global_getitem_pos.length,
                        itemBuilder: (context, i) {
                          return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(color: Colors.white),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                        Colors.blue,
                                        Colors.green,
                                      ])),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(child: 
                                          Container(
                                              child: Text(
                                            provx.global_getitem_pos[i]
                                                    .item_desc! +
                                                '(' +
                                                provx.global_getitem_pos[i]
                                                    .item_code! +
                                                ')',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ))
                                          ),
                                          SizedBox
                                          
                                          (width: 50,
                                            
                                            child: 
                                          IconButton(onPressed: () {
                                            getEditPos(provx.global_getitem_pos[i].qty!, provx.global_getitem_pos[i].disc_val!, provx.global_getitem_pos[i].idno!, provx.global_getitem_pos[i].item_desc!);
                                          }, icon: Icon(Icons.edit_calendar),iconSize: 30, )
                                          
                                          ),

                                              SizedBox
                                          
                                          (width: 50,
                                            
                                            child: 
                                          IconButton(onPressed: () {
                                            
                                          }, icon: Icon(Icons.delete),iconSize: 30, )
                                          
                                          ),
                                        ],
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Text('SUb Detail : '),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            CurrencyFormat.convertToIdr(
                                                int.parse(provx
                                                    .global_getitem_pos[i]
                                                    .harga_jual!),
                                                0),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            CurrencyFormat.convertToIdr(
                                                int.parse(provx
                                                    .global_getitem_pos[i]
                                                    .qty!),
                                                0),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            CurrencyFormat.convertToIdr(
                                                int.parse(provx
                                                    .global_getitem_pos[i]
                                                    .disc_val!),
                                                0),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Text('Sub Total : Rp. ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Text(
                                          CurrencyFormat.convertToIdr(
                                              int.parse(provx
                                                  .global_getitem_pos[i]
                                                  .subtot!),
                                              0),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Text('     ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ])
                                ],
                              ));
                        },
                      );
                    },
                  );
                }
              },
            )));
  }

  Widget Header() {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.black),
              child: const Text(
                'Product',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black),
              child: const Text('Harga',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black),
              child: const Text('Qty',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black),
              child: const Text('Discount',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
            onTap: () {
              getCustomer();
            },
          )),
        ],
      ),
    );
  }

  Widget WCust_Name() {
    return Container(
        // decoration: BoxDecoration(
        //   color: Colors.white
        // ),
        padding: const EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _Text_Cust,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          getCustomer();
                        },
                        icon: Icon(Icons.card_giftcard)),
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    hintText: 'Customer Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            const BorderSide(style: BorderStyle.solid))),
              ),
            ),
          ],
        ));
  }
}
