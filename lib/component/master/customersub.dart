import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pos_new/component/master/customer.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:provider/provider.dart';

class Customer_Sub_Master extends StatefulWidget {
  final String custid;
  final String custname;
  final String nohp;
  final String alamat;
  const Customer_Sub_Master ({Key?key,required this.custid,required this.custname,required this.nohp,required this.alamat}):super(key: key);

  @override
  State<Customer_Sub_Master > createState() => _Customer_Sub_MasterState(custid:custid,custname:custname,nohp:nohp,alamat:alamat);
}

class _Customer_Sub_MasterState extends State<Customer_Sub_Master > {
    final String custid;
  final String custname;
  final String nohp;
  final String alamat;
    _Customer_Sub_MasterState({required this.custid,required this.custname,required this.nohp,required this.alamat});

  String ? _temp_custid;
  final _Text_Nama =TextEditingController();
  final _Text_Alamat =TextEditingController();
  final _Text_Nohp =TextEditingController();

  getData() async {
    getStatusInet(context);
   // EasyLoading.show(status: 'Processing..');
//   await Provider.of<MultiDatas>(context,listen: false).get_save_List_Customer(_Text_Nama.text);
  // final provx=Provider.of<MultiDatas>(context,listen: false);
   setState(() {
      _temp_custid=custid;
      _Text_Nama.text=custname;
      _Text_Alamat.text=alamat;
      _Text_Nohp.text=nohp;
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
        appBar: AppBar(title: Text('Customer Data'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.lightBlue,Colors.amberAccent])
          ),
          child:   Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   padding: EdgeInsets.all(5),
                //   decoration: BoxDecoration(
                //     color: Colors.amber,
                //     border: Border.all(style: BorderStyle.solid),
                //     borderRadius: BorderRadius.circular(20)
                //   ),
                //   child: 
                //   Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //            Text(_temp_custid==null?'-':_temp_custid!,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                //     ],
                //   )
            
                // ),
                SizedBox(height: 10,),
                Wcaption('Nama '),
               
                TextField(
                  
                  controller: _Text_Nama,
                  decoration: InputDecoration(
                     suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Nama.text='';
                      });
                    }, icon: Icon(Icons.close)),
             
                       //labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
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
                 Wcaption('No. HP '),
                TextField(
                   
                  controller: _Text_Nohp,
                  decoration: InputDecoration(
                     suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Nohp.text='';
                      });
                    }, icon: Icon(Icons.close)),
                     //                 labelText: 'No. HP',
                    //   labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
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
                 Wcaption('Alamat '),
                TextField(
                   
                  controller: _Text_Alamat,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Alamat.text='';
                      });
                    }, icon: Icon(Icons.close)),
                                   //   labelText: 'Alamat',
                     //  labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
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
                     // setMessage2(_temp_custid!+_Text_Nama.text+_Text_Nohp.text+_Text_Alamat.text);
                     await Provider.of<MultiDatas>(context,listen: false).Save_Custpos_Edit(_temp_custid!,_Text_Nama.text,_Text_Nohp.text,_Text_Alamat.text);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Customer_Master()));
                   //   Navigator.pop(context);
                      
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