import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchContoller = new TextEditingController();
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
                          Navigator.pushReplacementNamed(context, "/loading",arguments: {
                            "searchText" : searchContoller.text,
                          });
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
                   color: Colors.white, fontSize: 33,
                 ),),
                 SizedBox(height: 10,),
                 Text("Let's Cook Something New!" , style: TextStyle(
                   color: Colors.white, fontSize: 20,
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
