import 'package:flutter/material.dart';
import 'package:potformsapp/COMMON_WIDGETS/custom_text.dart';



class CustomAlert extends StatefulWidget {
  const CustomAlert({ Key? key }) : super(key: key);

  @override
  _CustomAlertState createState() => _CustomAlertState();

  alertBox(context){
  showDialog(context: context, builder: (BuildContext context){
    return CustomAlert();
  });
}
}

class _CustomAlertState extends State<CustomAlert> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return AlertDialog(
      actions: [
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.directions_bike)
        )
      ],
      content: Container(
height: h*0.4,
width: w*0.8,
child: CustomText(color: Colors.teal,text: "Confirm",)



      ),
    );
  }
}