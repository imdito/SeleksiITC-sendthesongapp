import 'package:flutter/material.dart';
import 'package:nyoba/pages/appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';

class msgpage extends StatefulWidget {

  msgpage ({super.key, required this.penerima, required this.pesan, required this.link});
  String penerima = '';
  String pesan = '';
  String link = '';

  @override
  State<msgpage> createState() => _msgpageState(idsong: link);
}

class _msgpageState extends State<msgpage> {

  _msgpageState({required this.idsong});

  String idsong = '';
  String? accessToken;
  String judullagu = '';
  String gambar = '';
  String artist = '';

  Future<void>getsong(int index) async{
    Dio dio = Dio();
    try{
      Response token = await Dio().get(
        'https://seleksiitcpandito-default-rtdb.asia-southeast1.firebasedatabase.app/sendtoken.json',);
      accessToken = token.data[0]['access_token'];

      Response get = await dio.get('https://api.spotify.com/v1/tracks/$idsong', options:
      Options(headers: {'Authorization' : 'Bearer $accessToken'}));
      print(get);
      judullagu = get.data['name'];
      artist = get.data['album']['artists'][0]['name'];
      gambar = get.data['album']['images'][0]['url'];
      setState(() {});
    }catch(e){

      Response post = await Dio().post('https://accounts.spotify.com/api/token',
          data: {
            'grant_type': 'client_credentials',
            'client_id': '055aed8441274633b3ca73d01a2123c0',
            'client_secret': '82c8fcd919ac4138b7b863abe1cfa4cd',
          },
          options: Options(contentType: Headers.formUrlEncodedContentType)
      );

      await Dio().patch('https://seleksiitcpandito-default-rtdb.asia-southeast1.firebasedatabase.app/sendtoken/0.json',
          data: {
            'access_token' : post.data['access_token']
          });
      //print(post);
      if(index == 0){
        Alertbox(pesanalertbox: 'error');
      }else{
        return getsong(index--);
      }

    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsong(3);
  }

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
          child: Center(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Text('Hello- ${widget.penerima}',
                  style: TextStyle(fontFamily: 'Beanie', fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15,),
                Text('There\'s someone sending you a message, they want you to read this message that maybe you\'ll like :)',
                  textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                Text(widget.pesan,textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Beanie', fontSize: 30),

                ),
                SizedBox(height: 10),
                // ElevatedButton(onPressed: (){
                //   launchUrl(Uri.parse(widget.link));
                // },
                //   style: ElevatedButton.styleFrom(
                //       shape: CircleBorder(),
                //       padding: EdgeInsets.all(20),
                //       backgroundColor: Colors.lightGreenAccent,),
                //   child: Icon(Icons.music_note, color: Colors.black,)),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.green ,
                      borderRadius: BorderRadius.circular(8)
                  ),

                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Image(image: NetworkImage(gambar.isEmpty ? 'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png' : gambar), width: 150,),
                      SizedBox(width: 20,),
                      Text(judullagu, style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Beanie',
                            fontWeight: FontWeight.bold
                      ),),
                      Text(artist, style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                      ),),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: InkWell(
                          onTap: (){
                            launchUrl(Uri.parse('https://open.spotify.com/track/'+widget.link));
                            },
                          child: Image.asset('assets/images/spotipay.png'),),
                        ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),

                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
