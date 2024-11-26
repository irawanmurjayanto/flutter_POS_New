import 'dart:convert';

class Group_Item{

String? id;
String? group_name;

Group_Item({this.id,this.group_name});

factory Group_Item.fromJson(Map<String,dynamic>json)
{
  return Group_Item(
   id:json['id'],
   group_name:json['group_name']
  );
}


}

 
 class List_Item_Pos {
  String?idno;
  String?item_code;
  String?item_desc;
  String?harga_jual;
  String?qty;
  String?disc_val;
  String?subtot;
  String?qtyreturn;

  List_Item_Pos({this.idno,this.item_code,this.item_desc,this.harga_jual,this.qty,this.disc_val,this.subtot,this.qtyreturn});
  
  factory List_Item_Pos.fromJson(Map<String,dynamic>json)
  {
    return List_Item_Pos(
     idno: json['idno'],
     item_code: json['item_code'],
     item_desc: json['item_desc'],
     harga_jual: json['harga_jual'],
     qty: json['qty'],
     disc_val: json['disc_val']??'0',
     subtot: json['subtot'],
     qtyreturn: json['qtyreturn']??'0',
    );
  }


 }
 

 

 class TransPos_Sum {
  String?hitpos;
  String?total;
  

  TransPos_Sum({this.hitpos,this.total});
  
  factory TransPos_Sum.fromJson(Map<String,dynamic>json)
  {
    return TransPos_Sum(
     hitpos: json['hitpos'],
     total: json['total'],
      
    );
  }


 }
 

 class List_Cust_Name{
  String?idno;
  String?custid;
  String?custname;
  String?nohp;
  String?alamat;

  List_Cust_Name({this.idno,this.custid,this.custname,this.nohp,this.alamat}) ;

   factory List_Cust_Name.fromJson(Map<String,dynamic>json)
   {
    return List_Cust_Name(
        idno: json['idno'],
        custid: json['custid'],
        custname: json['custname'],
        nohp: json['nohp'],
        alamat: json['alamat'],
    );

   }
 }


class List_Profile{
  String?IDNO;
  String?nama_toko;
  String?alamat_toko;
  String?no_hp_toko;
  

  List_Profile({this.IDNO,this.nama_toko,this.alamat_toko,this.no_hp_toko}) ;

   factory List_Profile.fromJson(Map<String,dynamic>json)
   {
    return List_Profile(
        IDNO: json['IDNO'],
        nama_toko: json['nama_toko']??'-',
        alamat_toko: json['alamat_toko']??'-',
        no_hp_toko: json['no_hp_toko']??'-',
    );

   }
 }



class List_Customer{
  String?idno;
  String?custid;
  String?custname;
  String?nohp;
  String?alamat;
  

  List_Customer({this.idno,this.custid,this.custname,this.nohp,this.alamat}) ;

   factory List_Customer.fromJson(Map<String,dynamic>json)
   {
    return List_Customer(
        idno: json['idno'],
        custid: json['custid']??'-',
        custname: json['custname']??'-',
        nohp: json['nohp']??'-',
        alamat: json['alamat']??'-',
    );

   }
 }


class List_Product{
  String?idno;
  String?kode;
  String?nama;
  String?harga;
  String?harga_beli;
  

  List_Product({this.idno,this.kode,this.nama,this.harga,this.harga_beli}) ;

   factory List_Product.fromJson(Map<String,dynamic>json)
   {
    return List_Product(
        idno: json['idno'],
        kode: json['kode']??'-',
        nama: json['nama']??'-',
        harga: json['harga']??'-',
        harga_beli: json['harga_beli']??'-',
    );

   }
 }


 
class List_Return{
  String?notrans_link;
  String?tgl_rec;
  String?custid;
  String?custname;
 

  List_Return({this.notrans_link,this.tgl_rec,this.custid,this.custname}) ;

   factory List_Return.fromJson(Map<String,dynamic>json)
   {
    return List_Return(
        notrans_link: json['notrans_link']??'-',
        tgl_rec: json['tgl_rec']??'-',
        custid: json['custid']??'-',
        custname: json['custname']??'-',
        
       
    );

   }
 }


 
 class List_Item_Return_Only {
   String?idno;
  String?item_code;
  String?item_desc;
  String?harga_jual;
  String?qty;
  String?disc_val;
  String?custid;
  String?custname;
  String?subtotal;
 

  List_Item_Return_Only({this.idno,this.item_code,this.item_desc,this.harga_jual,this.qty,this.disc_val,this.custid,this.custname,this.subtotal});
  
  factory List_Item_Return_Only.fromJson(Map<String,dynamic>json)
  {
    return List_Item_Return_Only(
      idno: json['idno'],
     item_code: json['item_code'],
     item_desc: json['item_desc'],
     harga_jual: json['harga_jual'],
     qty: json['qty'],
     disc_val: json['disc_val']??'0',
     custid: json['custid'],
     custname: json['custname'],
     subtotal: json['subtotal'],
    
    );
  }


 }



  
 class List_Item_Return_Detail {
  String?idno;
  String?item_code;
  String?item_desc;
  String?harga_jual;
  String?harga_beli;
  String?qty_pos;
  String?qty_ret;
  String?disc_val;
  String?custid;
  String?custname;
  String?nohp;

  List_Item_Return_Detail({this.idno,this.item_code,this.item_desc,this.harga_jual,this.harga_beli,this.qty_pos,this.qty_ret,this.disc_val,this.custid,this.custname,this.nohp});
  
  factory List_Item_Return_Detail.fromJson(Map<String,dynamic>json)
  {
    return List_Item_Return_Detail(
     idno: json['idno'],
     item_code: json['item_code'],
     item_desc: json['item_desc'],
     harga_jual: json['harga_jual'],
     harga_beli: json['harga_beli'],
     qty_pos: json['qty_pos'],
     qty_ret: json['qty_ret'],
     disc_val: json['disc_val']??'0',
     custid: json['custid'],
     custname: json['custname'],
     nohp: json['nohp'],
    );
  }


 }

 class List_UserPass{
  String?user;
  String?password;
  String?hak;

  List_UserPass({this.user,this.password,this.hak});

  factory List_UserPass.fromJson(Map<String,dynamic> json)
  {
    return List_UserPass(user: json['user'], password: json['password'], hak: json['hak']);
  }

 }
 