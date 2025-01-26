import 'package:flutter/material.dart';
import 'package:nyoba/pages/appbar.dart';

void main(){
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            title: AppBarr()),
        body: Center(
          child: Container(
            height: double.infinity,
            width: 300,
            alignment: Alignment.centerRight,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  children: [
                    SizedBox(height: 30,),
                    Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: const Text("a bunch of the untold words, sent through the song",textAlign: TextAlign.center, style: TextStyle(fontFamily: "Beanie", fontSize: 30))
                    ),
                    SizedBox(height: 10,),
                    Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: const Text("Express your untold message through the song.",textAlign: TextAlign.center, style: TextStyle(fontSize: 17, color: Colors.grey),)),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 315,
                      child: OutlinedButton(onPressed: (){
                        Navigator.pushNamed(context, '/sendpage');
                      },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        child: const Text("Tell your story", style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 310,
                      child: OutlinedButton(onPressed: (){
                        Navigator.pushNamed(context, '/browsepage');
                      },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        child: const Text("Browse The Stories", style: TextStyle(color: Colors.black),),
                      ),
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(children: [
                    Align(alignment: Alignment.centerLeft,
                    child: const Text("Share your Message",style: TextStyle(fontFamily: "Beanie", fontSize: 25),),
                    ),
                    const Text("Choose a song and write a heartfelt message to someone special."),
                    OutlinedButton(onPressed: (){
                      Navigator.pushNamed(context, '/sendpage');
                    },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                      child: const Text("Create Message", style: TextStyle(color: Colors.white),),
                    ),
                  ],),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 25),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text("Browse Message", style: TextStyle(fontFamily: "Beanie", fontSize: 25),),
                    ),
                    const Text("Find message that were written for you. Search by your name to discover heartfelt dedications."),
                    OutlinedButton(onPressed: (){
                      Navigator.pushNamed(context, '/browsepage');
                    },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                      child: const Text("Browse Message", style: TextStyle(color: Colors.black),),
                    ),
                  ],),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 25),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: const Text("Detail Message", style: TextStyle(fontFamily: "Beanie", fontSize: 25),),
                    ),
                    const Text("You can click on any message card to read the full story and listen to the chosen song!"),

                  ],),
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      );
  }
}