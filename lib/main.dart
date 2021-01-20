import 'package:canteen/navbar.dart';
import 'package:canteen/splash.dart';
import 'package:flutter/material.dart';
import 'package:canteen/foodcard.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),

};


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      
      theme: ThemeData(
        primarySwatch: Colors.orange,
        // backgroundColor: Colors.white
      ),
      routes: routes,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   List<String> imgUrl = [
    "https://appcanteen.herokuapp.com/backend/uploads/1-15-2021-23-44-45-1.jpg",
    "https://toreys.net/wp-content/uploads/2019/06/steak-fries-400x209-reduced.png",

 
    "https://pngimage.net/wp-content/uploads/2018/06/sizzler-png-4.png",

 
    "https://pngimage.net/wp-content/uploads/2018/06/sizzler-png-3.png",
    "https://pngimage.net/wp-content/uploads/2018/06/sizzler-png-2.png",
    "https://pngimage.net/wp-content/uploads/2018/06/sizzler-png-8.png",
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FoodZone",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      //Now we are going to open a new file
      // where we will create the layout of the Drawer
      drawer: Drawer(
         child: Container(
           decoration: BoxDecoration(color: Colors.white),
          child: Navbar(),
         )
        
      ),
      // body: Center(child: Text("home page"),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 50.0,
              decoration: BoxDecoration(
                color: Color(0x55d2d2d2),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search... ",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20.0),
                    ),
                  )),
                  RaisedButton(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //Now let's build the food menu
            //I'm going to create a custom widget
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                //let's change the aspect ration for the child card
                childAspectRatio: 0.7,
                children: [
                  foodCard(imgUrl[0], "Meat plate", "25"),
                  foodCard(imgUrl[1], "Meat plate", "25"),
                  foodCard(imgUrl[2], "Meat plate", "25"),
                  foodCard(imgUrl[3], "Meat plate", "25"),
                  foodCard(imgUrl[4], "Meat plate", "25"),
                  foodCard(imgUrl[5], "Meat plate", "25"),
                ],
              ),
            )
          ],
        ),
      ),

      
    );
  }
}
