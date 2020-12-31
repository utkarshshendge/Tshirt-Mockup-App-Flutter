import 'dart:convert';
import 'dart:typed_data';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:EDI/Widgets/custombutton.dart';
import 'package:EDI/HomePage.dart';
import 'package:EDI/config/config.dart';
import 'package:EDI/store/storehome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'dart:ui' as ui;

class DesignPickerPage extends StatefulWidget {
  @override
  _DesignPickerPageState createState() => _DesignPickerPageState();
}

class _DesignPickerPageState extends State<DesignPickerPage> {
  Color customColor = Colors.red;

  dynamic file;
  String userimageurl = "";

  //_DesignPickerPageState(this.customColor);
  //_DesignPickerPageState({ this.customColor});
  void getimage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    dynamic crop = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 300,
        maxWidth: 300,
        compressFormat: ImageCompressFormat.png,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.blueAccent,
          toolbarTitle: 'crop image',
        ));

    file = File(crop.path);
    setState(() {
      file = crop;
    });
  }

  StorageReference storageReference = FirebaseStorage().ref();
  GlobalKey _key = GlobalKey();
  bool loading = false;
  void widgettoimage() async {
    RenderRepaintBoundary renderRepaintBoundary =
        _key.currentContext.findRenderObject();
    ui.Image boximage = await renderRepaintBoundary.toImage(pixelRatio: 1);
    ByteData byteData =
        await boximage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData.buffer.asUint8List();
    this.setState(() {
      loading = true;
    });
    StorageUploadTask storageUploadTask = storageReference
        .child("IMG_${DateTime.now().millisecondsSinceEpoch}.png")
        .putData(uint8list);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    await taskSnapshot.ref.getDownloadURL().then((url) {
      userimageurl = url;
    });
    this.setState(() {
      loading = false;
    });

    //StorageTaskSnapshot taskSnapshot=await storageUploadTask.onComplete

    Firestore.instance
        .collection('items')
        .document(FirebaseAuth.instance.currentUser().toString())
        .setData({
      //  "image": image.,
      'url': userimageurl,
      'size': choice
    });

    await EDIapp.sharedPreferences.setString(EDIapp.items, userimageurl);
    await EDIapp.sharedPreferences.setString(EDIapp.size, choice);
  }

  String choice;
  List listitem = ['S', 'L', 'XL', 'XX'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text(
          'EDI',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RepaintBoundary(
                key: _key,
                child: Container(
                  // color: Colors.black,
                  width: 500,
                  height: 400,
                  decoration: new BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage('assets/shirt.jpg'),
                      colorFilter:
                          ColorFilter.mode(customColor, BlendMode.darken),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 120,
                      width: 250,
                      child: InteractiveViewer(
                        panEnabled: false,
                        boundaryMargin: EdgeInsets.all(50),
                        minScale: 0.1,
                        maxScale: 2.0,

                        child: file == null
                            ? Text(
                                'no image selected',
                                textAlign: TextAlign.center,
                              )
                            : Image.file(file),
                        //Image.asset('assets/man.png',width: 200,height:200,fit: BoxFit.cover,),),),)

                        //color: customColor,
                        //color: ColorFilter.mode(_customColor,BlendMode.darken) ,
                      ),
                    ),
                  ),
                ),
              ),
              (loading)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(),

              //colorFilter: ColorFilter.mode(_customColor,BlendMode.darken),

              // Container(
              //   width: 350,
              //   height: 150,
              //   child: Center(
              //     child: Text('My color is: '),
              //   ),
              //   decoration: new BoxDecoration(color: _customColor),
              // ),
              SizedBox(
                height: 500,
                width: 300,
                child: new ColorPicker(
                  color: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      customColor = value;
                    });
                  },
                ),
              ),
              /*GestureDetector(
                child: customButton(label: "Purchase solid colour tshirt"),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),*/
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    height: 45,
                    width: 100,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        getimage();
                        //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> Addimage( value: passdata(account: customColor)));
                      },
                      child: Text(
                        'pick',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  SizedBox(
                    height: 45,
                    width: 100,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        //widgettoimage();
                        bottomsheet();

                        //Fluttertoast.cancel();
                        /*showDialog(
                    context: context,
                    barrierDismissible: false,
                    child: AlertDialog(
                      content: Text('Your item succesfully added to cart press ok',style:TextStyle(color: Colors.black)),
                      elevation: 12,
                      actions: [
                        FlatButton(onPressed: ()=>Navigator.pop(context),
                         child: Text('ok',style:TextStyle(color: Colors.black) ,),
                         )
                      ],
                     
                    ),
                  );*/
                        //Navigator.pop(context);
                        print('vinay');
                        // getimage();
                        //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> Addimage( value: passdata(account: customColor)));
                      },
                      child: Text(
                        'Cart',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bottomsheet() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Select Size',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButton(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  hint: Text(
                    'select size',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  value: choice,
                  items: listitem.map((value) {
                    return DropdownMenuItem(
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.white),
                      ),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (newvalue) {
                    setState(() {
                      choice = newvalue;
                      print(choice);
                    });
                  },
                ),

                /* Row(
                 children: [
                  CustomRadioButton(
                     horizontal: false,
                     elevation:5,
                     unSelectedColor: Theme.of(context).primaryColor,
                     buttonLables: [
                       'S',
                       'L',
                       'XL',
                       'XX',
                     ],
                     buttonValues: [
                       'S',
                       'L',
                       'XL',
                       'XX',

                     ],
                     buttonTextStyle: ButtonTextStyle(selectedColor: Colors.white,textStyle: TextStyle(fontSize: 16)),
                     radioButtonValue: (value){
                       print(value);
                     },
                     selectedColor: Colors.greenAccent,
                     


                   ),

                 ],
               ),*/

                SizedBox(height: 18),
                GestureDetector(
                  child: customButton(label: "Continue"),
                  onTap: () {
                    widgettoimage();
                    Fluttertoast.showToast(
                        toastLength: Toast.LENGTH_LONG,
                        msg: 'item successfully added to cart',
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        gravity: ToastGravity.BOTTOM);
                    Navigator.pop(context);
                    /*Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StoreHome()));*/
                  },
                ),
              ],
            ),
          );
        });
  }
}
