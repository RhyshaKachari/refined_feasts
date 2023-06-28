import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:refined_feasts/RecipeView.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:refined_feasts/model.dart';
import 'package:refined_feasts/search.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true ;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchContoller = new TextEditingController();
  List receiptCatList =[{"imgUrl": "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2013/10/30/1/FNK_Spicy-Beef-Chili_s4x3.jpg.rend.hgtvcom.616.462.suffix/1389046130875.jpeg", "heading": "Chilly Food"},
    {"imgUrl": "https://www.expatica.com/app/uploads/sites/19/2022/12/italian-cuisine.jpg", "heading": "Italian Food"},
    {"imgUrl": "https://cdn.tasteatlas.com//Images/Dishes/4cc2758bb1354d4e8b1e018105767fed.jpg?w=375&h=280", "heading": "Chinese Food"},
    {"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Indian Food"}];
  getReceipe(String query) async {
    String api_id = await FlutterConfig.get('API_ID');
    String api_key = await FlutterConfig.get('API_KEY');
    var url = Uri.parse(
        "https://api.edamam.com/search?q=$query&app_id=$api_id&app_key=$api_key");
    http.Response response = await http.get(url);
    Map data = jsonDecode(response.body);
    // log(data.toString());

    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      setState(() {
        isLoading = false;
      });
    });
    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
    });
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
                colors: [Color(0xff213A50), Color(0xff071938)],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
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
                            if ((searchContoller.text).replaceAll(" ", "") ==
                                "") {
                              print("Blank search");
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchContoller.text)));
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
                        )),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WHAT DO YOU WANT TO COOK TODAY ?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 33,
                            fontFamily: "Poppins"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Let's Cook Something New!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Poppins"),
                      )
                    ],
                  ),
                ),
                Container(
                  child: isLoading? CircularProgressIndicator() : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recipeList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeView(recipeList[index].appurl)));
                        },
                        child: Card(
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  recipeList[index].appimgUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration:
                                          BoxDecoration(color: Colors.black26),
                                      child: Text(
                                        recipeList[index].applabel,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ))),
                              Positioned(
                                right: 0,
                                width: 80,
                                height: 40,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      )
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.local_fire_department),
                                          Text(recipeList[index].appcalories.toString().substring(0,6)),
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: receiptCatList.length , shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                      return Container(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Search(receiptCatList[index]["heading"])));
                          },
                          child: Card(
                            margin: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ) ,
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(18.0),
                                  child: Image.network(receiptCatList[index]["imgUrl"], fit: BoxFit.cover ,width: 200,
                                  height: 250,),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  top: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black26
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          receiptCatList[index]["heading"],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28
                                          ),
                                        )
                                      ],
                                    ),
                                  ) ,
                                )
                              ],
                            ),
                          ),
                        ),
                      );

                  }),
                )
              ],
            ),

          )
        ],
      ),
    );
  }
}

