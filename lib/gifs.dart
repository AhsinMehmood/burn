import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'dart:io';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<File> _files = [];
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  StorageUploadTask _uploadTask;

  Future<void> init() async {
    List<File> files = [];
    // FilePickerResult result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: [
    //     'gif',
    //   ],
    // );
    // print(result.names);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _files = files;
    });
  }

  List<String> names = [];
  upload() async {
    // _files.forEach((File element) async {
    //     print(element.path);
    //     StorageReference storageReference =
    //         FirebaseStorage.instance.ref().child(name.name);

    //     _uploadTask = storageReference.putFile(
    //         element, StorageMetadata(contentType: 'image/gif'));
    //     await _uploadTask.onComplete;
    //     String fileUrl = await storageReference.getDownloadURL();
    //     print(fileUrl);
    //     await Firestore.instance
    //         .collection('photos')
    //         .document(name.name)
    //         .setData({
    //       name.name: fileUrl,
    //     });
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                upload();
                // init();
              },
              child: Icon(Icons.ac_unit_outlined),
            ),
          ),
          RaisedButton(
            child: Text('pick'),
            onPressed: () => init(),
          ),
        ],
        title: const Text('Plugin example app'),
      ),
      body: ListView.builder(
          itemCount: 0,
          itemBuilder: (context, index) {
            return Image.file(_files[index].absolute);
          }),
    );
  }
}
