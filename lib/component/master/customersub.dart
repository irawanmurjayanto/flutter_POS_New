import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:provider/provider.dart';

class Customer_Sub_Master extends StatefulWidget {
  final String custid;
  const Customer_Sub_Master ({Key?key,required this.custid}):super(key: key);

  @override
  State<Customer_Sub_Master > createState() => _Customer_Sub_MasterState(custid:custid);
}

class _Customer_Sub_MasterState extends State<Customer_Sub_Master > {
    final String custid;
    _Customer_Sub_MasterState({required this.custid});

  String ? _temp_idno;
  final _Text_Nama =TextEditingController();
  final _Text_Alamat =TextEditingController();
  final _Text_Nohp =TextEditingController();

  getData() async {
    getStatusInet(context);
    EasyLoading.show(status: 'Processing..');
   await Provider.of<MultiDatas>(context,listen: false).get_save_List_Profile('view','','','');
   final provx=Provider.of<MultiDatas>(context,listen: false);
   setState(() {
      _temp_idno=provx.global_get_profile[0].IDNO!;
      _Text_Nama.text=provx.global_get_profile[0].nama_toko!;
      _Text_Alamat.text=provx.global_get_profile[0].alamat_toko!;
      _Text_Nohp.text=provx.global_get_profile[0].no_hp_toko!;
   });
  


  } 
  @override
  void initState() {
    getData();
    
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text('Profile Shop'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.lightBlue,Colors.amberAccent])
          ),
          child:   Column(
            
 
              children: [
             //   Text('idno : '+_temp_idno==null?'-':_temp_idno!),
                SizedBox(height: 5,),
                TextField(
                  
                  controller: _Text_Nama,
                  decoration: InputDecoration(
                     suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Nama.text='';
                      });
                    }, icon: Icon(Icons.close)),
                    labelText: 'Nama',
                    labelStyle: TextStyle(fontSize: 20 ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      
                      borderSide: BorderSide(style: BorderStyle.solid)
                    )
                  ),
                  onChanged: (value) {
                    _Text_Nama.text=value;
                  },
                ),

//nohp
                 SizedBox(height: 10,),
                TextField(
                   
                  controller: _Text_Nohp,
                  decoration: InputDecoration(
                     suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Nohp.text='';
                      });
                    }, icon: Icon(Icons.close)),
                                      labelText: 'No. HP',
                    labelStyle: TextStyle(fontSize: 20 ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      
                      borderSide: BorderSide(style: BorderStyle.solid)
                    )
                  ),
                  onChanged: (value) {
                    _Text_Nohp.text=value;
                  },
                ),

                 SizedBox(height: 10,),
                TextField(
                   
                  controller: _Text_Alamat,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Alamat.text='';
                      });
                    }, icon: Icon(Icons.close)),
                                      labelText: 'Alamat',
                    labelStyle: TextStyle(fontSize: 20 ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      
                      borderSide: BorderSide(style: BorderStyle.solid)
                    )
                  ),
                  maxLines: 2,
                  onChanged: (value) {
                    _Text_Alamat.text=value;
                  },
                ),
                SizedBox(height: 10,),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () async {
                      getStatusInet(context);
                      EasyLoading.show(status: 'Processing..');
                      await Provider.of<MultiDatas>(context,listen: false).get_save_List_Profile('save',_Text_Nama.text,_Text_Nohp.text,_Text_Alamat.text);
                      Navigator.pop(context);
                      
                    }, child: Text('Save')),
                    SizedBox(width: 5,),
                      ElevatedButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text('Close')),
                  ],
                )
              ],
          )
          ),

        );
    
    
  }
}