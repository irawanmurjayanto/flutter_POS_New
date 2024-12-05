import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
 
import 'package:flutter_pos_new/component/orientation.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/warning.dart';
 
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    
   
   MultiProvider(providers: [
    ChangeNotifierProvider.value(value: MultiDatas())
   ],
   child:  const MainApp(),
   
   )
   

  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: const Scaffold(
        body:  HomePage(),
         
      ),
      builder: EasyLoading.init()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _text_User=TextEditingController();
  final _text_Pass=TextEditingController();
  bool passWordVisible=false;

    getSession() async{
    await GetStorage.init();
   // box.erase();
   
   } 

 

  @override
  void initState() {
    EasyLoading.show(status: 'Processing');
    getSession();
    passWordVisible=true;
    getPortraitCentral();
    // TODO: implement initState
    super.initState();
     EasyLoading.dismiss();
  }

  

  @override
  Widget build(BuildContext context) {
  
  final screenSize=MediaQuery.of(context).size;
  

    return Center(

    child: 
    SingleChildScrollView(child: 

    Container(
     
      decoration: const BoxDecoration(
        color: Colors.white
       // image: DecorationImage(image: AssetImage('assets/images/back5b.jpg'),fit: BoxFit.cover)
       // border: Border.all(style: BorderStyle.solid,color: Colors.black)
      ),
      child:
      
      
       Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

           Container(
            padding: const EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
             height: 120,
             width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
               borderRadius: BorderRadius.circular(15)

            ),
            child: Image.asset('assets/images/pogo2.png',fit: BoxFit.fill,),
           ), 
           const SizedBox(height: 40,), 

        
           Container(
              width:screenSize.width>=1000?screenSize.width/3: screenSize.width/1.2,

            padding: const EdgeInsets.only(top: 40,left: 20,right: 20,bottom: 40),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.solid,color: Colors.black),
       image: const DecorationImage(image: AssetImage('assets/images/back5a.jpg'),fit: BoxFit.cover),
         borderRadius: BorderRadius.circular(20),
         boxShadow: const [
          BoxShadow(blurRadius: 2,offset:Offset(1, 1),color: Colors.blue
          ),
          
          BoxShadow(blurRadius: 1,offset:Offset(3, 3),color: Colors.blue
          ),
         ],
         color: Colors.white
            ),
            child: Column(
              children: [
            
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white
              ),
              child: 
              SizedBox(
                height: 45,
              child:     
              textField(_text_User, 'User'),
              )
            ),
             const SizedBox(height: 15,),
             //password
               SizedBox(
                height: 45,
              child: 
            Container(
       decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white
              ),
      child: TextFormField(
 
      //  keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
           
          labelStyle: const TextStyle(fontSize: 12),
          suffixIcon: IconButton(onPressed: () {
            setState(() {
              passWordVisible=!passWordVisible;
            });
          }, icon: Icon(passWordVisible?Icons.visibility_off:Icons.visibility)),
          hintText: 'Password',
          labelText: 'Password',
          border: OutlineInputBorder(
            borderSide: const BorderSide(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(15)
            
          )
        ),
        obscureText: passWordVisible,
        controller: _text_Pass,
        
        onChanged: (value) {
          _text_Pass.text=value;
        },
      ),
            )
        
    ),
    const SizedBox(height: 15,),
    // IconButton(onPressed: () {
    //   setMessage2(screenSize.toString());
    // }, icon: Icon(Icons.abc)),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        
        backgroundColor: Colors.green,
        foregroundColor: Colors.white
      ),
      onPressed: () async{
        getStatusInet(context);
        EasyLoading.show(status: 'Processing');
        await Provider.of<MultiDatas>(context,listen: false).getUserPass(_text_User.text, _text_Pass.text,context);
        
    }, child: 
    const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.save),
        Text('Submit')
      ],
    )
    )
,


              ], 
            ),
           )
         
,

const Text('POS Versi 2.7e3',style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 50,) ,
          
           Container(
            padding: const EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
             height: 50,
             width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
               borderRadius: BorderRadius.circular(15)

            ),
            child: Image.asset('assets/images/poslogo3.png',fit: BoxFit.fill,),
           ),
          ],

        ),
      ),
      )
    )
    );
  }

  Widget textField(TextEditingController txt,String ttl){
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 12),
          hintText: ttl,
          labelText: ttl,
          border: OutlineInputBorder(
            borderSide: const BorderSide(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(15)
            
          )
        ),
        controller: txt,
        onChanged: (value) {
          txt.text=value;
        },
      ),
    );
  }
}

