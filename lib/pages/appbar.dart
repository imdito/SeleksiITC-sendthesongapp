import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AppBarr extends StatelessWidget {
  const AppBarr({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Send The Song !", style: TextStyle(fontFamily: "Beanie", fontSize: 30),),
            Text("Ini test",style: TextStyle(fontFamily: "Beanie"))
          ],
        );
  }
}

class Alertbox extends StatelessWidget {
  Alertbox({super.key, required this.pesanalertbox});

  String pesanalertbox = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Icon(Icons.warning_amber_sharp, size: 90,color: Colors.white,),),
            SizedBox(height: 20,),
            Text(pesanalertbox, style: TextStyle(color: Colors.white,fontSize: 20), textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('Kembali', style: TextStyle(color: Colors.white), ),)
          ],
        ),
      ),
    );
  }
}




