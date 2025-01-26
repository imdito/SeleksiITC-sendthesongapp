import 'package:flutter/material.dart';
import 'package:nyoba/pages/appbar.dart';
import 'package:dio/dio.dart';
import 'package:nyoba/pages/messagepage.dart';

void main(){
  runApp(Search());
}

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {

  String cari = '';

  List<dynamic> Datapesan = [];
  List<dynamic> Filtereddata = [];
  TextEditingController searchtext = TextEditingController();


  Future<void> GetData() async{
    try{
      Response Datamsg = await Dio().get(
          'https://seleksiitcpandito-default-rtdb.asia-southeast1.firebasedatabase.app/sendmsg.json',);
      Datapesan = Datamsg.data;
      print(Datapesan.length);
      cari = searchtext.text;
      Filtereddata = Datapesan.where((element) => element['penerima'] == cari).toList();

      setState((){});
    }catch(error){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Maaf! url sedang tidak valid'),
        );
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
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      ElevatedButton(onPressed: GetData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                            )
                          ),
                          child: Icon(Icons.search, color: Colors.white,)),
                      SizedBox(width: 10,),
                      Expanded(child: TextField(
                        controller: searchtext,
                        decoration: InputDecoration(
                            hintText: 'Masukkan nama penerima!',
                            helperMaxLines: 1,
                            border: OutlineInputBorder()
                        ),
                      ),)
                    ],
                  ),
                    Expanded(
                    child: ListView.builder(
                        itemCount: Filtereddata.length,

                        itemBuilder: (context, int index ){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return msgpage(penerima: Filtereddata[index]['penerima'], pesan: Filtereddata[index]['pesan'], link: Filtereddata[index]['link'],);
                                  }));
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                              padding: EdgeInsets.only(top: 15, left: 20, right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('To- ${Filtereddata[index]['penerima']}', style: TextStyle(fontSize: 20),),
                                  Text(Filtereddata[index]['pesan'], style: TextStyle(fontSize: 35, fontFamily: 'Beanie'),textAlign: TextAlign.left, maxLines: 2, overflow: TextOverflow.ellipsis)
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  )
                ],
              ),
            ),
          ),
      );
  }
}
