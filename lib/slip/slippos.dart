import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:print_bluetooth_thermal/post_code.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:image/image.dart' as img;
import 'package:print_bluetooth_thermal/print_bluetooth_thermal_windows.dart';

class PrintSlipPOS extends StatefulWidget {
  const PrintSlipPOS({super.key});

  @override
  State<PrintSlipPOS> createState() => _PrintSlipPOSState();
}

class _PrintSlipPOSState extends State<PrintSlipPOS> {

  Future <void> setupPrint() async{
      await PrintBluetoothThermal.isPermissionBluetoothGranted;
      await PrintBluetoothThermal.bluetoothEnabled;

  }

  @override
  void initState() {
    setupPrint();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Print To Thermal'),
      actions: [
        IconButton(onPressed: () {
          
        }, icon: Icon(Icons.print))
      ],
      ),

    );
  }
}