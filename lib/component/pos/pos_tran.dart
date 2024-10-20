import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:flutter_pos_new/component/warning.dart';

class Pos_Tran extends StatefulWidget {
  const Pos_Tran({super.key});

  @override
  State<Pos_Tran> createState() => _Pos_TranState();
}

class _Pos_TranState extends State<Pos_Tran> {
  final _Text_Cust = TextEditingController();
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

  getNoref() async {
    setState(() {
      int n2 = NoRef.millisecondsSinceEpoch;
      no_pos = 'POS-$n2';
    });

    return no_pos!;
  }

  @override
  void initState() {
    getNoref();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        elevation: 0,
        child: Text(no_pos!),
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
                WCalc()
              ],
            )),
      ),
    );
  }

  Widget WCalc() {
    return Container(
        margin: const EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height / 1.8,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.none), color: Colors.white),
        child: const Center(
          child: Text('Text'),
        ));
  }

  Widget Header() {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black),
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
                    suffixIcon: IconButton(onPressed: () {
                      getCustomer();
                    }, icon: Icon(Icons.card_giftcard)),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold), 
                      hintText: 'Customer Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(style: BorderStyle.solid))),
                ),
              ),
            ],
          )
          );
         
  }
}
