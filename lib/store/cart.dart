import 'package:EDI/Widgets/customTextField.dart';
import 'package:EDI/Widgets/custombutton.dart';
import 'package:EDI/config/config.dart';
import 'package:EDI/store/storehome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:EDI/HomePage.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  NetworkImage image1;
  FirebaseUser user;

  cartitem() {
    if (EDIapp.sharedPreferences.getString(EDIapp.items).length == 1) {
      Fluttertoast.showToast(
          msg: 'this cartis empty',
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM);
      Fluttertoast.cancel();
    } else {
      print('cart has item');
      NetworkImage image =
          NetworkImage(EDIapp.sharedPreferences.getString(EDIapp.items));

      image1 = image;
    }
  }

  @override
  void initState() {
    cartitem();
    super.initState();
  }

  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _phonenumController = TextEditingController();
  final TextEditingController addressEditingController =
      TextEditingController();
  final TextEditingController sizeEditingController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Route route = MaterialPageRoute(builder: (_) => HomePage());
            Navigator.pushReplacement(context, route);
          },
        ),
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Custom Tshirt',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
            Center(
              child: Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(image: image1, fit: BoxFit.cover)),
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(height: 10),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nameTextEditingController,
                    data: Icons.person,
                    hintText:
                        EDIapp.sharedPreferences.getString(EDIapp.userName),
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _phonenumController,
                    data: Icons.person,
                    hintText: 'phone number',
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: addressEditingController,
                    data: Icons.person,
                    hintText: 'address',
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: sizeEditingController,
                    data: Icons.person,
                    hintText: EDIapp.sharedPreferences.getString(EDIapp.size),
                    isObsecure: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              child: customButton(label: "BUY"),
              onTap: () {
                orderdetails();
                Fluttertoast.showToast(
                    toastLength: Toast.LENGTH_LONG,
                    msg: 'your order successfully placed',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    gravity: ToastGravity.BOTTOM);
                Route route = MaterialPageRoute(builder: (_) => StoreHome());
                Navigator.pushReplacement(context, route);
                /*Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StoreHome()));*/
              },
            ),
          ],
        ),
      )),
    );
  }

  // ignore: missing_return
  /*  Future orderdetails() async{
    //var firebaseUser=FirebaseAuth.instance.currentUser();
    print('vinay');
    //var user= EDIapp.sharedPreferences.getString(EDIapp.userUID);
    Firestore.instance.collection('orders').document().setData({
      'name': _nameTextEditingController.text.trim(),
      'ph_no': _phonenumController,
      'address': addressEditingController.text.trim(),
      'size': sizeEditingController.text.trim(),
      'p_name': 'Custom t-shirt',
      
    }).then((_) => {print('sucess')});
    print('sirsal');
  
   EDIapp.sharedPreferences.setString("ph_no",EDIapp.phnumber);
   EDIapp.sharedPreferences.setString("address", EDIapp.address);
  //  EDIapp.sharedPreferences.setStringList(EDIapp.userCartList,["garbageValue"]);
  } */
  void orderdetails() async {
    Firestore.instance
        .collection('orders')
        .document(EDIapp.sharedPreferences.getString(EDIapp.userUID))
        .setData({
      //  "image": image.,
      'name': _nameTextEditingController.text.trim(),
      'ph_no': _phonenumController,
      'address': addressEditingController.text.trim(),
      'size': sizeEditingController.text.trim(),
      'p_name': 'Custom t-shirt',
    }).then((_) => {print('sucess')});

    /* await EDIapp.sharedPreferences.setString(EDIapp.userName,  _nameTextEditingController.text.trim());
     await EDIapp.sharedPreferences.setString(EDIapp.size, sizeEditingController.text.trim());
     await EDIapp.sharedPreferences.setString(EDIapp.phnumber, _phonenumController.toString());
     await EDIapp.sharedPreferences.setString(EDIapp.address, addressEditingController.text.trim());*/
  }
}
