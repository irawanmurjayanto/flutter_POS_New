
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




List<List_Item_Return_Detail> _get_list_item_return_detail =[];
List<List_Item_Return_Detail> get global_get_list_item_return_detail =>_get_list_item_return_detail;

Future <void> get_List_Item_Return_Detail(String nopos)async{
  _get_list_item_return_detail.clear();
var url=Uri.parse(NamaServer.Server+'posheru/list_pos_item_return.php');
var response=await http.post(url,
  body: {
    'nopos':nopos,
    // 'tipe':tipe,
    // 'custid':custid,
    // 'custname':custname,
    // 'nohp':nohp,
    // 'alamat':alamat,
  }  
);

    //  if (tipe=='view')
    //  {

      final json=jsonDecode(response.body)['data'] as List;
      print(json);
      final newData=json.map((a)=>List_Item_Return_Detail.fromJson(a)).toList();
      _get_list_item_return_detail=newData;
    //  }

    //  if (tipe=='save')
    //  {
    //   final json=jsonDecode(response.body);
    //    if (json['errormsg']=='ok')
    //    {
    //     setMessage2('Save Data Succesfully');
    //    }
       
    //  }

     notifyListeners();
     EasyLoading.dismiss();
}

List<List_Item_Return_Only> _get_list_return_only =[];
List<List_Item_Return_Only> get global_get_list_return_only =>_get_list_return_only;

Future <void> get_List_Return_Only(String nopos)async{
  _get_list_return_only.clear();
var url=Uri.parse(NamaServer.Server+'posheru/list_pos_return_only.php');
var response=await http.post(url,
  body: {
    'nopos':nopos,
    // 'tipe':tipe,
    // 'custid':custid,
    // 'custname':custname,
    // 'nohp':nohp,
    // 'alamat':alamat,
  }  
);

    //  if (tipe=='view')
    //  {

      final json=jsonDecode(response.body)['data'] as List;
      print(json);
      final newData=json.map((a)=>List_Item_Return_Only.fromJson(a)).toList();
      _get_list_return_only=newData;
    //  }

    //  if (tipe=='save')
    //  {
    //   final json=jsonDecode(response.body);
    //    if (json['errormsg']=='ok')
    //    {
    //     setMessage2('Save Data Succesfully');
    //    }
       
    //  }

     notifyListeners();
     EasyLoading.dismiss();
}



List<List_Return> _get_list_return =[];
List<List_Return> get global_get_list_return =>_get_list_return;

Future <void> get_List_Return(String nopos)async{
  _get_list_return.clear();
var url=Uri.parse(NamaServer.Server+'posheru/list_pos_return.php');
var response=await http.post(url,
  body: {
    'nopos':nopos,
    // 'tipe':tipe,
    // 'custid':custid,
    // 'custname':custname,
    // 'nohp':nohp,
    // 'alamat':alamat,
  }  
);

    //  if (tipe=='view')
    //  {

      final json=jsonDecode(response.body)['data'] as List;
      print(json);
      final newData=json.map((a)=>List_Return.fromJson(a)).toList();
      _get_list_return=newData;
    //  }

    //  if (tipe=='save')
    //  {
    //   final json=jsonDecode(response.body);
    //    if (json['errormsg']=='ok')
    //    {
    //     setMessage2('Save Data Succesfully');
    //    }
       
    //  }

     notifyListeners();
     EasyLoading.dismiss();
}




List<List_Product> _get_list_product =[];
List<List_Product> get global_get_list_product =>_get_list_product;

Future <void> get_save_List_Porduct(String nama)async{
  _get_list_product.clear();
var url=Uri.parse(NamaServer.Server+'posheru/listdata.php');
var response=await http.post(url,
  body: {
    'nama':nama,
    // 'tipe':tipe,
    // 'custid':custid,
    // 'custname':custname,
    // 'nohp':nohp,
    // 'alamat':alamat,
  }  
);

    //  if (tipe=='view')
    //  {
      final json=jsonDecode(response.body)['data'] as List;
      final newData=json.map((a)=>List_Product.fromJson(a)).toList();
      _get_list_product=newData;
    //  }

    //  if (tipe=='save')
    //  {
    //   final json=jsonDecode(response.body);
    //    if (json['errormsg']=='ok')
    //    {
    //     setMessage2('Save Data Succesfully');
    //    }
       
    //  }

     notifyListeners();
     EasyLoading.dismiss();
}


List<List_Customer> _get_list_customer =[];
List<List_Customer> get global_get_list_customer =>_get_list_customer;

Future <void> get_save_List_Customer(String customer)async{
  _get_list_customer.clear();
var url=Uri.parse(NamaServer.Server+'posheru/listcust.php');
var response=await http.post(url,
  body: {
    'customer':customer,
    // 'tipe':tipe,
    // 'custid':custid,
    // 'custname':custname,
    // 'nohp':nohp,
    // 'alamat':alamat,
  }  
);

    //  if (tipe=='view')
    //  {
      final json=jsonDecode(response.body)['data'] as List;
      final newData=json.map((a)=>List_Customer.fromJson(a)).toList();
      _get_list_customer=newData;
    //  }

    //  if (tipe=='save')
    //  {
    //   final json=jsonDecode(response.body);
    //    if (json['errormsg']=='ok')
    //    {
    //     setMessage2('Save Data Succesfully');
    //    }
       
    //  }

     notifyListeners();
     EasyLoading.dismiss();
}



List<List_Profile> _get_profile =[];
List<List_Profile> get global_get_profile =>_get_profile;

Future <void> get_save_List_Profile(String tipe,String nama,String nohp,String alamat)async{
  _get_profile.clear();
var url=Uri.parse(NamaServer.Server+'posheru/toko_profile_view.php');
var response=await http.post(url,
  body: {
    'tipe':tipe,
    'nama':nama,
    'nohp':nohp,
    'alamat':alamat
  }  
);

     if (tipe=='view')
     {
      final json=jsonDecode(response.body)['data'] as List;
      final newData=json.map((a)=>List_Profile.fromJson(a)).toList();
      _get_profile=newData;
     }

     if (tipe=='save')
     {
      final json=jsonDecode(response.body);
       if (json['errormsg']=='ok')
       {

       }
       
     }

     notifyListeners();
     EasyLoading.dismiss();
}




Future <void> Save_Product(String tipe,String kode,String nama,String harga_jual,String harga_beli) async {


   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/savedata_product.php');
    final response=await http.post(url,
    body: {
    'tipe':tipe,
    'kode':kode,
    'nama':nama,
    'harga_jual':harga_jual,
    'harga_beli':harga_beli,

    }
    );

        if (response.statusCode==200)
    {
    final json=jsonDecode(response.body);
      

    if (json['message']=='ok')
    {
      
    setMessage2('Save Data Succesfully');
      return;
    }

    if (json['message']=='failed')
    {
      setMessage2('Save failed');
      return;
    }
     

    }

    notifyListeners();

  }
    



Future <void> Save_Custpos_Edit(String custid,String custname,String nohp,String alamat) async {


   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/savedatacust_edit.php');
    final response=await http.post(url,
    body: {
      'custid':custid,
    'custname':custname,
    'nohp':nohp,
    'alamat':alamat,

    }
    );

        if (response.statusCode==200)
    {
    final json=jsonDecode(response.body);
      

    if (json['message']=='ok')
    {
      
    setMessage2('Save Data Succesfully');
      return;
    }

    if (json['message']=='failed')
    {
      setMessage2('Save failed');
      return;
    }
     

    }

    notifyListeners();

  }
    



Future <void> Save_Custpos(BuildContext context,String custid,String custname,String nohp,String alamat) async {


   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/savedatacust.php');
    final response=await http.post(url,
    body: {
      'custid':custid,
    'custname':custname,
    'nohp':nohp,
    'alamat':alamat,

    }
    );

        if (response.statusCode==200)
    {
    final json=jsonDecode(response.body);
      

      if (json['errormsg']=='exist')
    {
      //print('checkbarcode :'+json);
      setMessageAll(context, 'Cust. Name Warning', 'Customer  '+json['custname']+' sudah pernah dibuat di system');
     // setMessage('Customer Name Sduah pernah ada', context);
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
    



  Future <void> Save_Tranpos_Return(BuildContext context, String item_code,String item_desc,String notrans,String kodecab,String typetrans,String custid,String custname,String u_name,String harga_jual,String harga_beli,String disc_val,String idno_link,String qty,String return_no,String nohp) async {


   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/savedata_return_pos.php');
    final response=await http.post(url,
    body: {
      'item_code':item_code,
      'item_desc':item_desc,
     'notrans':notrans,
     'kodecab':kodecab,
     'typetrans':typetrans,
     'custid':custid,
     'custname':custname,
     'u_name':u_name,
     'harga_jual':harga_jual,
     'harga_beli':harga_beli,
     'disc_val':disc_val,
     'idno_link':idno_link,
     'qty':qty,
     'return_no':return_no,
     'nohp':nohp

    }
    );
 
        if (response.statusCode==200)
    {
    final json=jsonDecode(response.body);
      

    //   if (json['errormsg']=='none')
    // {
    //   //print('checkbarcode :'+json);
    //   setMessageAll(context, 'Barcode Warning', 'Barcode '+json['item_code']+' tidak terdaftar di system');
    //   final player = AudioPlayer(); 
    //    player.setAsset('assets/sound/error.wav');
    //    player.play();
    //   return;
    // }

    if (json['errormsg']=='ok')
    {
       final player = AudioPlayer(); 
       player.setAsset('assets/sound/bell.mpeg');
       player.play();
     // setMessage2('Save Data Succesfully');
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
    




  Future <void> Save_Tranpos(BuildContext context, item_code,String notrans,String kodecab,String typetrans,String custid,String custname,String u_name,String nohp) async {


   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/savedatapos.php');
    final response=await http.post(url,
    body: {
      'item_code':item_code,
     'notrans':notrans,
     'kodecab':kodecab,
     'typetrans':typetrans,
     'custid':custid,
     'custname':custname,
     'u_name':u_name,
     'nohp':nohp

    }
    );
 
        if (response.statusCode==200)
    {
    final json=jsonDecode(response.body);
      

      if (json['errormsg']=='none')
    {
      //print('checkbarcode :'+json);
      setMessageAll(context, 'Barcode Warning', 'Barcode '+json['item_code']+' tidak terdaftar di system');
      final player = AudioPlayer(); 
       player.setAsset('assets/sound/error.wav');
       player.play();
      return;
    }

    if (json['errormsg']=='ok')
    {
       final player = AudioPlayer(); 
       player.setAsset('assets/sound/bell.mpeg');
       player.play();
     // setMessage2('Save Data Succesfully');
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
  


List<TransPos_Sum> _get_total_transpos_return=[];
  List<TransPos_Sum> get global_total_transpo_return =>_get_total_transpos_return;

Future <void> getSumTranPOS_Return(String nopos,String kodecab) async {
 _get_total_transpos_return.clear();
 var url=Uri.parse('${NamaServer.Server}posheru/listdatabarcodesumret.php');
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
      _get_total_transpos_return=_newData;
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



  Future <void> Delete_Tranpos_Return(String idno) async {
   

   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/deletedatapos_return.php');
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
    EasyLoading.dismiss();

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
    

  Future <void> Update_Tranpos_Return(String idno,String qty,String disc_val) async {
   

   // EasyLoading.show(status: 'Processing');
    
    var url=Uri.parse('${NamaServer.Server}posheru/update_pos_tran_return.php');
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
    EasyLoading.dismiss();
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