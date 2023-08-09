import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:potformsapp/BASE%20URL/api.dart';
import 'package:potformsapp/FORMS_NEW/FORM_F/Form%20F.dart';
import 'package:potformsapp/LOGIN_NEW/login_view_controller.dart';
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
  var UserName,
      EmpID,
      updatesign,
      employeedetailspostcode,
      employeedetailspostmessage;

  @override
  initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    Provider.of<LoginController>(context, listen: false).getEmployeeid();
    EmpID = Provider.of<LoginController>(context, listen: false).EmployeeID;
    print("eplllllid:${EmpID.toString()}");

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

    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    print("bytesss:$bytes");
    final Uint8List imageBytes =
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    print("uintbytes:$imageBytes");
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Employeesign.png';
    final File file = File(fileName);
    print("fileee:${file.path as String}");

    updatesign = File(file.path as String);

    await file.writeAsBytes(imageBytes, flush: true);

    String imageLink = file.path;
    print("Image Link: $imageLink");

    print("imageeebytes:$imageBytes");

    //  String base64string = base64Encode(imageBytes);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    //   preferences.setString("Formfsignature", base64string);
    print("formfsignaturepage:$Formfsign1");

    setState(() {
      sign.add(bytes);
 

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    });



    if (bytes == null) return null;
    if (bytes != null) {
      
      signapiPost();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => FormF(bytes: bytes)));
    }
  }

  signapiPost() async {
    var url = Uri.parse(
        "${Provider.of<Baseurl>(context, listen: false).baseurl}${Baseurl().emplyeedetailspost}");
    print("posurl:$url");
    print(updatesign);

    http.MultipartRequest request = new http.MultipartRequest(
      'POST',
      url,
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
    });

    request.fields['Emp_ID'] = EmpID.toString();

    request.files.add(http.MultipartFile(
        'sign', updatesign.readAsBytes().asStream(), updatesign.lengthSync(),
        filename: updatesign.path.split("/").last));

    var res = await request.send();

    var response = await http.Response.fromStream(res);
    var response1 = http.BaseResponse;

    var decodeDetails = json.decode(response.body);
    print("employeedetails:$decodeDetails");
    employeedetailspostcode = decodeDetails['code'];
    employeedetailspostmessage = decodeDetails['message'];

    if (employeedetailspostcode == 200) {
      final snackBar = SnackBar(
        backgroundColor: Color(0xff213B68),
        content:
            Text("${employeedetailspostcode}:${employeedetailspostmessage}"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if (mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FormF()));
      }
    } else if (employeedetailspostcode == 202) {
      final snackBar = SnackBar(
        backgroundColor: Color(0xff213B68),
        content:
            Text("${employeedetailspostcode}:${employeedetailspostmessage}"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        backgroundColor: Color(0xff213B68),
        content:
            Text("${employeedetailspostcode}:${employeedetailspostmessage}"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
