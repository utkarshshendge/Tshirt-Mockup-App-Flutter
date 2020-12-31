import 'package:EDI/Widgets/custombutton.dart';
import 'package:EDI/Widgets/myDrawer.dart';
import 'package:EDI/counter/cartitemcounter.dart';
import 'package:EDI/drawer/customizedtile.dart';
import 'package:EDI/store/cart.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:EDI/store/color_recommend.dart';
import 'package:EDI/store/home.dart';
import 'package:EDI/store/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
//import 'package:EDIapp/Config/config.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     Stack(
        //       children: [
        //         IconButton(
        //           icon: Icon(Icons.shopping_cart, color: Colors.white),
        //           onPressed: () {
        //             Route route = MaterialPageRoute(builder: (_) => CartPage());
        //             Navigator.pushReplacement(context, route);
        //           },
        //         ),
        //         Positioned(
        //             child: Stack(
        //           children: [
        //             Icon(Icons.brightness_1, size: 20, color: Colors.white),
        //             Positioned(
        //               top: 3,
        //               bottom: 4,
        //               left: 4,
        //               child: Consumer<CartItemCounter>(
        //                   builder: (context, counter, _) {
        //                 return Text(
        //                   counter.count.toString(),
        //                   style: TextStyle(
        //                     color: Colors.black,
        //                     fontSize: 10,
        //                   ),
        //                 );
        //               }),
        //             )
        //           ],
        //         ))
        //       ],
        //     )
        //   ],
        //   title: Text(
        //     'ECOMAPP',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(

                    // gradient: LinearGradient(colors: <Color>[

                    //   Colors.blueAccent,
                    //   Colors.blue,

                    // ],

                    // ) ),
                    ),
                child: Text(
                  'Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Customizedtile(Icons.person, 'Profile', () => {}),
              Customizedtile(Icons.notifications, 'notifications', () => {}),
              Customizedtile(Icons.settings, 'setting', () => {}),
              Customizedtile(Icons.lock, 'logout', () => {}),
              Customizedtile(Icons.movie_filter, 'Meetings', () => {}),
              Customizedtile(Icons.drag_handle, 'Appointments', () => {}),
              Customizedtile(Icons.feedback, 'Feedback', () => {}),
              Customizedtile(Icons.account_box, 'About Us', () => {}),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Route route =
                            MaterialPageRoute(builder: (_) => CartPage());
                        Navigator.pushReplacement(context, route);
                      },
                      child: Icon(
                        LineAwesomeIcons.shopping_bag,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  child: customButton(label: "Pick a solid colour"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DesignPickerPage()));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    child: customButton(label: "Recommend Color"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ColorRecommend()));
                    }),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: customButton(label: "Pick an image"),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: ColorFiltered(
                    child: Image.asset(
                      'assets/sample.jpg',
                    ),
                    colorFilter:
                        ColorFilter.mode(Colors.yellow, BlendMode.darken),
                  ),
                )

                // FlatButton(onPressed: () {}, child: Text("Select A Solid Colour")),
                // SizedBox(
                //   height: 20,
                // ),
                // FlatButton(onPressed: () {}, child: Text("Select A Solid Colour")),
                // SizedBox(
                //   height: 20,
                // ),

                // FlatButton(onPressed: () {}, child: Text("Select A Solid Colour")),
                // SizedBox(
                //   height: 20,
                // ),

                // FlatButton(onPressed: () {}, child: Text("Select A Solid Colour")),

                // Container(
                //   width: 350,
                //   height: 150,
                //   child: Center(
                //     child: Text('My color is: '),
                //   ),
                //   decoration: new BoxDecoration(color: _customColor),
                // ),
                // new ColorPicker(
                //   color: Colors.red,
                //   onChanged: (value) {
                //     setState(() {
                //       _customColor = value;
                //     });
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell();
}*/

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}

void checkItemInCart(String productID, BuildContext context) {}
