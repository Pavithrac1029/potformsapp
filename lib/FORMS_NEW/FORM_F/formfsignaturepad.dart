import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:potformsapp/FORMS_NEW/FORM_F/Form%20F.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';



import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;

import 'package:path_provider/path_provider.dart';

import '../../COMMON_WIDGETS/custom_button.dart';
import '../../COMMON_WIDGETS/custom_text.dart';

class formfsignaturepad extends StatefulWidget {
  const formfsignaturepad({Key? key}) : super(key: key);

  @override
  State<formfsignaturepad> createState() => _formfsignaturepadState();
}

class _formfsignaturepadState extends State<formfsignaturepad> {
  List sign = [];
  var userId, Formfsign1;
  late AnimationController _controller;

  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  var UserName, sharedLOGINID;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);

    getId();

    loginId();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FormF()));
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
          child: Column(
            children: [
              SizedBox(
                height: h * 0.1,
              ),
              Container(
                height: h * 0.001,
                width: w,
                //color: Colors.amber,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: w * 0.12),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Container(
                height: h * 0.08,
                width: w * 0.9,
                // color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.1, top: h * 0.015),
                  child: CustomText(
                    text: "Signature",
                    color: Color.fromRGBO(0, 0, 0, 0.84),
                    size: 22,
                    weight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Container(
                height: h * 0.71,
                decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 9, 89, 94),
                  // color: Colors.red,
                  // borderRadius: BorderRadius.circular(15),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              height: h * 0.7,
                              width: w * 0.9,
                              child: SfSignaturePad(
                                  key: signatureGlobalKey,
                                  strokeColor: Colors.black,
                                  minimumStrokeWidth: 1.0,
                                  maximumStrokeWidth: 4.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomSheet: Container(
          height: h * 0.18,
          width: w,
          //color: Colors.red,
          //  color: Colors.transparent,
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
          child: Stack(
            children: [
              Container(
                height: h * 0.18,
                width: w * 0.9,
              ),
              Positioned(
                bottom: h * 0.05,
                left: w * 0.09,
                child: Custom_Button(
                  onTap: () {
                    handleSaveButtonPressed();
                  },
                  iconWant: false,
                  height: h * 0.12,
                  width: w * 0.35,
                  color: Color(0xff213B68),
                  text: "Save",
                  weight: FontWeight.normal,
                  border: Border.all(color: Colors.transparent),
                  btText: 15,
                ),
              ),
              Positioned(
                bottom: h * 0.05,
                right: w * 0.09,
                child: Custom_Button(
                  onTap: () {
                    handleClearButtonPressed();
                  },
                  iconWant: false,
                  height: h * 0.12,
                  width: w * 0.35,
                  color: Color(0xff213B68),
                  text: "Cancel",
                  weight: FontWeight.normal,
                  border: Border.all(color: Colors.transparent),
                  btText: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginId() async {
    SharedPreferences preferences1 = await SharedPreferences.getInstance();
    preferences1.getInt("LOGINID");
    setState(() {
      sharedLOGINID = preferences1.getInt("LOGINID");
    });
    print("---------------loginid:----------------");
    Logger().w(sharedLOGINID);
  }

  getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getInt("employeeId");
    setState(() {
      userId = preferences.getInt("employeeId");
    });
    print("----------line-----");
    print("empid: $userId");
  }

  handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  converBase(fileName) {
    base64Encode(fileName);
    // print("-----------convert---------");
  }

  handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);

    print(signatureGlobalKey.currentState);

    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes =
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Output.png';
    final File file = File(fileName);
    await file.writeAsBytes(imageBytes, flush: true);

    String base64string = base64Encode(imageBytes);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("Formfsignature", base64string);
    print("formfsignaturepage:$Formfsign1");

    setState(() {
      sign.add(bytes);
      print("-----------------sign---------------");
      print(base64string);

      Logger().wtf(base64string);

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    });

    // var url = Uri.parse("${Baseurl().baseurl}${Baseurl().formfnormalpost}");

    // Logger().e(url);

    // var response = await http.post(url, body: <String, dynamic>{
    //   "Witness_1_sign": base64string.toString(),
    //   "id_f": userId.toString(),
    //   "Login": sharedLOGINID.toString(),
    // });

    if (bytes == null) return null;
    if (bytes != null) {
      // Provider.of<CommonFunctions>(context, listen: false)
      //     .getSigns1(givenBytes: base64string);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => FormF(bytes: bytes)));
    }
  }
}
