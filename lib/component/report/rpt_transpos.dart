import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pos_new/component/format/number.dart';
import 'package:flutter_pos_new/component/message/getwarning.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/server.dart';
import 'package:flutter_pos_new/component/report/pdfcreate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:flutter_pos_new/slip/slippos.dart';
import 'package:intl/intl.dart';
//import 'package:permission_handler/permission_handler.dart';
 
 
import 'dart:io';

//import 'package:webview_flutter/webview_flutter.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:get_storage/get_storage.dart';


 
 
 
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:print_bluetooth_thermal/post_code.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:image/image.dart' as img;
import 'package:print_bluetooth_thermal/print_bluetooth_thermal_windows.dart';
import 'package:provider/provider.dart';

class InAppWebViewExampleScreen extends StatefulWidget {

final String nopos;
final String nohp;
final String title;

InAppWebViewExampleScreen({Key?key,required this.nopos,required this.nohp,required this.title}):super(key: key);


// Future<void> _convertImageToPDF(screenShot) async {
 
  

// //Create a new PDF document.
// final PdfDocument document = PdfDocument();
// //Read image data.
// final Uint8List imageData = File(screenShot).readAsBytesSync();
// //Load the image using PdfBitmap.
// final PdfBitmap image = PdfBitmap(imageData);
// //Draw the image to the PDF page.
// document.pages
//     .add()
//     .graphics
//     .drawImage(image, const Rect.fromLTWH(0, 0, 500, 200));
// // Save the document.

// File('ImageToPDF.pdf').writeAsBytes(await document.save());
// // Dispose the document.
// document.dispose();


//   }

  @override
  _InAppWebViewExampleScreenState createState() =>
      new _InAppWebViewExampleScreenState(nopos:nopos,nohp:nohp,title:title);
}

class _InAppWebViewExampleScreenState extends State<InAppWebViewExampleScreen> {
//InAppWebViewController webViewController;

  final String? nopos;
  final String? nohp;
  final String title;

  _InAppWebViewExampleScreenState({required this.nopos,required this.nohp,required this.title});

// getprint() async {
  
// final printJobController = await webViewController.printCurrentPage(settings: PrintJobSettings(handledByClient: true));
// } 
    List<int> bytes = [];
    String optionprinttype = "58 mm";
  List<String> options = ["58 mm", "80 mm"];

  NumberFormat cur=NumberFormat.currency();
  
  

  setPrint2()async{
    DateTime today=DateTime.now();

     await Provider.of<MultiDatas>(context,listen: false).printSlip_POS(nopos!);
     final provx=Provider.of<MultiDatas>(context,listen: false);
     int hit=provx.get_globalprint_slip.length;
     final profile = await CapabilityProfile.load();
      final generator = Generator(optionprinttype == "58 mm" ? PaperSize.mm58 : PaperSize.mm80, profile);
       bytes += generator.reset();
       bytes.clear();
      bytes += generator.hr();
      bytes += generator.text(box.read('namatoko'));
      bytes += generator.text(box.read('alamattoko'));
      bytes += generator.text(box.read('nohptoko'));
      bytes += generator.text('POS NO: '+nopos!);
      bytes += generator.hr();
      bytes += generator.hr();
      bytes += generator.row([
        
      PosColumn(text: 'Item', width: 4, styles: PosStyles(bold: true, underline: false,height: PosTextSize.size1,align: PosAlign.left)),
      PosColumn(text: 'Qty', width: 4, styles: PosStyles(bold: true, underline: false,align:PosAlign.center)),
      PosColumn(text: 'Harga', width: 4, styles: PosStyles(bold: true, underline: false,align: PosAlign.right)),
      ]);
      bytes += generator.hr();
      for (int i=0;i<hit;i++)
      {
  
      bytes += generator.row([
      PosColumn(text: provx.get_globalprint_slip[i].item_desc!, width: 4, styles: PosStyles(bold: true, underline: false,height: PosTextSize.size1)),
      PosColumn(text: provx.get_globalprint_slip[i].qty!, width: 4, styles: PosStyles(bold: true, underline: false,align:PosAlign.center)),
      PosColumn(text: CurrencyFormat.convertToIdr(int.parse(provx.get_globalprint_slip[i].harga_jual!), 0).toString(), width: 4, styles: PosStyles(bold: true, underline: false,align: PosAlign.right)),
    ]);
      }
     bytes += generator.hr();

       bytes += generator.row([
      PosColumn(text: 'Subtot(Rp)', width: 4, styles: PosStyles(bold: true, underline: false,height: PosTextSize.size1,align: PosAlign.left)),
      PosColumn(text: box.read('totqty'), width: 4, styles: PosStyles(bold: true, underline: false,align:PosAlign.center)),
      PosColumn(text: CurrencyFormat.convertToIdr(int.parse(box.read('totharga')), 0).toString(), width: 4, styles: PosStyles(bold: true, underline: false,align: PosAlign.right)),
      ]);
     
      //bytes += generator.text('Discount    : '+CurrencyFormat.convertToIdr(int.parse(box.read('totdisc')),0),styles: PosStyles(align: PosAlign.right));
      bytes += generator.row([
      PosColumn(text: 'Disc.(Rp)', width: 4, styles: PosStyles(bold: true, underline: false,height: PosTextSize.size1,align: PosAlign.left)),
      PosColumn(text: '', width: 4, styles: PosStyles(bold: true, underline: false,align:PosAlign.center)),
      PosColumn(text: CurrencyFormat.convertToIdr(int.parse(box.read('totdisc')), 0).toString(), width: 4, styles: PosStyles(bold: true, underline: false,align: PosAlign.right)),
      ]);
      // bytes += generator.hr();
     // bytes += generator.text('Total (Rp.) : '+CurrencyFormat.convertToIdr(int.parse(box.read('totrp')),0),styles: PosStyles(align: PosAlign.right));
     
       bytes += generator.row([
      PosColumn(text: 'Total(Rp) ', width: 4, styles: PosStyles(bold: true, underline: false,height: PosTextSize.size1,align: PosAlign.left)),
      PosColumn(text: '', width: 4, styles: PosStyles(bold: true, underline: false,align:PosAlign.center)),
      PosColumn(text: CurrencyFormat.convertToIdr(int.parse(box.read('totrp')), 0).toString(), width: 4, styles: PosStyles(bold: true, underline: false,align: PosAlign.right)),
    ]);
       bytes += generator.hr();
        bytes += generator.hr();
        bytes += generator.text('Printed : '+DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()));
         bytes += generator.hr();
          bytes += generator.hr();
        bytes += generator.hr();
      // }

      //  bytes += generator.row([
      // PosColumn(text:'yyyyyy' , width: 4),
      //  ]);

  //setMessage2(provx.get_globalprint_slip[1].item_desc!);

   await PrintBluetoothThermal.writeBytes(bytes);
    EasyLoading.dismiss();
    bytes.clear();
  }
   
   setPrint() async{
    await Provider.of<MultiDatas>(context,listen: false).printSlip_POS('POS-1732536751624');

     final profile = await CapabilityProfile.load();
     final generator = Generator(optionprinttype == "58 mm" ? PaperSize.mm58 : PaperSize.mm80, profile);
     bytes += generator.reset();
     

    // final ByteData data = await rootBundle.load('assets/logo/mylogo.jpg');
    // final Uint8List bytesImg = data.buffer.asUint8List();
    // img.Image? image = img.decodeImage(bytesImg); 

   // bytes += generator.image(image!);
      
    bytes += generator.row([
      PosColumn(text: "Header 1", width: 4, styles: PosStyles(bold: true, underline: false)),
      PosColumn(text: "Header 2", width: 4, styles: PosStyles(bold: true, underline: false)),
      PosColumn(text: "Header 3", width: 4, styles: PosStyles(bold: true, underline: false)),
    ]);

final provx=Provider.of<MultiDatas>(context,listen: false);
int hit=provx.get_globalprint_slip.length;
 
 //setMessage2(hit.toString());

 for (int i=0;i<hit;i++)
 {
      bytes += generator.row([
      PosColumn(text: provx.get_globalprint_slip[i].item_desc!, width: 4),
    
    ]);
 }
  // bytes += generator.row([
  //     PosColumn(text: provx.get_globalprint_slip[0].item_desc!, width: 4),
    
  //   ]);

// bytes += generator.hr();
// bytes += generator.hr();

// bytes += generator.row([
//       PosColumn(text: "R1,Cell 1", width: 4),
//       PosColumn(text: "R1,Cell 2", width: 4),
//       PosColumn(text: "R1,Cell 3", width: 4),
//     ]);

// bytes += generator.hr();

// bytes += generator.row([
//       PosColumn(text: "R2,Cell 4", width: 4),
//       PosColumn(text: "R2,Cell 5", width: 4),
//       PosColumn(text: "R2,Cell 6", width: 4),
//     ]);

//bytes += generator.hr();

    await PrintBluetoothThermal.writeBytes(bytes);
    EasyLoading.dismiss();
   }

  InAppWebViewController? webView;
  Uint8List? screenshotBytes;
  final box=GetStorage();

 
  static String _temp_nophone='';
  


  @override
  void initState() {
    EasyLoading.dismiss();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
     
    WillPopScope(onWillPop: ()async => false,
    child: 
    
    Scaffold(
           
        appBar: AppBar(title: Text(title,style: TextStyle(fontSize: 13,)),
        automaticallyImplyLeading: false,
        actions: [

           IconButton(onPressed: ()  {
          
                Navigator.pop(context);
            

          }, icon: Icon(Icons.close,size: 30,)) , 

          IconButton(onPressed: ()  {
                 EasyLoading.show(status: 'Processing..');
                   final  filename=DateTime.now().microsecondsSinceEpoch;  
                screenToPdf("Rpt"+filename.toString(), screenshotBytes!,nohp!);
              //setMessage(nohp!, context);
            

          }, icon: Icon(Icons.picture_as_pdf_sharp,size: 30,)) , 

          IconButton(onPressed: ()  {
                EasyLoading.show(status: 'Processing..');
               final  filename=DateTime.now().microsecondsSinceEpoch;  
               screenToImage("Rpt"+filename.toString(), screenshotBytes!,nohp!);
            

          }, icon: Icon(Icons.image_search,size: 30,)),
          SizedBox(width: 5,),

              IconButton(onPressed: ()  async {
              EasyLoading.show(status: 'Processing..');
              
            setPrint2();
             

          }, icon: Icon(Icons.print,size: 30,)),
          SizedBox(width: 5,)
           
        ], 
        ),
         
        
        body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
          Expanded(
              child: InAppWebView(
     // initialUrlRequest: URLRequest(url: Uri.parse(NamaServer.Server+'posheru/printpos_1.php?nopos='+nopos!,)),
          initialUrlRequest: URLRequest(url: WebUri(NamaServer.Server+'posheru/printpos_1.php?nopos='+nopos!,)),
         // initialUrlRequest: URLRequest(url: WebUri(NamaServer.Server+'posheru/printpos_1.php?nopos=POS-1732536751624',)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                //  debuggingEnabled: true
                supportZoom: true
                 ),
              android: AndroidInAppWebViewOptions(
                textZoom: 400,
                builtInZoomControls: true,
                displayZoomControls: true,
                 

              )   
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
            onPrint: (InAppWebViewController  controller, url) {
              // webView = controller;
            },
            onLoadStart: (InAppWebViewController controller, url) {},
            onLoadStop: (InAppWebViewController controller, url) async {
             screenshotBytes = await controller.takeScreenshot();
             //screenToPdf("irawanxxx", screenshotBytes!);
              // screenToImage("irawanimage", screenshotBytes!);


              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return AlertDialog(
              //       content: Image.memory(screenshotBytes!),
              //     );
              //   },
              // );
            },
          ))
        ]))));
  }
}