import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

void getStatusInet(BuildContext context) async {
  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
   //  setWarning("Mobile Connection lost,please wait..", context);
     //return ;
     
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
    // setWarning("Wifi Connection lost,please wait...", context);
     
    }else
    {
      EasyLoading.dismiss();
       Fluttertoast.showToast(
        msg: "Connection lost,please wait...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
       );
      return;
    }
  }

  void setMessage2(String msg) async{
    await EasyLoading.dismiss();
       Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
       );
  }