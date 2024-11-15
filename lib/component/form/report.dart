import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Report1 extends StatefulWidget {
  const Report1({super.key});

  @override
  State<Report1> createState() => _Report1State();
}
   final _Text_Beg_Date=TextEditingController();
   final _Text_End_Date=TextEditingController();

class _Report1State extends State<Report1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Report Menu'),),
        body: Container(
          child: 
          Row(
            children: [
              Expanded(child:
              pickBegDate(_Text_Beg_Date.text)
              ),
              SizedBox(width: 10,child: Text(' To ')),
              Expanded(child: 
              pickBegDate(_Text_End_Date.text)
              ),
            ],
          )
        ),

    );
  }
 
 Widget pickBegDate(String title){
  return Container(
      child: 
      
      TextField(
        controller: _Text_Beg_Date,
        decoration: InputDecoration(
          hintText:  title,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid))
        ),
        onTap: () async {
          DateTime?pickdate=await showDatePicker(context: context,
           firstDate: DateTime(2010), 
           lastDate: DateTime(2040),
           initialDate: DateTime.now(),
   
           );
            if (pickdate!=null)
            {
              final String formatdate=DateFormat('dd-MM-yyyy').format(pickdate);
              setState(() {
                title=formatdate;
              });
            }
        },
      ),

  );
 }
}