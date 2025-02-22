import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_new/component/form/finance.dart';
import 'package:flutter_pos_new/component/form/report.dart';
import 'package:flutter_pos_new/component/master/customer.dart';
import 'package:flutter_pos_new/component/master/item.dart';
import 'package:flutter_pos_new/component/master/profile.dart';
import 'package:flutter_pos_new/component/master/user.dart';
import 'package:flutter_pos_new/component/master/usersub.dart';
import 'package:flutter_pos_new/component/message/getwarning.dart';
import 'package:flutter_pos_new/component/pos/pos_adj.dart';
import 'package:flutter_pos_new/component/pos/pos_gr.dart';
import 'package:flutter_pos_new/component/pos/pos_test.dart';
import 'package:flutter_pos_new/component/pos/pos_tran.dart';
import 'package:flutter_pos_new/component/pos/pos_tran_return.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/report/rpt_stockopname.dart';
import 'package:flutter_pos_new/component/util/printer.dart';
import 'package:flutter_pos_new/component/util/printerweb.dart';
import 'package:flutter_pos_new/main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
//import 'package:carousel_slider/carousel_slider.dart';

class MainMenu extends StatefulWidget {
  final NotchBottomBarController?controller;
  const MainMenu({Key?key,this.controller}):super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState(controller:controller);
}

class _MainMenuState extends State<MainMenu> {
     final NotchBottomBarController?controller;
     _MainMenuState({this.controller});
  
  final box=GetStorage();
  
  @override
  Widget build(BuildContext context) {

    final screenHeight=MediaQuery.of(context).size.height;
    final screenSize=MediaQuery.of(context).size;
    return WillPopScope(onWillPop: () async=>false
    ,
    child: 
    
    
     Scaffold(
      
       appBar:  
           AppBar(title: const Text('Main Menu'),
           
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
       toolbarHeight: screenHeight*0.1,
       flexibleSpace: Stack(
       children: [
        
            Image.asset("assets/images/appbar.png",
            fit: BoxFit.fill,
            //height: screenHeight*0.1,
            height: screenHeight * 0.3,
            ),
       ],
       ),
      automaticallyImplyLeading: false,
      ),
      
    //  floatingActionButton: FloatingActionButton(
    //   child: const Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Text('Log OUT',style: TextStyle(fontSize: 12),)
    //     ],
    //   ),
    //   onPressed: () {
    //    Navigator.push(context, MaterialPageRoute(builder: (context) => const MainApp()));
    //  },
     
    //  ),


      
      body: 
      Container(
        
           height: MediaQuery.of(context).size.height,
    
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/back2.png'),fit: BoxFit.cover)
        ),
        child: 
      
      SingleChildScrollView(
        child: Container(
       
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Container(
                margin: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)  
                    
                  ),
                  border: Border.all(style: BorderStyle.solid,width: 1,color: Colors.grey)
                ),
                child: Row(
                  
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                   Expanded(child: Text('User Name: '+box.read('username')+' / '+box.read('hak'),style: const TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold),)),
                   
                    
                     
                    IconButton(onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainApp(),));
                    }, icon: Icon(Icons.logout,color: Colors.blueGrey,size: 30,))
                    
                  ],
                )
              ),

              //Menu Placement
              
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //menu master
                      Text_Title('Master Menu'),
                       const SizedBox(height: 10,), 
                      Row(
                        children: [      
                            GestureDetector(
                              child: 
                            Menu_Detail('shopprofile.gif', 'Shop Profile'),
                            onTap: () {
                              if (box.read('hak')=='Administrator')
                              {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));
                              }else
                              {
                                setMessageAll(context,'Hak', 'Maaf,Anda tidak berhak atas module ini');
                              }
                            },
                            ),

                               const SizedBox(width: 8,),
                            GestureDetector(  
                            child: 
                            Menu_Detail('menucust.jpg', 'Customer'),
                            onTap: () {
                               if (box.read('hak')=='Administrator')
                              {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Customer_Master(),));
                              }else{
                                setMessageAll(context,'Hak', 'Maaf,Anda tidak berhak atas module ini');
                              }
                            },
                             ),
                            const SizedBox(width: 8,),
                            GestureDetector(  
                            child: 
                            Menu_Detail('menu11.gif', 'Product'),
                             onTap: () {
                                if (box.read('hak')=='Administrator')
                              {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Item_Master(),));
                              }else
                              {
                                     setMessageAll(context,'Hak', 'Maaf,Anda tidak berhak atas module ini');
                              }
                            },
                            ),
                            const SizedBox(width: 8,),
                            GestureDetector(  
                            child: 
                            Menu_Detail('menuuser.jpg', 'User'),
                             onTap: () {
                                if (box.read('hak')=='Administrator')
                              {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => MainUser(),));
                              }else
                              {
                                     setMessageAll(context,'Hak', 'Maaf,Anda tidak berhak atas module ini');
                              }
                            },
                            )
                            
                        ],
                      ),

                       //menu master
                       const SizedBox(height: 15,), 
                       Text_Title('Transaction'),
                       const SizedBox(height: 10,), 
                      Row(
                        children: [      
                            GestureDetector(child: 
                            Menu_Detail('menupos.gif', 'POS'),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:  (context) => const Pos_Tran(),));
                            },
                            ),
       const SizedBox(width: 8,),
                            GestureDetector(child: 
                             
                            Menu_Detail('menutransfer.gif', 'Return'),
                             onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder:  (context) => const Pos_Tran_Return(),));
                            },
                            ),


                            const SizedBox(width: 8,),
                            GestureDetector(
                              child: 
                            Menu_Detail('menugr.gif', 'Good Receive'),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Pos_GR(),));
                            },
                            ),
                            
                             const SizedBox(width: 8,),
                            GestureDetector(
                              child:  
                            Menu_Detail('menustockname.gif', 'Stock Opname'),
                              onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => InAppWebViewExampleScreen_StockOpnm(kodecab: 'HO', u_name: box.read('username'), title: 'Stock Opname'),));
                            },
                            ),
                            
                                const SizedBox(width: 8,),
                             GestureDetector(
                              child:     
                            Menu_Detail('menuadjust.gif', 'Ajustment'),
                             onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Pos_ADJ()),);
                            },
                            ),
                        ],
                      ),
                      

                      //menu master
                       const SizedBox(height: 15,), 
                       Text_Title('Utillty'),
                       const SizedBox(height: 10,), 
                      Row(
                        children: [      
                            GestureDetector(child: 
                            Menu_Detail('menuprint.jpg', 'Bluetooth'),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:  (context) => PrinterBth()));
                            },
                            ),

                                const SizedBox(width: 8,),
         GestureDetector(child: 
                            Menu_Detail('clear.jpg', 'Clear Trans'),
                            onTap: () {
                             showDialog(context: context, builder: (context) {
                               return AlertDialog(
                                title: Text('Clear Transaction'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Delete All transaction ?'),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(onPressed: () {
                                    
                                    Provider.of<MultiDatas>(context,listen: false).deleteTrans();
                                    Navigator.pop(context);
                                    setMessage("Delete Completed", context);
                                  }, child: Text('Yes')),
                                  SizedBox(width: 8,),
                                  ElevatedButton(onPressed: () {
                                     Navigator.pop(context);
                                  }, child: Text('Cancel')),
                                ],
                               );
                             },);
                             // Navigator.push(context, MaterialPageRoute(builder:  (context) => PrinterWeb()));
                            },
                            ),

                            //    GestureDetector(child: 
                            // Menu_Detail('menuprint.jpg', 'Printer Web'),
                            // onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder:  (context) => PrinterBth()));
                            // },
                            // ),
        
        
                        ],
                      )

                  ],
                ),
              )
            ],
          ),
        )
      ),
    )
     )
    );
  }

 Widget Text_Title(String ttl) {
 return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(7)
      ),

      child: Text(
        ttl,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 12),
      ),
    );
  }

  Widget Menu_Detail(String pict,String ttl){
    return Container(
   child: Column(
 
    children: [
        Container(
          height: 50,
          width: 50,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
             image: DecorationImage(image: AssetImage('assets/images/$pict'),fit: BoxFit.fill),
             borderRadius: BorderRadius.circular(20),
             border: Border.all(style: BorderStyle.solid,color: Colors.grey)
          ),
         // child: Image.asset('assets/images/menu11.gif'),
        ),
        const SizedBox(height: 5,),  
        Text(ttl,style: const TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
    ],
   ),
    );
  }
}