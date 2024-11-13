import 'dart:io';
//import 'dart:js';
import 'dart:typed_data';
 

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';


//import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:whatsapp_share/whatsapp_share.dart'; 
import 'dart:io';
 

Future screenToPdf(String fileName,Uint8List screenShot,String nophone) async {
  pw.Document pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Expanded(
          child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
        );
      },
    ),
  );
  String path = (await getTemporaryDirectory()).path;
  final pdfFile = await File('$path/$fileName.pdf').create();

   final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(screenShot);



  pdfFile.writeAsBytesSync(await pdf.save());
 
  //await Share.shareXFiles(([XFile(pdfFile.path)]));
  

//EasyLoading.show(status: 'Processing.. ');
 
 //await Future.delayed(const Duration(seconds: 20));
     await WhatsappShare.shareFile(
      phone: nophone,
      filePath: [pdfFile.path],
      package: Package.whatsapp
    );
 EasyLoading.dismiss();
}


//  Future<void> shareFile() async {
//   File? _image;
//     //await getImage();
//     Directory? directory;
//     if (Platform.isAndroid) {
//       directory = await getExternalStorageDirectory();
//     } else {
//       directory = await getApplicationDocumentsDirectory();
//     }
//     debugPrint('${directory?.path} / ${_image?.path}');

//     await WhatsappShare.shareFile(
//       phone: '911234567890',
//       filePath: ["${_image?.path}"],
//     );
//   }



Future screenToPrint(String fileName,Uint8List screenShot) async {
  pw.Document pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Expanded(
          child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
        );
      },
    ),
  );
  String path = (await getTemporaryDirectory()).path;
  final pdfFile = await File('$path/$fileName.pdf').create();


   final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(screenShot);



  pdfFile.writeAsBytesSync(await pdf.save());

   String pathPDF = pdfFile.path;


  // if (pathPDF.isNotEmpty) {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => MyPdfViewer(path: pathPDF),
  //                       ),
  //                     );
  //                   }
//EasyLoading.show(status: 'Processing.. ');
await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
EasyLoading.dismiss();      

// final pdf2 = await rootBundle.load(imagePath.path);
// await Printing.layoutPdf(onLayout: (_) => pdf2.buffer.asUint8List());
  //await Share.shareXFiles(([XFile(imagePath.path)]));
  //await Share.shareXFiles(([XFile(pdfFile.path)]));
  //await Share.share([pdfFile.path]);
}

Future screenToImage(String fileName,Uint8List screenShot,String nophone) async {
  pw.Document pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Expanded(
          child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
        );
      },
    ),
  );
  // String path = (await getTemporaryDirectory()).path;
  // final imagePath = await File('$path/$fileName.png').create();
  //  // pdfFile.writeAsBytesSync(await pdf.save());
  // await imagePath.writeAsBytes(screenShot);

        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/$fileName.png').create();
        await imagePath.writeAsBytes(screenShot);



 
  // EasyLoading.show(status: 'Processing.. ');
  // await Share.shareXFiles(([XFile(imagePath.path)]));
  // EasyLoading.dismiss();
 
    Future.delayed(Duration(seconds: 3));

     await WhatsappShare.shareFile(
      phone: nophone,
      filePath: [imagePath.path],
      package: Package.whatsapp
    );
EasyLoading.dismiss();
}




// class MyPdfViewer extends StatefulWidget {
//   final String base64Pdf;
//   MyPdfViewer({@required this.base64Pdf});
//   @override
//   _MyPdfViewerState createState() => _MyPdfViewerState();
// }
// class _MyPdfViewerState extends State<MyPdfViewer> {
//   PDFViewController pdfViewController;
//   int currentPage = 0;
//   int totalPages = 0;
//   bool isReady = false;
//   String errorMessage = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body: Stack(
//         children: [
//           PDFView(
//             filePath: null,
//             fitEachPage: true,
//             fitPolicy: FitPolicy.BOTH,
//             onRender: (_pages) {
//               setState(() {
//                 totalPages = _pages;
//               });
//             },
//             onError: (error) {
//               setState(() {
//                 errorMessage = error.toString();
//               });
//             },
//             onPageError: (page, error) {
//               setState(() {
//                 errorMessage = '$error';
//               });
//             },
//             onViewCreated: (PDFViewController vc) {
//               setState(() {
//                 pdfViewController = vc;
//               });
//               _loadPdf();
//             },
//           ),
//           errorMessage.isEmpty
//               ? !isReady
//                   ? Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Container()
//               : Center(
//                   child: Text(errorMessage),
//                 ),
//         ],
//       ),
//     );
//   }
//   _loadPdf() async {
//     try {
//       setState(() {
//         isReady = false;
//       });
//       final data = base64Decode(widget.base64Pdf);
//       final directory = await getApplicationDocumentsDirectory();
//       final file = File('${directory.path}/my_file.pdf');
//       await file.writeAsBytes(data);
//       setState(() {
//         isReady = true;
//       });
//       await pdfViewController.loadFile(file.path);
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//       });
//     }
//   }
// }