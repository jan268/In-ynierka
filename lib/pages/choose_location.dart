// import 'package:flutter/material.dart';
//
// class ChooseLocation extends StatefulWidget {
//   const ChooseLocation({Key? key}) : super(key: key);
//
//   @override
//   _ChooseLocationState createState() => _ChooseLocationState();
// }
//
// class _ChooseLocationState extends State<ChooseLocation> {
//
//   void updateTime(index) async {
//     // Navigate to home screen
//     Navigator.pop(context, {
//       'location' : instance.location,
//       'flag' : instance.flag,
//       'time' : instance.time,
//       'isDaytime' : instance.isDaytime
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('build function ran');
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.blue[900],
//         title: Text('Choose a Location'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: ListView.builder(
//           itemCount: locations.length,
//           itemBuilder: (context, index){
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
//               child: Card(
//                 child: ListTile(
//                   onTap: () {
//                     updateTime(index);
//                   },
//                   title: Text(locations[index].location.toString()),
//                   leading: CircleAvatar(
//                     backgroundImage: AssetImage('assets/${locations[index].flag}'),
//                   ),
//                 ),
//               ),
//             );
//           },
//       ),
//     );
//   }
// }
