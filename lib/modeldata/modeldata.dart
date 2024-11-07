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