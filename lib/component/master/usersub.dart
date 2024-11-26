import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pos_new/component/master/user.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:provider/provider.dart';

class Master_User_sub extends StatefulWidget {
  final String user;
  final String pass;
  final String hak;
  final String tipe;
  Master_User_sub({Key?key,required this.user,required this.pass,required this.hak,required this.tipe}):super(key: key);

  @override
  State<Master_User_sub> createState() => _Master_User_subState(user:user,pass:pass,hak:hak,tipe: tipe);
}

class _Master_User_subState extends State<Master_User_sub> {
  final String user;
  final String pass;
  final String hak;
  final String tipe;

  _Master_User_subState({required this.user,required this.pass,required this.hak,required this.tipe});

  List<String> menus=['Menu 1','Menu 2','Menu 3'];
  List<String> haks=['User','Administrator'];
  String?_temp_hak;
  final _Text_UserName=TextEditingController();
  final _Text_Pass=TextEditingController();
  bool _visible_off=false;


  getDataUser() async{
    setState(() {
      _Text_UserName.text=user;
    _Text_Pass.text=pass;
    _temp_hak=hak;

    });
    
  }

  @override
  void initState() {
    getDataUser();
    _visible_off=true;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Master User '+tipe),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      actions: [
       IconButton(onPressed: () {
         showDialog(context: context, builder: (context) {
           return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Delete this data  ?'),
              SizedBox(height: 10,),
              

            ],),
            actions: [
              ElevatedButton(onPressed: () {
                Provider.of<MultiDatas>(context,listen: false).get_List_UserPass(context,_Text_UserName.text,_Text_Pass.text,_temp_hak!, 'Delete');
                Navigator.pop(context);
                Navigator.pop(context);
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new MainUser(),));
              }, child: Text('Yes')),
               ElevatedButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text('No'))
            ],
           );
         },);
       }, icon:Icon(Icons.delete))
      ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back1.png'),
            fit: BoxFit.cover
            )
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: 
            TextFormField(
              controller: _Text_UserName,
              
              decoration: InputDecoration(
                hintText: 'User Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.solid)
                ),
                filled: true,
                fillColor:Colors.white,
                labelStyle: TextStyle(color: Colors.white)
              ),
            ),
            ),

            Container(
              margin: EdgeInsets.all(5),
              child: TextFormField(
                obscureText: _visible_off,
                decoration: InputDecoration(
                      filled: true,
                fillColor: Colors.white,
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.solid)
                  ),
                  suffixIcon: IconButton(onPressed: () {
                    setState(() {
                      _visible_off=!_visible_off;
                    });
                  }, icon: Icon(_visible_off?Icons.visibility_off:Icons.visibility))
                ),
                controller: _Text_Pass,
              ),
            ),
            Container(
              
              margin: EdgeInsets.all(5),
              child: 
          
            DropdownButtonFormField(
              hint: Text(tipe=='Edit'?hak:'User Right'),
              
               decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid)),
              
               ),
              borderRadius: BorderRadius.circular(5),
              items: haks.map((a)
              {
                return DropdownMenuItem(
                  value: a,
                  child: Text(a));
              }
              ).toList(),
            
             onChanged: (value) {
            //  setMessage2(value!);
               setState(() {
                 _temp_hak=value;
               });
             },)
            ),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {
                  EasyLoading.show(status: 'Processing');
                  if (tipe=='Edit')
                  {
                   // setMessage2(_temp_hak!);
                    Provider.of<MultiDatas>(context,listen: false).get_List_UserPass(context,_Text_UserName.text,_Text_Pass.text,_temp_hak!, 'Edit');
                   // Navigator.pop(context);
                  }

                   if (tipe=='New')
                  {
                   // setMessage2(_temp_hak!);
                    Provider.of<MultiDatas>(context,listen: false).get_List_UserPass(context,_Text_UserName.text,_Text_Pass.text,_temp_hak!, 'New');
                  //  Navigator.pop(context);
                  }
                }, child: Text('Save')),
                SizedBox(width: 5,),
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text('Close')),
              ],
            )
              

          ],
        ),
      ),
      
    );
  }
}