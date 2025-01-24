import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/slider/bottomdock.dart';
import 'package:flutter_pos_new/component/slider/expandtext.dart';
import 'package:flutter_pos_new/component/slider/slideronboard.dart';
import 'package:flutter_pos_new/component/slider/slideup.dart';
import 'package:flutter_pos_new/component/slider/testSlider1.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


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
      final screenSize=MediaQuery.of(context).size;
    return  Scaffold(
        appBar: AppBar(title: Text('Profile Shop'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // IconButton(onPressed: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => TestSlide1(),));
          // }, icon: Icon(Icons.slideshow)),
          // IconButton(onPressed: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => SlideOnboard(),));
          // }, icon: Icon(Icons.slow_motion_video)),

          //   IconButton(onPressed: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => SlidingUpPanelExample(),));
          // }, icon: Icon(Icons.abc)),
          //   IconButton(onPressed: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => ExpText(),));
          // }, icon: Icon(Icons.expand)),
          //     IconButton(onPressed: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => BottomDock(),));
          // }, icon: Icon(Icons.dock)),
        ],
        ),
        body: Container(
            width: screenSize.width/1,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.lightBlue,Colors.amberAccent])
          ),
          child:   Column(
                  mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
 
              children: [
             //   Text('idno : '+_temp_idno==null?'-':_temp_idno!),
                SizedBox(height: 5,),
                Wcaption('Nama'),
                TextField(
                  
                  controller: _Text_Nama,
                  decoration: InputDecoration(
                     suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Nama.text='';
                      });
                    }, icon: Icon(Icons.close)),
                    // labelText: 'Nama',
                    //    labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
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
                 Wcaption('No. HP'),
                TextField(
                   
                  controller: _Text_Nohp,
                  decoration: InputDecoration(
                     suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Nohp.text='';
                      });
                    }, icon: Icon(Icons.close)),
                      //                 labelText: 'No. HP',
                      //  labelStyle: TextStyle(fontSize: 25,backgroundColor: Colors.black,color: Colors.white, letterSpacing: 5,),
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
                 Wcaption('Alamat'),
                TextField(
                   
                  controller: _Text_Alamat,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _Text_Alamat.text='';
                      });
                    }, icon: Icon(Icons.close)),
                      //                 labelText: 'Alamat',
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