import 'package:flutter/material.dart';
import 'package:flutter_pos_new/component/master/usersub.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:provider/provider.dart';

class MainUser extends StatefulWidget {
  const MainUser({super.key});

  @override
  State<MainUser> createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {

  getRefreshUser()async{
  await Provider.of<MultiDatas>(context,listen: false).get_List_UserPass(context,_Text_Cari.text,'','','View');
  }
  final _Text_Cari=TextEditingController();

  @override
  void initState() {
   // getRefreshUser();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text('Main User'),
    actions: [
       IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Master_User_sub(user: '', pass: '', hak: 'User', tipe: 'New'),));
        }, icon: Icon(Icons.add))
    ],
    ),
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image:
         
         AssetImage('assets/images/back2.png'))
      ),
      
      child: 
  
    
     SingleChildScrollView(
      child: Column(
        children: [
           Container(
            margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
            child: 
          TextFormField(
            autofocus: true,
            controller: _Text_Cari,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.solid)
              ),
              hintText: 'user Name Search',
              filled: true,
              fillColor: Colors.white
            ),
            onChanged: (value) async {
                await Provider.of<MultiDatas>(context,listen: false).get_List_UserPass(context,value,'','','View');
            },
          ),
           ),
          SizedBox(height: 5,),
          Container(
            height: MediaQuery.of(context).size.height,
                 margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
            child: 
          FutureBuilder(future: getRefreshUser(), builder: 
          (context, snapshot) {
            if (snapshot.connectionState==ConnectionState.waiting)
            {
              return (Center(child: CircularProgressIndicator(),));
            }else
            {
              return Consumer<MultiDatas>(builder: (context, provx, child) {
                return ListView.builder(
                  itemCount: provx.global_get_userpass.length,
                  itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 7),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.black
                    ),
                    child:
                     GestureDetector(
                      child: 
                     Row(
                      children: [
                      Expanded(child: 
                      Text(provx.global_get_userpass[i].user!,style: TextStyle(color: Colors.white,fontSize: 16),),                      
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.arrow_right,size: 30,color: Colors.white,)

                      ]
                     ),
                     onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Master_User_sub(user: provx.global_get_userpass[i].user!, pass: provx.global_get_userpass[i].password!, hak: provx.global_get_userpass[i].hak!, tipe: 'Edit'),));
                      //setMessage2(provx.global_get_userpass[i].user!+'-'+provx.global_get_userpass[i].pass!+'-'+provx.global_get_userpass[i].hak!);
                     // setMessage2(provx.global_get_userpass[i].user!+'-'+provx.global_get_userpass[i].password!);
                     },
                     )
                  );
                },);
              },);
            }
          },)
          ) 
             
          
        ],
      ),
    ),
    )
    );
   
  }
}