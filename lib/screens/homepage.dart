import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:qrscanner/API/_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String result = "Hey there !";

  //create an object of the api class to get id and send the request
  final apiTool = AttandanceAPI();

//scan function to scan the qr code
  Future _scanQR() async {
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      // print(qrResult.type);

      setState(() {
        result = apiTool.getID(qrResult.rawContent);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Scanner"),
      ),
      body: Center(
        child: Text(
          result,
          style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // focusColor: Colors.purple,
        label: Row(
          children: const [Icon(Icons.camera_alt_rounded), Text('Scan')],
        ),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
