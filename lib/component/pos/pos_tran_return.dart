import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_pos_new/component/format/number.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/report/rpt_transpos.dart';
import 'package:flutter_pos_new/component/report/rpt_transpos_return.dart';
import 'dart:convert';

import 'package:flutter_pos_new/component/warning.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
//import 'package:audioplayers/audioplayers.dart';
//import 'package:flutter_pos_new/currecy_format.dart';

class Pos_Tran_Return extends StatefulWidget {
  const Pos_Tran_Return({super.key});

  @override
  State<Pos_Tran_Return> createState() => _Pos_Tran_ReturnState();
}

class _Pos_Tran_ReturnState extends State<Pos_Tran_Return> {
  final box = GetStorage();

  final _Text_Cust = TextEditingController();
  final _Text_Cust_Dialog = TextEditingController();
  final _Text_Qty = TextEditingController();
  final _Text_Disc = TextEditingController();
  final _Text_Add_Custid = TextEditingController();
  final _Text_Add_Custname = TextEditingController();
  final _Text_Add_Nohp = TextEditingController();
  final _Text_Add_Alamat = TextEditingController();

  String? _temp_qty_pos;
  String? _temp_disc_pos;

  getAdd_Customer() async {
    final String custidauto =
        'C-' + DateTime.now().microsecondsSinceEpoch.toString();
    setState(() {
      _Text_Add_Custid.text = custidauto;
    });

    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
            child: AlertDialog(
                title: Text('Add Customer'),
                content: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid, color: Colors.black)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //custid
                        TextField(
                          controller: _Text_Add_Custid,
                          decoration: InputDecoration(hintText: 'Customer ID'),
                          onChanged: (value) {
                            setState(() {
                              _Text_Add_Custid.text = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //custname
                        TextField(
                          autofocus: true,
                          controller: _Text_Add_Custname,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.pink)),
                              hintText: 'Customer Name'),
                          onChanged: (value) {
                            setState(() {
                              _Text_Add_Custname.text = value;
                            });
                          },
                        ),

                        //NOHP
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: _Text_Add_Nohp,
                          decoration: InputDecoration(
                            hintText: 'Handphone No',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Colors.pink)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _Text_Add_Nohp.text = value;
                            });
                          },
                        ),
                        //custid
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          maxLines: 2,
                          controller: _Text_Add_Alamat,
                          decoration: InputDecoration(
                            hintText: 'Address',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Colors.pink)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _Text_Add_Alamat.text = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  await Provider.of<MultiDatas>(context,
                                          listen: false)
                                      .Save_Custpos(
                                          context,
                                          _Text_Add_Custid.text,
                                          _Text_Add_Custname.text,
                                          _Text_Add_Nohp.text,
                                          _Text_Add_Nohp.text);
                                  Navigator.pop(context);
                                },
                                child: Text('Save')),
                            SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close'))
                          ],
                        )
                      ],
                    ))));
      },
    );
  }

  getDeletePOS(String idno, String ttl) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete warning',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Delete data ' + ttl + '?'),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        EasyLoading.show(status: 'Processing.');
                        await Provider.of<MultiDatas>(context, listen: false)
                            .Delete_Tranpos_Return(idno);
                        getTotal();
                        Navigator.pop(context);
                      },
                      child: Text('Yes')),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No')),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  getEditPos(String qty, String disc_val, String idno, String item_desc) async {
    setState(() {
      _Text_Qty.text = qty;
      _Text_Disc.text = disc_val;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit : (' + idno + ')' + item_desc,
            style: TextStyle(fontSize: 12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //edit qty
              TextFormField(
                controller: _Text_Qty,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _Text_Qty.text = '';
                          });
                        },
                        icon: Icon(Icons.edit_document)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid, color: Colors.black))),
                // onChanged: (value) {
                //   setState(() {
                //     _Text_Qty.text = value;
                //   });
                //   //  await Provider.of<MultiDatas>(context,listen: false).ListBa//
                // },
                onTap: () => _Text_Qty.selection = TextSelection(
                    baseOffset: 0, extentOffset: _Text_Qty.value.text.length),
              ),

              SizedBox(
                height: 5,
              ),
              //edit discval
              TextFormField(
                controller: _Text_Disc,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _Text_Disc.text = '';
                          });
                        },
                        icon: Icon(Icons.edit_document)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid, color: Colors.black))),
                // onChanged: (value) {
                //   setState(() {
                //     _Text_Disc.text = value;
                //   });
                //   // await Provider.of<MultiDatas>(context,listen: false).ListBarcodePos('POS000000024', 'HO');
                // },
                onTap: () => _Text_Disc.selection = TextSelection(
                    baseOffset: 0, extentOffset: _Text_Disc.value.text.length),
              )
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'Processing..');
                      await Provider.of<MultiDatas>(context, listen: false)
                          .Update_Tranpos_Return(
                              idno, _Text_Qty.text, _Text_Disc.text);
                      //Provider.of<MultiDatas>(context,listen: false).ListBarcodePos(no_pos!, kodecab);
                      getTotal();
                      Navigator.pop(context);
                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new Pos_Tran(),));
                    },
                    icon: Icon(Icons.save)),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ],
            )
          ],
        );
      },
    );
  }

  static String _temp_custname = '';
  static String _temp_custid = '';
  static String _temp_nohp = '';

  getPOS_Tran_Detail(String nopos, String custname) async {
    await Provider.of<MultiDatas>(context, listen: false)
        .get_List_Item_Return_Detail(nopos);

    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              'Return Pick Up.',
              style: TextStyle(fontSize: 12),textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(children: [
                      Text(
                        nopos,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        custname,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ])),
                SizedBox(
                  height: 5,
                ),
                SingleChildScrollView(
                    child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Consumer<MultiDatas>(
                          builder: (context, provx, child) {
                            return ListView.builder(
                              itemCount: provx
                                  .global_get_list_item_return_detail.length,
                              itemBuilder: (context, i) {
                                return Container(
                                    height: 50,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(
                                            style: BorderStyle.solid,
                                            color: Colors.white)),
                                    child: GestureDetector(
                                      child: Row(children: [
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Text(
                                              provx
                                                  .global_get_list_item_return_detail[
                                                      i]
                                                  .item_desc!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              'Qty :' +
                                                  provx
                                                      .global_get_list_item_return_detail[
                                                          i]
                                                      .qty_pos! +
                                                  ' Disc. Val: ' +
                                                  'Qty :' +
                                                  provx
                                                      .global_get_list_item_return_detail[
                                                          i]
                                                      .disc_val!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                            width: 40,
                                            child: IconButton(
                                              onPressed: () async {
                                                 EasyLoading.show(status: 'Processsing');
                                        setState(() {
                                          _Text_Cust.text = nopos;
                                          _temp_nohp=provx.global_get_list_item_return_detail[i].nohp!;
                                        _temp_custname=provx.global_get_list_item_return_detail[i].custname!;
                                       // setMessage2(provx.global_get_list_item_return_detail[i].custname!);
                                        });
                                          
                                          await Provider.of<MultiDatas>(context,listen: false).Save_Tranpos_Return(context, provx.global_get_list_item_return_detail[i].item_code!,provx.global_get_list_item_return_detail[i].item_desc!, nopos, 'HO', 'RET', provx.global_get_list_item_return_detail[i].custid!, provx.global_get_list_item_return_detail[i].custname!, box.read('username'), provx.global_get_list_item_return_detail[i].harga_jual!, provx.global_get_list_item_return_detail[i].harga_beli!,provx.global_get_list_item_return_detail[i].disc_val!,provx.global_get_list_item_return_detail[i].idno!,provx.global_get_list_item_return_detail[i].qty_pos!,no_ret!,_temp_nohp);
                                          await Provider.of<MultiDatas>(context, listen: false).get_List_Item_Return_Detail(nopos);
                                            await Provider.of<MultiDatas>(context, listen: false).get_List_Return_Only(no_ret!);
                                          getTotal();
                                          //Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.add),
                                              color: Colors.white,
                                            ))
                                      ]),
                                      
                                    ));
                              },
                            );
                          },
                        ))),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Close',
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  getPOS_Tran() async {
    setState(() {
      _Text_Cust_Dialog.text='';
    });
    await Provider.of<MultiDatas>(context, listen: false)
        .get_List_Return(_Text_Cust_Dialog.text);

    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('POS. Transaction.',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _Text_Cust_Dialog,
                  decoration: InputDecoration(
                      hintText: 'POS No.',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(style: BorderStyle.solid))),
                  onChanged: (value) async {
                    _Text_Cust_Dialog.text = value;
                    await Provider.of<MultiDatas>(context, listen: false)
                        .get_List_Return(_Text_Cust_Dialog.text);
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                SingleChildScrollView(
                    child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Consumer<MultiDatas>(
                          builder: (context, provx, child) {
                            return ListView.builder(
                              itemCount: provx.global_get_list_return.length,
                              itemBuilder: (context, i) {
                                return Container(
                                    height: 50,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(
                                            style: BorderStyle.solid,
                                            color: Colors.white)),
                                    child: GestureDetector(
                                      child: Row(children: [
                                        Expanded(
                                          child: Text(
                                            provx.global_get_list_return[i]
                                                .notrans_link!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                            width: 30,
                                            child: Icon(
                                              Icons.arrow_right,
                                              color: Colors.white,
                                              size: 30,
                                            )),
                                      ]),
                                      onTap: () {
                                        EasyLoading.show(status: 'Processsing');
                                        getPOS_Tran_Detail(
                                            provx.global_get_list_return[i]
                                                .notrans_link!,
                                            provx.global_get_list_return[i]
                                                .custname!);

                                        // Navigator.pop(context);
                                        // setMessage2(provx
                                        //     .global_list_custname[i].custname!);
                                      },
                                    ));
                              },
                            );
                          },
                        ))),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Close',
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  // final _barcodecode = TextEditingController();
  // int? _jumlah;
  // Future<void> scanBarcodeNormal() async {
  //   String barcodeScanRes;
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         "#ff0000", "Cancel", true, ScanMode.BARCODE);
  //     print(barcodeScanRes);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //   if (!mounted) return;

  //   setState(() {
  //     _barcodecode.text = barcodeScanRes;
  //     _jumlah = 1;
  //   });
  //   setMessage2(barcodeScanRes);
  //   await Provider.of<MultiDatas>(context, listen: false).Save_Tranpos(
  //       context,
  //       barcodeScanRes,
  //       no_pos!,
  //       kodecab,
  //       'OT',
  //       _temp_custid,
  //       _temp_custname,
  //       'irm');
  //   getTotal();
  // }

  final NoRef = DateTime.now();

  String? no_ret;
  final String kodecab = 'HO';

  getNoref() async {
    setState(() {
      int n2 = NoRef.millisecondsSinceEpoch;
      no_ret = 'RET-$n2';
    });

    return no_ret!;
  }

  static String _temp_subtot = '0';
  static String _temp_hitpos = '0';

  getTotal() async {
    // Future.delayed(Duration(seconds: 5));
    await Provider.of<MultiDatas>(context, listen: false)
        .getSumTranPOS_Return(no_ret!, kodecab);
    final provx = Provider.of<MultiDatas>(context, listen: false);
    setState(() {
      _temp_subtot = provx.global_total_transpo_return[0].total!;
      _temp_hitpos = provx.global_total_transpo_return[0].hitpos!;
    });

    // setMessage2(_temp_subtot+'-'+_temp_hitpos);
  }

  @override
  void didChangeDependencies() {
    // getTotal();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _temp_subtot = '0';
    _temp_hitpos = '0';
    _temp_custname = '';
    _temp_custid = '';
    _temp_nohp = '';
   
    getNoref();
    // TODO: implement initState
    super.initState();
     getTotal();
  }

  @override
  Widget build(BuildContext context) {
        final screenSize=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          height: 125,
          color: Colors.blue,
          elevation: 0,
          child: Container(
               width: screenSize.width/1,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.green, Colors.redAccent]),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text(_temp_custname.toString(),style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                  ],
                ),
                 SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Text(
                          'Grand Total (Rp.)',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Text(
                        CurrencyFormat.convertToIdr(int.parse(_temp_subtot), 0),
                      
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                //total Transaction
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Text(
                          'Transaction Total',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Text(
                        CurrencyFormat.convertToIdr(int.parse(_temp_hitpos), 0)
                                .toString() +
                            (int.parse(_temp_hitpos) == 1
                                    ? ' (item)'
                                    : ' (items)')
                                .toString(),
                       
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Return Transaction',
            style: TextStyle(color: Colors.yellow, fontSize: 14,fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            // IconButton(
            //     onPressed: () {
            //       //  final player=AudioPlayer();
            //       //  player.setAsset("assets/sound/error.wav");
            //       // // player.setAsset("assets/sound/bell.mpeg");
            //       //  player.play();
            //       getTotal();
            //     },
            //     icon: Icon(Icons.sort_rounded)),

              
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)),

            IconButton(
                onPressed: () {
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new Pos_Tran(),));
                },
                icon: Icon(Icons.add)),

            IconButton(
                onPressed: () async {
                  //  getTotal();
                  EasyLoading.show(status: 'Processing..');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        InAppWebViewExampleScreen_return(nopos: no_ret!, nohp: _temp_nohp)
                      
                      ));
                  //InAppWebViewExampleScreen
                  //  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Pos_Tran(),));
                  //getCustomer();
                  //  await Provider.of<MultiDatas>(context,listen: false).ListBarcodePos(no_pos!, kodecab);
                },
                icon: Icon(Icons.print))
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Container(
        //     height: 40,
        //     width: 40,
        //     padding: EdgeInsets.all(10),
        //     clipBehavior: Clip.antiAlias,
        //     decoration: BoxDecoration(
        //         border:
        //             Border.all(style: BorderStyle.solid, color: Colors.pink),
        //         borderRadius: BorderRadius.circular(10),
        //         image: DecorationImage(
        //             image: AssetImage('assets/images/barcode2.png'))),
        //   ),
        //   onPressed: () {
        //     if (_temp_custid.length == 0) {
        //       setMessage2('Customer harus diisi fahulu');
        //     } else {
        //     scanBarcodeNormal();
        //     }
        //   },
        // ),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
                 width: screenSize.width/1,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(style: BorderStyle.solid)),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                    child: WCust_Name(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    no_ret!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Header(),
                  const SizedBox(
                    height: 5,
                  ),
                  WDetail()
                ],
              )),
        ),
      ),
    );
  }

  Widget AddDataCustomer() {
    final _Text_Add_Cust = TextEditingController();
    return Container(
        decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.solid, color: Colors.black)),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: _Text_Add_Cust,
              decoration: InputDecoration(hintText: 'POS. NO'),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Save')),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(onPressed: () {}, child: Text('Close'))
              ],
            )
          ],
        ));
  }

  Widget WDetail() {
    return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  style: BorderStyle.solid,
                )),
            child: FutureBuilder(
              future: Provider.of<MultiDatas>(context, listen: false)
                  .get_List_Return_Only(no_ret!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Consumer<MultiDatas>(
                    builder: (context, provx, child) {
                      return ListView.builder(
                        itemCount: provx.global_get_list_return_only.length,
                        itemBuilder: (context, i) {
                          return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(color: Colors.white),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                        Colors.blue,
                                        Colors.green,
                                      ])),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Container(
                                                  child: Text(
                                            provx.global_get_list_return_only[i]
                                                    .item_desc! +
                                                '(' +
                                                provx.global_get_list_return_only[i]
                                                    .item_code! +
                                                ')',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ))),
                                          SizedBox(
                                              width: 50,
                                              child: IconButton(
                                                onPressed: () {
                                                  getEditPos(
                                                      provx
                                                          .global_get_list_return_only[i]
                                                          .qty!,
                                                      provx
                                                          .global_get_list_return_only[i]
                                                          .disc_val!,
                                                      provx
                                                          .global_get_list_return_only[i]
                                                          .idno!,
                                                      provx
                                                          .global_get_list_return_only[i]
                                                          .item_desc!);
                                                },
                                                icon: Icon(Icons.edit_calendar),
                                                iconSize: 30,
                                              )),
                                          SizedBox(
                                              width: 50,
                                              child: IconButton(
                                                onPressed: () {
                                                  getDeletePOS(
                                                      provx
                                                          .global_get_list_return_only[i]
                                                          .idno!,
                                                      provx
                                                          .global_get_list_return_only[i]
                                                          .item_desc!);
                                                  // Navigator.pop(context);
                                                setState(() {
                                                  _temp_custname='Customer Name';
                                                });
                                                },
                                                
                                                
                                                icon: Icon(Icons.delete),
                                                iconSize: 30,
                                              )),
                                        ],
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Text('Sub Detail : '),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            CurrencyFormat.convertToIdr(
                                                int.parse(provx
                                                    .global_get_list_return_only[i]
                                                    .harga_jual!),
                                                0),
                                            
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            CurrencyFormat.convertToIdr(
                                                int.parse(provx
                                                    .global_get_list_return_only[i]
                                                    .qty!),
                                                0),
                                            
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            CurrencyFormat.convertToIdr(
                                                int.parse(provx
                                                    .global_get_list_return_only[i]
                                                    .disc_val!),
                                                0),
                                          
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Text('Sub Total : Rp. ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Text(
                                          CurrencyFormat.convertToIdr(
                                              int.parse(provx
                                                  .global_get_list_return_only[i]
                                                  .subtotal!),
                                              0),
                                           
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Text('     ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ])
                                ],
                              ));
                        },
                      );
                    },
                  );
                }
              },
            )));
  }

  Widget Header() {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.black),
              child: const Text(
                'Product',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black),
              child: const Text('Harga',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black),
              child: const Text('Qty',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black),
              child: const Text('Discount',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
            onTap: () {
              // getCustomer();
            },
          )),
        ],
      ),
    );
  }

  Widget WCust_Name() {
    return Container(
        // decoration: BoxDecoration(
        //   color: Colors.white
        // ),
        padding: const EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _Text_Cust,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          EasyLoading.show(status: 'Processing..');
                          getPOS_Tran();
                        },
                        icon: Icon(Icons.card_giftcard)),
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    hintText: 'POS NO.',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            const BorderSide(style: BorderStyle.solid))),
              ),
            ),
          ],
        ));
  }
}
