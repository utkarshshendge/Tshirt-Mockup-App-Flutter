import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

import 'dart:ui' as ui;

class ColorRecommend extends StatefulWidget {
  @override
  _ColorReccomendState createState() => _ColorReccomendState();
}

class _ColorReccomendState extends State<ColorRecommend> {
  String greetings = "";
  bool stopConnection = true;
  dynamic file;
  String userimageurl = "";
  String img64 = "";
  String serverUrl = "http://192.168.43.223:5000/name";
  String picUrl =
      "https://raw.githubusercontent.com/octalpixel/Skin-Extraction-from-Image-and-Finding-Dominant-Color/master/82764696-open-palm-hand-gesture-of-male-hand_image_from_123rf.com.jpg";
  Color buttonColor = Colors.blue;
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

    List<int> imageBytes = await file.readAsBytesSync();
    debugPrint("$imageBytes   imagebytes");
    String base64Image = base64Encode(imageBytes);
    debugPrint("( ${base64Image} )");
    setState(() {
      img64 = base64Image;
    });
  }

  Future<List<RecievedColors>> _getColors() async {
    final response = await http.get(serverUrl);
    final decoded = json.decode(response.body);
    // setState(() {
    //   greetings =
    //       decoded["DominantColors"][0]["color"].toString();
    // });

    List<RecievedColors> recievedColors = [];

    for (var u in decoded["DominantColors"]) {
      RecievedColors recieved = RecievedColors(u["cluster_index"],
          u["color"][0], u["color"][1], u["color"][2], u["color_percentage"]);

      recievedColors.add(recieved);
    }

    print(recievedColors.length);
    print(recievedColors[0].index);

    return recievedColors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 200.0,
              child: FutureBuilder(
                future: _getColors(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (stopConnection) {
                    return Container(child: Center(child: Text("Enter Data")));
                  } else if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Loading")));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color.fromRGBO(
                                snapshot.data[index].red.toInt(),
                                snapshot.data[index].green.toInt(),
                                snapshot.data[index].blue.toInt(),
                                0.99),
                          ),
                          title: Text(
                            "${(snapshot.data[index].percent * 100).toInt()}% Accurate",
                            style: TextStyle(color: Colors.white),
                          ),
                          //subtitle: Text(snapshot.data[index].email),
                          onTap: () {
                            // Navigator.push(context,
                            //   new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                            // );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    //container that contains the button
                    width: 150,
                    height: 60,
                    child: FlatButton(
                      color: buttonColor,
                      onPressed: () async {
                        setState(() {
                          stopConnection
                              ? stopConnection = false
                              : stopConnection = true;
                        });
                        // _getColors();
                        // final response =
                        //     await http.get(serverUrl);
                        // final decoded =
                        //     json.decode(response.body) as Map<dynamic, dynamic>;
                        // setState(() {
                        //   greetings =
                        //       decoded["DominantColors"][0]["color"].toString();
                        // });
                      },
                      child: Text(
                        'Press',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    //container that contains the button
                    width: 150,
                    height: 60,
                    child: FlatButton(
                      color: buttonColor,
                      onPressed: () async {
                        final url = serverUrl;
                        //async function to perform http get
                        final response = await http.post(url,
                            body: json.encode({"picUrl": img64}));
                      },
                      child: Text(
                        'send',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    //container that contains the button
                    width: 150,
                    height: 60,
                    child: FlatButton(
                      color: buttonColor,
                      onPressed: () async {
                        getimage();
                      },
                      child: Text(
                        'Pick Image',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RecievedColors {
  final int index;
  // ignore: non_constant_identifier_names
  final double red;
  final double green;
  final double blue;
  final double percent;

  RecievedColors(this.index, this.red, this.green, this.blue, this.percent);
}
