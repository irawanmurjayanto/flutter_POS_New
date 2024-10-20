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

class Unit_Item{

  String?id;
  String?unit_name;

  Unit_Item({this.id,this.unit_name});

  factory Unit_Item.fromJson(Map<String,dynamic>json)
  {
    return Unit_Item(
      id: json['id'],
      unit_name: json['unit_name']
    );
  }

   

}

class List_MasterBarang{

String?id;
String?kode;
String?nama;
String?barcode;
String?unititem;
String?groupitem;
String?pict_desc;
String?datedoc;
String?notes;

List_MasterBarang({ this.id,this.kode,this.nama,this.barcode,this.unititem,this.groupitem,this.pict_desc,this.datedoc,this.notes});

 factory List_MasterBarang.fromJson(Map<String,dynamic>json)
 {
   return List_MasterBarang(
    id:json['id'],
    kode:json['kode'],
    nama:json['nama'],
    barcode:json['barcode'],
    unititem:json['unititem'],
    groupitem:json['groupitem'],
    pict_desc:json['pict_desc'],
    datedoc:json['datedoc'],
    notes:json['notes'],
   );
 }


}


 class List_Dept {
  String?id; 
  String?dept_name;

  List_Dept({this.id,this.dept_name});

  factory List_Dept.fromJson(Map<String,dynamic>json)
  {
    return List_Dept(
      id: json['id'],
      dept_name:json['dept_name'],
    );
  }
   

 }

 class Lihat_PR_Manual {

    String? idno;
    String? pr_no;
    String? kode_item;
    String? nama_item;
    String? tgl_pr;
    String? qty_pr;
    String? unit_pr;
    String? dept_pr;
    String? u_name;

    Lihat_PR_Manual({this.idno,this.pr_no,this.kode_item,this.nama_item,this.tgl_pr,this.qty_pr,this.unit_pr,this.dept_pr,this.u_name});

    factory Lihat_PR_Manual.fromJson(Map<String,dynamic>json)
    {
      return Lihat_PR_Manual (
        
        idno:json['idno'], 
        pr_no:json['pr_no'],
        kode_item:json['kode_item'],
        nama_item:json['nama_item'],
        tgl_pr:json['tgl_pr'],
        qty_pr:json['qty_pr'],
        unit_pr:json['unit_pr'],
        dept_pr:json['dept_pr'],
        u_name:json['u_name']

        );

      
    }
 }

 class List_PR_Detail{
  String?pr_no;
  String?dept_pr;
  String?tgl_pr;

  List_PR_Detail({this.pr_no,this.dept_pr,this.tgl_pr});

  factory List_PR_Detail.fromJson(Map<String,dynamic>json)
  {
    return List_PR_Detail(
      pr_no:json['pr_no'],
      dept_pr: json['dept_pr'],
      tgl_pr: json['tgl_pr'],
    );
  }



 }
