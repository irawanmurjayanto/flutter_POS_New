// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_pos_new/component/report/pdfcreate.dart';
// import 'package:flutter_pos_new/component/server.dart';
// import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
// import 'package:webview_flutter_web/webview_flutter_web.dart';

// // void main() {
// //   WebViewPlatform.instance = WebWebViewPlatform();
// //   runApp(const MaterialApp(home: _WebViewExample()));
// // }

// class WebViewExample extends StatefulWidget {
//   const WebViewExample({Key?key}):super(key: key);

//   @override
//   _WebViewExampleState createState() => _WebViewExampleState();
// }

// class _WebViewExampleState extends State<WebViewExample> {
//   final PlatformWebViewController _controller = PlatformWebViewController(
//     const PlatformWebViewControllerCreationParams(),
//   )..loadRequest(
//       LoadRequestParams(
//         uri: Uri.parse(NamaServer.Server+'posheru/printpos_1.php?nopos=POS-1732243487182'),
//       ),
//     );
// Uint8List? screenshotBytes;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter WebView example'),
//         actions: <Widget>[
//           _SampleMenu(_controller),
//           IconButton(onPressed: () {
//              final  filename=DateTime.now().microsecondsSinceEpoch;                
//                screenToImage("Rpt"+filename.toString(), screenshotBytes!,'6285229092535');
//           }, icon: Icon(Icons.print))
//         ],
//       ),
//       body: PlatformWebViewWidget(
//         PlatformWebViewWidgetCreationParams(controller: _controller),
//       ).build(context),
//     );
//   }
// }

// enum _MenuOptions {
//   doPostRequest,
// }

// class _SampleMenu extends StatelessWidget {
//   const _SampleMenu(this.controller);

//   final PlatformWebViewController controller;

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<_MenuOptions>(
//       onSelected: (_MenuOptions value) {
//         switch (value) {
//           case _MenuOptions.doPostRequest:
//             _onDoPostRequest(controller);
//         }
//       },
//       itemBuilder: (BuildContext context) => <PopupMenuItem<_MenuOptions>>[
//         const PopupMenuItem<_MenuOptions>(
//           value: _MenuOptions.doPostRequest,
//           child: Text('Post Request'),
//         ),
//       ],
//     );
//   }

//   Future<void> _onDoPostRequest(PlatformWebViewController controller) async {
//     final LoadRequestParams params = LoadRequestParams(
//       uri: Uri.parse('https://httpbin.org/post'),
//       method: LoadRequestMethod.post,
//       headers: const <String, String>{
//         'foo': 'bar',
//         'Content-Type': 'text/plain'
//       },
//       body: Uint8List.fromList('Test Body'.codeUnits),
//     );
//     await controller.loadRequest(params);
//   }
// }