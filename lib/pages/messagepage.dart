import 'package:flutter/material.dart';
import 'package:nyoba/pages/appbar.dart';
import 'package:url_launcher_android/url_launcher_android.dart';
import 'package:url_launcher/url_launcher.dart';
class msgpage extends StatelessWidget {

  msgpage ({super.key, required this.penerima, required this.pesan, required this.link});
  String penerima = '';
  String pesan = '';
  String link = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: AppBarr(),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 30, left: 15, right: 15),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Text('Hello- $penerima',
                style: TextStyle(fontFamily: 'Beanie', fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text('There\'s someone sending you a message, they want you to read this message that maybe you\'ll like :)',
                textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Text(pesan,textAlign: TextAlign.justify,
                style: TextStyle(fontFamily: 'Beanie', fontSize: 30),),
              SizedBox(height: 10),
              ElevatedButton(onPressed: (){
                launchUrl(Uri.parse(link));
              },
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.lightGreenAccent,),
                child: Icon(Icons.music_note, color: Colors.black,))
            ],
          ),
        ),
      ),
    );
  }
}
