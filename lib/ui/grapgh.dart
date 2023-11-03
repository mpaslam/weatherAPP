import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final List<Feature> features = [
    Feature(
      title: "Temperature",
      color: Colors.blue,
      data: [0.2, 0.3, 0.4, 0.4, 0.3, 0.3,0.4],
    ),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        title: Text("Flutter Draw Graph Demo"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64.0),
            child: Text(
              "Weather Forecast",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          
          LineGraph(
            features: features,
            size: Size(420, 450),
            labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6','Day 7'],
            labelY: ['20', '25', '30', '35', '40', '45','50'],
            showDescription: true,
            graphColor: Colors.black87,
          ),
          SizedBox(
            height: 10,
          ),
//     IconButton(
      
      
//       onPressed: () {
//      QuickAlert.show(
//  context: context,
 
//  type: QuickAlertType.confirm,
 
//  onConfirmBtnTap: () {
   
//  },
//  onCancelBtnTap: () {
//     Navigator.pop(context);
//  },
//  text: 'Do you want to logout',
//  confirmBtnText: 'Yes',
//  cancelBtnText: 'No',
//  confirmBtnColor: Colors.green,

// );
    
//        }, icon: Icon(Icons.abc_rounded),),
      // ElevatedButton(onPressed:() {
      //     showGeneralDialog(
      // context: context,
      // barrierDismissible: true,
      // barrierLabel: MaterialLocalizations.of(context)
      //     .modalBarrierDismissLabel,
      // barrierColor: Colors.black45,
      // transitionDuration: const Duration(milliseconds: 200),
      // pageBuilder: (BuildContext buildContext,
      //     Animation animation,
      //     Animation secondaryAnimation) {
      //   return Center(
      //     child: Container(
      //       width: MediaQuery.of(context).size.width - 10,
      //       height: MediaQuery.of(context).size.height -  80,
      //       padding: EdgeInsets.all(20),
      //       color: const Color.fromARGB(255, 103, 23, 23),
      //       child: Column(
      //         children: [
      //           ElevatedButton(
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //             child: Text(
      //               "Save",
      //               style: TextStyle(color: Colors.white),
      //             ),
      //            // child: const Color(0xFF1BC0C5),
      //           )
              ],
            ),
          );
    
   
    
   
   
   
   
   
   
   
  
      
    
  }
}