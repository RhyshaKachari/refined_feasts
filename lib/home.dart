import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchContoller = new TextEditingController();
  getReceipe(String query)async{
    String api_id = await FlutterConfig.get('API_ID');
    String api_key = await FlutterConfig.get('API_KEY');
    var url = Uri.parse("https://api.edamam.com/search?q=$query&app_id=$api_id&app_key=$api_key");
    http.Response response = await http.get(url);
    Map data =  jsonDecode(response.body);
    print(data);

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReceipe("Laddoo");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff213A50),
                  Color(0xff071938)
                ],
              ),
            ),
          ),
        Column(
          children: [
            SafeArea(
              child: Container(
                // Search wala container
                // color: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if((searchContoller.text).replaceAll(" ", "") == ""){
                          print("Blank search");
                        }
                        else{
                          getReceipe(searchContoller.text);
                        }

                        print(searchContoller.text);
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                          controller: searchContoller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Let's Cook Something",
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),

           Container(
             padding: EdgeInsets.symmetric(horizontal:20 ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("WHAT DO YOU WANT TO COOK TODAY ?", style: TextStyle(
                   color: Colors.white, fontSize: 33, fontFamily: "Poppins"
                 ),),
                 SizedBox(height: 10,),
                 Text("Let's Cook Something New!" , style: TextStyle(
                   color: Colors.white, fontSize: 20,fontFamily: "Poppins"
                 ),)
               ],
             ),
           )
    ],
        )


        ],
      ),
    );
  }
}
