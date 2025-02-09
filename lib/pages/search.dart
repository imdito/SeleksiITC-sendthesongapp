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

  List<dynamic> Datapesan = [];
  List<dynamic> Filtereddata = [];
  TextEditingController searchtext = TextEditingController();


  Future<void> GetData() async{
    try{
      Response Datamsg = await Dio().get(
          'https://seleksiitcpandito-default-rtdb.asia-southeast1.firebasedatabase.app/sendmsg.json',);
      Datapesan = Datamsg.data;
      Filtereddata = Datapesan.where((element) => element['penerima'] == searchtext.text).toList();
      if(Filtereddata.isEmpty){
        showDialog(context: context, builder: (context){
          return Alertbox(pesanalertbox: 'Maaf penerima dengan nama ini tidak ditemukan :(', ikon: Icons.no_accounts_outlined,);
        });
      }
      FocusScope.of(context).unfocus();
      setState((){});
    }catch(error){
      showDialog(context: context, builder: (context){
        return Alertbox(pesanalertbox: "Maaf Url sedang tidak valid!", ikon: Icons.signal_wifi_connected_no_internet_4_rounded,);
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
                        controller: searchtext, // untuk dapetin nama yang dicari
                        decoration: InputDecoration(
                            hintText: 'Masukkan nama penerima!',
                            helperMaxLines: 1,
                            border: OutlineInputBorder()
                        ),
                      ),)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: ListView.builder(
                        itemCount: Filtereddata.length,
                        itemBuilder: (context, int index ){
                          return Column(
                            children: [
                              Container(

                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: InkWell(
                                  onTap: (){
                                    FocusScopeNode focusScopeNode = FocusScope.of(context); // tutup keyboard
                                    if(!focusScopeNode.hasPrimaryFocus){
                                      focusScopeNode.unfocus();
                                    }
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context){
                                          return msgpage(penerima: Filtereddata[index]['penerima'], pesan: Filtereddata[index]['pesan'], link: Filtereddata[index]['link'],);
                                        }));
                                  },
                                  child: SizedBox(
                                    width: 300,
                                    height: 130,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, top: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          Text('To : ${Filtereddata[index]['penerima']}', style: TextStyle(fontSize: 20, fontFamily: 'Outfit'),),
                                          SizedBox(height: 10,),
                                          Text(Filtereddata[index]['pesan'], style: TextStyle(fontSize: 35, fontFamily: 'Beanie', height:1),
                                              textAlign: TextAlign.left,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,)
                            ],
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
