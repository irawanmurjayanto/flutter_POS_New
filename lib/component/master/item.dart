import 'package:flutter/material.dart';
import 'package:flutter_pos_new/component/provider/datamulti.dart';
import 'package:flutter_pos_new/component/warning.dart';
import 'package:provider/provider.dart';

class Item_Master extends StatefulWidget {
  const Item_Master({super.key});

  @override
  State<Item_Master> createState() => _Item_MasterState();
}

class _Item_MasterState extends State<Item_Master> {
  
  Future <void> getRefeshData() async{
    await Provider.of<MultiDatas>(context,listen: false).get_save_List_Porduct(_Text_Cari_Cust.text);    
  }

  final _Text_Cari_Cust=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product'),
      
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      ),
      body: Container(
      
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          //gradient: LinearGradient(colors: [Colors.blue,Colors.red])
          image: DecorationImage(image: AssetImage('assets/images/back2.png'),
          fit: BoxFit.cover
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
              
                    border: OutlineInputBorder(
                      
                      borderSide: BorderSide(style: BorderStyle.solid)
                    ),
                    hintText: 'Product Search'
                  ),
                  controller: _Text_Cari_Cust,
                  onChanged: (value) async{
                      await Provider.of<MultiDatas>(context,listen: false).get_save_List_Porduct(value);    
                  },
              ),
              SizedBox(height: 10,),
              Container(
                   height: MediaQuery.of(context).size.height/1.35,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child:  RefreshIndicator(
                  onRefresh: getRefeshData,
                child: FutureBuilder(future: getRefeshData(),
                 builder: (context, snapshot) {
                   if (snapshot.connectionState==ConnectionState.waiting)
                   {
                    return Center(child: CircularProgressIndicator(),);
                   }else{
                    return Consumer<MultiDatas>(builder: (context, provx, child) {
                      return ListView.builder(
                        itemCount: provx.global_get_list_product.length,
                        itemBuilder: (context, i) {

                        return Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            
                            border: Border.all(style: BorderStyle.solid,color: Colors.red),
                             gradient: LinearGradient(colors: [Colors.blue,Colors.yellow]) 
                          ),
                            child:
                            GestureDetector(child: 
                            
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                               Expanded(child: Text(provx.global_get_list_product[i].nama!,style: TextStyle(color: Colors.black),maxLines: 1,),),
                               SizedBox(
                                  width: 50,
                                child: 
                                  
                                    Icon(Icons.arrow_right),
                               )
                              ],
                            ),
                            onTap: () {
                              setMessage2('msg');
                            },
                            )
                        );

                      },);
                    },);
                   }
                 },
                 
                 ))
              )
            ],
          ),
        ),
      ),
    );
  }
}