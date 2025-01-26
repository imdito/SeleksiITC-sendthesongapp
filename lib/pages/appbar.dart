import 'package:flutter/material.dart';

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


