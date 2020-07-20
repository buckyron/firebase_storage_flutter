import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File sampleImage;

  Future getImage() async{
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: sampleImage == null? Text('Pick an image'): enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Upload the image to the firebase storage
  Widget enableUpload(){
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage,height: 300.0,width: 300.0),
          RaisedButton(
            child: Text('Upload'),
            elevation: 10,
            textColor: Colors.white,
            onPressed: (){
              final StorageReference firebaseStorageref = FirebaseStorage.instance.ref().child('myimage.jpg');
              final StorageUploadTask task = firebaseStorageref.putFile(sampleImage);
            },
          )
        ],
      ),
    );
  }
}
