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
 

 
