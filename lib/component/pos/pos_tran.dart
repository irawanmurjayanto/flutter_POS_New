import 'package:flutter/material.dart';

class Pos_Tran extends StatefulWidget {
  const Pos_Tran({super.key});

  @override
  State<Pos_Tran> createState() => _Pos_TranState();
}

class _Pos_TranState extends State<Pos_Tran> {
  final NoRef = DateTime.now();
  final _Text_Cust = TextEditingController();
  String? no_pos;

  getNoref() async {
    setState(() {
      int n2 = NoRef.millisecondsSinceEpoch;
      no_pos = 'POS-$n2';
    });

    return no_pos!;
  }

  @override
  void initState() {
    getNoref();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        elevation: 0,
        child: Text(no_pos!),
      ),
      appBar: AppBar(
        title: const Text(
          'Pos Trnasaction',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blue, border: Border.all(style: BorderStyle.solid)),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: WCust_Name(),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                no_pos!,
                style: const TextStyle(color: Colors.white),
              ),
              Header(),
              const SizedBox(height: 5,),
              WCalc()
            ],
          )),
    );
  }

   Widget WCalc() {
    return Container(
      margin: const EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height/1.8,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.none),
        color: Colors.white

      ),
      child: const Center(child: Text('Text'),)
    );
  }

  Widget Header() {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black),
              child: const Text(
                'Product',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black),
              child: const Text('Harga',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black),
              child: const Text('Qty',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black),
              child: const Text('Discount',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }

 

  Widget WCust_Name() {
    return Container(
        // decoration: BoxDecoration(
        //   color: Colors.white
        // ),
        padding: const EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                controller: _Text_Cust,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: const TextStyle(color: Colors.black, fontSize: 12),
                    labelText: 'Customer Name',
                    hintText: 'Customer Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(style: BorderStyle.solid))),
              ),
            ),
          ],
        ));
  }
}
