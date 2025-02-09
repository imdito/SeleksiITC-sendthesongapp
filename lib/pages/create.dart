import 'package:flutter/material.dart';
import 'package:nyoba/pages/appbar.dart';
import 'package:dio/dio.dart';


void main(){
  runApp(Add());
}

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}
class datalagu {
  String idlagu = '';
  String namalagu = '';
  String penyanyi = '';
  String gambar = '';

  datalagu({required this.idlagu, required this.namalagu, required this.penyanyi, required this.gambar});
}

class datapesan {
  TextEditingController penerima = TextEditingController();
  TextEditingController pesan = TextEditingController();

  datapesan({required this.penerima, required this.pesan});
}

class _AddState extends State<Add> {

  Dio dio = Dio();
  var Datalagu = new datalagu(idlagu: '', namalagu: '', penyanyi: '', gambar: '');
  var Datapesan = new datapesan(penerima: TextEditingController(), pesan: TextEditingController());
  List<dynamic> lagu = [];
  List<dynamic> getpesan = [];
  String accessToken = '';
  TextEditingController search = TextEditingController();

  Future<void>gettoken(int index) async{
    Dio dio = Dio();
    try{
      Response token = await Dio().get(
        'https://seleksiitcpandito-default-rtdb.asia-southeast1.firebasedatabase.app/sendtoken.json',);
      accessToken = token.data[0]['access_token'];
      await dio.get('https://api.spotify.com/v1/artists/0TnOYISbd1XYRBk9myaseg', options:
      Options(headers: {'Authorization' : 'Bearer $accessToken'}));
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
      if(index == 0){
        Alertbox(pesanalertbox: 'error');
      }else{
        return gettoken(index--);
      }
    }
  }

  Future<dynamic> searchsong() async {
    Dio dio = Dio();
    FocusScopeNode focusScopeNode = FocusScope.of(context); // tutup keyboard
    if(!focusScopeNode.hasPrimaryFocus){
      focusScopeNode.unfocus();
    }
    try {

      final response = await dio.get(
        'https://api.spotify.com/v1/search',
        queryParameters: {
          'q': 'track:${search.text}',
          'type': 'track',
          'market': 'ID',
          'limit': 10
        },
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );
      lagu = response.data['tracks']['items'];
          setState(() {});
    }catch(e){
      return Alertbox(pesanalertbox: 'Errror, silahkan cek koneksi internet!');
    }
  }

  void adddata() async{
    FocusScopeNode focusScopeNode = FocusScope.of(context); // tutup keyboard
    if(!focusScopeNode.hasPrimaryFocus){
      focusScopeNode.unfocus();
    }
    try{
      Response Datamsg = await Dio().get(
        'https://seleksiitcpandito-default-rtdb.asia-southeast1.firebasedatabase.app/sendmsg.json',);
      getpesan = Datamsg.data;
      Map<String, dynamic> data = {
          "penerima": Datapesan.penerima.text,
          "pesan": Datapesan.pesan.text,
          "link" : Datalagu.idlagu
      };
      await dio.patch('https://seleksiitcpandito-default-rtdb.asia-southeast1.firebasedatabase.app/sendmsg/${getpesan.length}.json', data: data);
      Datapesan.penerima.text = '';
      Datapesan.pesan.text = '';
      search.text = '';
      Datalagu.idlagu = '';
      showDialog(context: context, builder: (context){
        return Alertbox(pesanalertbox: 'Pesan sukses dikirm!');

      });
      setState(() {});
    }catch(error){
      showDialog(context: context, builder: (context){
        return Alertbox(pesanalertbox: 'Maaf URL saat ini sedang tidak valid, silahkan periksa koneksi internet anda!');

      });
    }
  }

  @override
  void initState() {
    super.initState();
    gettoken(3);
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
            height: double.infinity,
            width: 300,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text('Recipient Name', textAlign: TextAlign.start,)),
                TextField(
                  controller: Datapesan.penerima,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama penerima!',
                    helperMaxLines: 1,
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                Align(alignment: Alignment.topLeft,
                child: Text('Message'),),
                TextField(
                  controller: Datapesan.pesan,
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Tulis pesan di sini!',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20,),
                Align(alignment: Alignment.topLeft,
                  child: Text('Cari lagu yang ingin dikirim!'),),
                 Row(
                  children: [
                    ElevatedButton(onPressed: searchsong,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                            )
                        ),
                        child: Icon(Icons.search, color: Colors.white,)),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextField(
                        controller: search,
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          hintText: 'Tulis judul lagu di sini!',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                search.text.isNotEmpty ? SizedBox(
                  height: 200,
                  child:Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green
                    ),
                    child: ListView.builder(
                          itemCount: lagu.length,
                          itemBuilder: (context, int index){
                            return SizedBox(
                              height: 50,
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    Datalagu.idlagu = lagu[index]['id'];
                                    Datalagu.namalagu = lagu[index]['name'];
                                    Datalagu.penyanyi = lagu[index]['artists'][0]['name'];
                                    Datalagu.gambar = lagu[index]['album']['images'][0]['url'];
                                    search.text = '';
                                  });
                                },
                                child: Row(
                                  children: [
                                    Image(image: NetworkImage(lagu[index]['album']['images'][0]['url']), width: 50,),
                                    SizedBox(width: 5,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              child: Text(lagu[index]['name'],
                                                overflow: TextOverflow.ellipsis,)
                                          ),
                                          Text(lagu[index]['artists'][0]['name'])
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  ),
                )
                 : (Datalagu.idlagu.isNotEmpty) ? Container(
                  padding: EdgeInsets.all(5),
                  height: 80, width: 250,
                  decoration:
                  BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Image(image: NetworkImage(Datalagu.gambar)),
                        SizedBox(width: 20,),
                        Flexible(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(Datalagu.namalagu, style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis,
                            ),
                            Text(Datalagu.penyanyi, style: TextStyle(
                              fontSize: 15,
                            ),)
                          ],),
                        )
                      ],
                    ),
                  ) ,
                ) : Text(''),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (Datapesan.penerima.text.isNotEmpty && Datalagu.idlagu.isNotEmpty) ? adddata : (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (Datapesan.penerima.text.isNotEmpty && Datalagu.idlagu.isNotEmpty) ?  Colors.black : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      )

                    ),
                    child: Text('Kirim',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))
              ],
            ),
          ),
        )
      );
  }
}
