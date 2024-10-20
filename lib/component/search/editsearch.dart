import 'package:flutter/material.dart';

void EditSearchxx(TextEditingController CariKata){

  Container(
    child: Column(
      children: [
        Form(child:TextFormField(
          controller: CariKata,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(width:2,color: Colors.black ))  
          ),
          validator: (value) {
            
          },
        )
        )
      ],
    ),
  );
}