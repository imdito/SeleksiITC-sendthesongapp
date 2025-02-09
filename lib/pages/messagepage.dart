import 'package:flutter/material.dart';
import 'package:nyoba/pages/appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';


class msgpage extends StatefulWidget {

  const msgpage ({super.key, required this.penerima, required this.pesan, required this.link});
  final String penerima;
  final String pesan;
  final String link;

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
      judullagu = get.data['name'];
      artist = get.data['album']['artists'][0]['name'];
      gambar = get.data['album']['images'][0]['url'];
      setState(() {});
      return ;
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
        Alertbox(pesanalertbox: 'error', ikon: Icons.error,);
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
          margin: EdgeInsets.only( left: 15, right: 15, ),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Center(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: 30,),
                Text('Hello- ${widget.penerima}',
                  style: TextStyle(fontFamily: 'Beanie', fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                      color: Colors.green ,
                      borderRadius: BorderRadius.circular(8)
                  ),

                  child: Column(
                    children: [

                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image(image: NetworkImage(gambar.isEmpty ? 'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png' : gambar), width: 200,)),
                      Text(judullagu, style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold
                      ),),
                      Text(artist, style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Outfit',
                      ),),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: InkWell(
                          onTap: (){
                            launchUrl(Uri.parse('https://open.spotify.com/track/${widget.link}'));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Play on Spotify', style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Outfit',
                                color: Colors.white
                              ),

                              ),
                              Image.asset('assets/images/spotipay.png', width: 30,),
                            ],
                          ),),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Text('There\'s someone sending you a message, they want you to read this message that maybe you\'ll like :)',
                  textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                Text(widget.pesan,textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Beanie', fontSize: 30),
                ),
                SizedBox(height: 15,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
