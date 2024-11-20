import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pos_new/component/format/number.dart';
import 'package:flutter_pos_new/component/master/item.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Item_Sub_Master extends StatefulWidget {
  final String tipe;
  final String kode;
  final String nama;
  final String harga_jual;
  final String harga_beli;
  const Item_Sub_Master ({Key?key,required this.tipe,required this.kode,required this.nama,required this.harga_jual,required this.harga_beli}):super(key: key);

  @override
  State<Item_Sub_Master > createState() => _Item_Sub_MasterState(tipe:tipe,kode:kode,nama:nama,harga_jual:harga_jual,harga_beli:harga_beli);
}

class _Item_Sub_MasterState extends State<Item_Sub_Master > {
    final String tipe;
   final String kode;
  final String nama;
  final String harga_jual;
  final String harga_beli;
    _Item_Sub_MasterState({required this.tipe,required this.kode,required this.nama,required this.harga_jual,required this.harga_beli});

  String ? _temp_kode;
  final _Text_Kode =TextEditingController();
  final _Text_Nama =TextEditingController();
  final _Text_Harga_Jual =TextEditingController();
  final _Text_Harga_Beli =TextEditingController();

  getData() async {
    getStatusInet(context);
   // EasyLoading.show(status: 'Processing..');
//   await Provider.of<MultiDatas>(context,listen: false).get_save_List_Customer(_Text_Nama.text);
  // final provx=Provider.of<MultiDatas>(context,listen: false);
  final NumberFormat numFormat = NumberFormat('#,###', 'id');
   setState(() {
      _Text_Kode.text=kode;
      _Text_Nama.text=nama;
      _Text_Harga_Jual.text=numFormat.format(int.parse(harga_jual));
    //  _Text_Harga_Jual.text=numFormat.format(int.parse(harga_beli));
      _Text_Harga_Beli.text=CurrencyFormat.convertToIdr(int.parse(harga_beli),0);

   });
  


  } 
  @override
  void initState() {
    getData();
     
    // CurrencyFormat.convertToIdr(int.parse(_Text_Harga_Jual.text), 0).toString();
                                
    // CurrencyFormat.convertToIdr(int.parse(_Text_Harga_Beli.text), 0)
    //                             .toString();
    // TODO: implement initState
    super.initState();
  }
   static const _locale = 'id';
  //String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  //String get _currency => numFormat.currencySymbol;
  
  @override
  Widget build(BuildContext context) {
     final screenSize=MediaQuery.of(context).size;
    return  Scaffold(
        appBar: AppBar(title: Text('Product Data'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        ),
        body: 
        
        SingleChildScrollView(child: 
        Container(
           width: screenSize.width/1,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.lightBlue,const Color.fromARGB(255, 201, 195, 175)])
          ),
          child:   Column(
            
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
              //   Container(
              //     padding: EdgeInsets.all(5),
              //     decoration: BoxDecoration(
              //       border: Border.all(style: BorderStyle.solid)
              //     ),
              //     child: 
              //  Text(_temp_kode==null?'-':_temp_kode!),
              //   ),

               SizedBox(height: 20,),
                Wcaption('Kode  Product'),
                TextField(
                  
                  controller: _Text_Kode,
                  decoration: InputDecoration(
                   // prefixText: CurrencyFormat.convertToIdr(int.parse(_Text_Harga_Jual.text), 0).toString(),
                   // prefixText: _currency,
                     suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Kode.text='';
                      });
                    }, icon: Icon(Icons.close)),
                    // labelText: 'Nama Product',
                    
                    //   labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      
                      borderSide: BorderSide(style: BorderStyle.solid)
                    )
                  ),
                  onChanged: (value) {
                    _Text_Kode.text=value;
                  },
                ),



                SizedBox(height: 20,),
                Wcaption('Nama Product'),
                TextField(
                  
                  controller: _Text_Nama,
                  decoration: InputDecoration(
                   // prefixText: CurrencyFormat.convertToIdr(int.parse(_Text_Harga_Jual.text), 0).toString(),
                   // prefixText: _currency,
                     suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Nama.text='';
                      });
                    }, icon: Icon(Icons.close)),
                    // labelText: 'Nama Product',
                    
                    //   labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
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
                Wcaption('Harga Jual'), 
                TextField(
                   inputFormatters: <TextInputFormatter>[CurrencyTextInputFormatter.currency(locale: 'ID',decimalDigits: 0,symbol: '')],
                  controller: _Text_Harga_Jual,
                  decoration: InputDecoration(
                   // prefixText: _currency,
                 //  prefixText: NumberFormat.simpleCurrency(name: 'ID').decimalDigits.toString(),
                     suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Harga_Jual.text='';
                      });
                    }, icon: Icon(Icons.close)),
                          //             labelText: 'Harga Jual',
                          //  labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
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
                 Wcaption('Nama Beli'),
                TextField(
                  inputFormatters: <TextInputFormatter>[CurrencyTextInputFormatter.currency(locale: 'ID',decimalDigits: 0,symbol: '')],
                   keyboardType: TextInputType.number,
                  controller: _Text_Harga_Beli,
                  decoration: InputDecoration(
                 //    prefixText:  _currency,
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Harga_Beli.text='';
                        
                      });
                    }, icon: Icon(Icons.close)),
                          
                          // labelText: 'Harga Beli',
                          // labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
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
                      if (tipe=='edit')
                      {
                      await Provider.of<MultiDatas>(context,listen: false).Save_Product('edit', _Text_Kode.text, _Text_Nama.text, _Text_Harga_Jual.text.replaceAll('.', ''), _Text_Harga_Beli.text.replaceAll('.', ''));
                      }else
                      {
                        await Provider.of<MultiDatas>(context,listen: false).Save_Product('new', _Text_Kode.text, _Text_Nama.text, _Text_Harga_Jual.text.replaceAll('.', ''), _Text_Harga_Beli.text.replaceAll('.', ''));
                      }
                     
                     Navigator.pop(context);
                      await Provider.of<MultiDatas>(context,listen: false).get_save_List_Porduct('');  
                     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>new Item_Master(),));
                     // setMessage2(_temp_kode!+_Text_Nama.text+_Text_Harga_Jual.text.replaceAll('.', '')+ _Text_Harga_Beli.text);
                    // Navigator.pop(context);
                      
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
        )
        );
    
    
  }

   Widget Wcaption(String judul)
  {
    return Container(
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.orange,Colors.black]),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
       // borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5),
      ),
      padding: EdgeInsets.all(5),
      child: 
      SizedBox(
       width: 100,
        child: 
      Text(judul,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.left,),
      )
    );
  }
}