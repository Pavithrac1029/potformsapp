import 'package:flutter/material.dart';

class StepperClass extends StatefulWidget {
  const StepperClass({ Key? key }) : super(key: key);

  @override
  _StepperClassState createState() => _StepperClassState();
}

class _StepperClassState extends State<StepperClass> {
List<Step> getSteps()=>[
Step(isActive:currentStep >=0,title: Text(""),content: Container(height: 300,width: 300,color: Colors.red,)),
Step(isActive: currentStep >=1,title: Text(""),content: Container(height: 300,width: 300,color: Colors.green,)),
Step(isActive: currentStep >=2,title: Text(""),content: Container(height: 300,width: 300,color: Colors.green,)),

];
int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stepper"),),
      body: Container(
        height: 500,
        width: 350,
        color: Colors.amber,
        child: Center(
       child:IconButton(onPressed: 
       (){
         setState((){
           currentStep +=1;
         });
       }, icon: Icon(Icons.add))
        ),
      ),bottomSheet: Container(
        height: 100,
        width: 300,
        child: Stepper(steps:getSteps(),onStepContinue: (){
           setState(() {
            currentStep +=1;
          });
          
        },onStepCancel: (){
          if(currentStep >0){setState(() {
            currentStep -=1;
          });}
           
         
        }, 
        currentStep: currentStep,type: StepperType.horizontal,),
      ),
    );
      
  }
}