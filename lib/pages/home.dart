import 'package:flutter/material.dart';
import 'package:nyoba/pages/appbar.dart';
import 'package:dio/dio.dart';
import 'package:carousel_slider/carousel_slider.dart';


void main(){
  runApp(Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> Datapesan = [];
  String accessToken = '';


  Future<void> GetData() async{
    try{
      Response Datamsg = await Dio().get(
        'https://seleksiitcpandito-default-rtdb.asia-southeast1.firebasedatabase.app/sendmsg.json',);
      Datapesan = Datamsg.data;
      setState((){});
    }catch(error){
      showDialog(context: context, builder: (context){
        return Alertbox(pesanalertbox: "Maaf Url sedang tidak valid!", ikon: Icons.public_off,);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData();
  }

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
                SizedBox(height: 30,),
                SizedBox(
                  width: 300,
                  height: 200,
                  child: CarouselSlider.builder(
                      itemCount: Datapesan.isEmpty ? 0 : Datapesan.length,
                      itemBuilder: (context, int index, realindex){
                        return Container(
                          width: 250,
                          margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                          padding: EdgeInsets.only(top: 15, left: 20, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: (Datapesan.isEmpty) ? Text('Loading') : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('To- ${Datapesan[index]['penerima']}', style: TextStyle(fontSize: 20),),
                              Text(Datapesan[index]['pesan'], style: TextStyle(fontSize: 35, fontFamily: 'Beanie'),textAlign: TextAlign.left, maxLines: 2, overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(milliseconds: 2000 ),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1,

                      ))
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      );
  }
}