
import 'package:flutter/material.dart';
import 'package:flutter_pos_new/component/mainmenu.dart';
import 'package:flutter_pos_new/component/message/getwarning.dart';
import 'package:flutter_pos_new/component/server.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:flutter_pos_new/main2.dart';
import 'package:flutter_pos_new/modeldata/modeldata.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get_storage/get_storage.dart';



class MultiDatas with  ChangeNotifier {

  final box=GetStorage();



  Future <void> Save_Tranpos(BuildContext context, item_code,String notrans,String kodecab,String typetrans,String custid,String custname) async {


   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/savedatapos.php');
    final response=await http.post(url,
    body: {
      'item_code':item_code,
     'notrans':notrans,
     'kodecab':kodecab,
     'typetrans':typetrans,
     'custid':custid,
     'custname':custname

    }
    );

        if (response.statusCode==200)
    {
    final json=jsonDecode(response.body);

      if (json['errormsg']=='none')
    {
      setMessageAll(context, 'Barcode Warning', 'Barcode '+item_code+' tidak terdatar di system');
      return;
    }

    if (json['errormsg']=='ok')
    {
      setMessage2('Save Data Succesfully');
      return;
    }

    if (json['errormsg']=='failed')
    {
      setMessage2('Save failed');
      return;
    }
     

    }

    notifyListeners();

  }
    



  List<List_Cust_Name>_get_list_custname=[];
  List<List_Cust_Name> get global_list_custname =>_get_list_custname;

  Future <void> get_ListCustName(String customer) async {
    _get_list_custname.clear();
    var url=Uri.parse(NamaServer.Server+'posheru/listcust.php');
    final response=await http.post(url,
    body: {
      'customer':customer,
    }
    );

    if (response.statusCode==200)
  {
     final json=jsonDecode(response.body)['data'] as List;
     final newData=json.map((a)=>List_Cust_Name.fromJson(a)).toList();
     _get_list_custname=newData;

  }
  notifyListeners();
  }
  

  List<TransPos_Sum> _get_total_transpos=[];
  List<TransPos_Sum> get global_total_transpo =>_get_total_transpos;

Future <void> getSumTranPOS(String nopos,String kodecab) async {
 _get_total_transpos.clear();
 var url=Uri.parse('${NamaServer.Server}posheru/listdatabarcodesum.php');
    final response=await http.post(url,
    body: {
      'nopos':nopos,
      'kodecab':kodecab,
      
    }
    );

     if (response.statusCode==200)
     {
     final json=jsonDecode(response.body)['data'] as List;
     print(json);
     final _newData=json.map((a)=>TransPos_Sum.fromJson(a)).toList();
      _get_total_transpos=_newData;
     }
     notifyListeners();

}  





  Future <void> Delete_Tranpos(String idno) async {
   

   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/deletedatapos.php');
    final response=await http.post(url,
    body: {
      'idno':idno,
     
    }
    );

        if (response.statusCode==200)
    {
    final json=jsonDecode(response.body);

    if (json['message']=='ok')
    {
      setMessage2('Delete Succesfully');
    }else
    {
      setMessage2('Delete failed');
    }
     

    }

    notifyListeners();

  }
    


  Future <void> Update_Tranpos(String idno,String qty,String disc_val) async {
   

   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/update_pos_tran.php');
    final response=await http.post(url,
    body: {
      'idno':idno,
      'qty':qty,
      'disc_val':disc_val
    }
    );
    
    
    
    if (response.statusCode==200)
    {
    final json=jsonDecode(response.body);


    print(json);

    }

    notifyListeners();
  }
     

   
  List<List_Item_Pos> _getitem_pos=[];
  List<List_Item_Pos> get global_getitem_pos=>_getitem_pos;

  Future <void> ListBarcodePos(String nopos,String kodecab) async {
    _getitem_pos.clear();
   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/listdatabarcode.php');
    final response=await http.post(url,
    body: {
      'nopos':nopos,
      'kodecab':kodecab
    }
    );
    
    
    
    if (response.statusCode==200)
    {
    final json=jsonDecode(response.body)['data'] as List;
    final json2=jsonDecode(response.body);

    print(json);
  
    box.write('subtot', json2['subtot']);
    box.write('hitpos', json2['hit']);

    final newdata=json.map((e) => List_Item_Pos.fromJson(e)).toList();
    // print(newdata);
    _getitem_pos=newdata;
        notifyListeners();
    } 
     

 
     EasyLoading.dismiss();
    
  }

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
       setMessageAll(context, 'Warning Login', 'Invalid User/Password');
       print(json);
      
    }

     notifyListeners();
     EasyLoading.dismiss();
    
  }

}