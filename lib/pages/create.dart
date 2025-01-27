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

class _AddState extends State<Add> {
Dio dio = Dio();

List<dynamic> Datapesan = [];

TextEditingController penerima = TextEditingController();
TextEditingController pesan = TextEditingController();
TextEditingController link = TextEditingController();
  void adddata() async{

    try{
      Response Datamsg = await Dio().get(
        'https://seleksiitcpandito-default-rtdb.asia-southeast1.firebasedatabase.app/sendmsg.json',);
      Datapesan = Datamsg.data;
      print('get data :  ${Datapesan.length}');
      Map<String, dynamic> data = {
          "penerima": penerima.text,
          "pesan": pesan.text,
          "link" : link.text
      };
      Response response = await dio.patch('https://seleksiitcpandito-default-rtdb.asia-southeast1.firebasedatabase.app/sendmsg/${Datapesan.length}.json', data: data);
      penerima.text = '';
      pesan.text = '';
      link.text = '';
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
                  controller: penerima,
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
                  controller: pesan,
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
                  child: Text('Song or Playlist Spotify Link'),),
                TextField(
                  controller: link,
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Tulis tautan di sini!',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 50,),
                ElevatedButton(onPressed: adddata,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
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
