
import 'package:flutter/material.dart';
import 'package:flutter_pos_new/component/mainmenu.dart';
import 'package:flutter_pos_new/component/server.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:flutter_pos_new/main2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get_storage/get_storage.dart';



class MultiDatas with  ChangeNotifier {

  final box=GetStorage();

  Future <void> getUserPass(String user,String pass,BuildContext context) async {

   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/cariuser.php');
    final response=await http.post(url,
    body: {
      'user1':user,
      'pass1':pass
    }
    );
    
    final json=jsonDecode(response.body);

    if (json['data']=='ok')
    {
       print(json);
      setMessage2('Succesfully Connected');
      box.write('username', user);
      await Navigator.push(context, MaterialPageRoute(builder: (context) => const Main2(),));
    }else
    {
       print(json);
       setMessage2('User/Password Invalid');
    }

     notifyListeners();
     EasyLoading.dismiss();
    
  }

}