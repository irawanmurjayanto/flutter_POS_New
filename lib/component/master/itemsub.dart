import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:provider/provider.dart';

class Item_Sub_Master extends StatefulWidget {
  final String kode;
  final String nama;
  final String harga_jual;
  final String harga_beli;
  const Item_Sub_Master ({Key?key,required this.kode,required this.nama,required this.harga_jual,required this.harga_beli}):super(key: key);

  @override
  State<Item_Sub_Master > createState() => _Item_Sub_MasterState(kode:kode,nama:nama,harga_jual:harga_jual,harga_beli:harga_beli);
}

class _Item_Sub_MasterState extends State<Item_Sub_Master > {
   final String kode;
  final String nama;
  final String harga_jual;
  final String harga_beli;
    _Item_Sub_MasterState({required this.kode,required this.nama,required this.harga_jual,required this.harga_beli});

  String ? _temp_kode;
  final _Text_Nama =TextEditingController();
  final _Text_Harga_Jual =TextEditingController();
  final _Text_Harga_Beli =TextEditingController();

  getData() async {
    getStatusInet(context);
   // EasyLoading.show(status: 'Processing..');
//   await Provider.of<MultiDatas>(context,listen: false).get_save_List_Customer(_Text_Nama.text);
  // final provx=Provider.of<MultiDatas>(context,listen: false);
   setState(() {
      _temp_kode=kode;
      _Text_Nama.text=nama;
      _Text_Harga_Jual.text=harga_jual;
      _Text_Harga_Beli.text=harga_beli;
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
        appBar: AppBar(title: Text('Product Data'),
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
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.solid)
                  ),
                  child: 
               Text(_temp_kode==null?'-':_temp_kode!),
                ),
                SizedBox(height: 20,),
                TextField(
                  
                  controller: _Text_Nama,
                  decoration: InputDecoration(
                     suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Nama.text='';
                      });
                    }, icon: Icon(Icons.close)),
                    labelText: 'Nama Product',
                    
                      labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
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
                 SizedBox(height: 20,),
                TextField(
                   
                  controller: _Text_Harga_Jual,
                  decoration: InputDecoration(
                     suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Harga_Jual.text='';
                      });
                    }, icon: Icon(Icons.close)),
                                      labelText: 'Harga Jual',
                           labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      
                      borderSide: BorderSide(style: BorderStyle.solid)
                    )
                  ),
                  onChanged: (value) {
                    _Text_Harga_Jual.text=value;
                  },
                ),

                 SizedBox(height: 20,),
                TextField(
                  
                  controller: _Text_Harga_Beli,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Harga_Beli.text='';
                      });
                    }, icon: Icon(Icons.close)),
                          
                          labelText: 'Harga Beli',
                          labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      
                      borderSide: BorderSide(style: BorderStyle.solid)
                    )
                  ),
                  maxLines: 2,
                  onChanged: (value) {
                    _Text_Harga_Beli.text=value;
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
                      //await Provider.of<MultiDatas>(context,listen: false).get_save_List_Profile('save',_Text_Nama.text,_Text_Nohp.text,_Text_Alamat.text);
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