// import 'package:Burn/data_models.dart/stretches_data.dart';

// import 'package:flutter/material.dart';

// class Streches extends StatefulWidget {
//   final int level;
//   final int workoutType;
//   final int week;
//   final exercise;
//   Streches(
//       {Key key,
//       @required this.level,
//       @required this.workoutType,
//       @required this.exercise,
//       @required this.week})
//       : super(key: key);

//   @override
//   _StrechesState createState() => _StrechesState();
// }

// class _StrechesState extends State<Streches> {

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//       //   Container(
//       //     color: Colors.black,
//       //   ),
//       //   SafeArea(
//       //     child: Scaffold(
//       //       floatingActionButton: RoundedButton(
//       //           bold: true,
//       //           width: MediaQuery.of(context).size.width * 0.4,
//       //           heigth: 30,
//       //           elevation: 0.0,
//       //           text: 'Start',
//       //           radius: BorderRadius.circular(12),
//       //           fontSize: 16,
//       //           textColor: Colors.black,
//       //           backgroundColor: Colors.yellow,
//       //           onPressed: () {
//       //             Navigator.push(
//       //                 context,
//       //                 BouncyPageRoute(
//       //                     widget: DoExercise(
//       //                   workoutData: stretchType,
//       //                   exercise: widget.exercise,
//       //                 )));
//       //           }),
//       //       body: NestedScrollView(
//       //           physics: BouncingScrollPhysics(),
//       //           headerSliverBuilder:
//       //               (BuildContext context, bool innerBoxIsScrolled) {
//       //             return <Widget>[
//       //               SliverAppBar(
//       //                 expandedHeight: 400.0,
//       //                 floating: false,
//       //                 pinned: false,
//       //                 stretch: true,
//       //                 elevation: 00.0,
//       //                 backgroundColor: AllCoustomTheme.getThemeData()
//       //                     .scaffoldBackgroundColor,
//       //                 // leading: Container(),
//       //                 flexibleSpace: FlexibleSpaceBar(
//       //                     centerTitle: true,
//       //                     title: Column(
//       //                       crossAxisAlignment: CrossAxisAlignment.center,
//       //                       mainAxisAlignment: MainAxisAlignment.end,
//       //                       children: [
//       //                         // const SizedBox(
//       //                         //   height: 200,
//       //                         // ),
//       //                         Text(
//       //                           stretchMainText,
//       //                           style: GoogleFonts.crimsonPro(
//       //                               fontSize: 18,
//       //                               color: Colors.yellow,
//       //                               fontWeight: FontWeight.bold),
//       //                         ),
//       //                         const SizedBox(
//       //                           height: 20,
//       //                         ),
//       //                       ],
//       //                     ),
//       //                     background: Stack(
//       //                       fit: StackFit.expand,
//       //                       children: [
//       //                         ClipRRect(
//       //                           borderRadius: BorderRadius.only(
//       //                               bottomRight: Radius.circular(20),
//       //                               bottomLeft: Radius.circular(20)),
//       //                           child: Image.asset(
//       //                             'assets/jazFit.jpg',
//       //                             fit: BoxFit.cover,
//       //                           ),
//       //                         ),
//       //                         Container(
//       //                           color: Colors.black.withOpacity(0.6),
//       //                         )
//       //                       ],
//       //                     )),
//       //               ),
//       //             ];
//       //           },
//       //           body: ListView.builder(
//       //               itemCount: stretchType.length,
//       //               itemBuilder: (context, index) {
//       //                 final data = stretchType[index];
//       //                 return ListTile(
//       //                   onTap: () => Navigator.push(
//       //                       context,
//       //                       BouncyPageRoute(
//       //                           widget: ExerciseDetails(
//       //                         exerciseName: data['name'],
//       //                         exerciseImage: data['gifUrl'],
//       //                       ))),
//       //                   leading: ClipRRect(
//       //                       borderRadius: BorderRadius.circular(10),
//       //                       child: CachedNetworkImage(
//       //                         imageUrl: data['gifUrl'],
//       //                         placeholder: (context, place) {
//       //                           return CircularProgressIndicator(
//       //                             backgroundColor: Colors.white,
//       //                           );
//       //                         },
//       //                       )),
//       //                   title: Text(
//       //                     '${data['name']}'.toUpperCase(),
//       //                     style: textText(
//       //                         fontSize: 14, color: Colors.yellow, bold: true),
//       //                   ),
//       //                   subtitle: Text(
//       //                     '',
//       //                     style: textText(
//       //                         fontSize: 12, color: Colors.yellow, bold: false),
//       //                   ),
//       //                   trailing: Icon(
//       //                     Icons.arrow_right_outlined,
//       //                     color: Colors.yellow,
//       //                   ),
//       //                 );
//       //               })),
//       //     ),
//       //   ),
//       ],
//     );
//   }
// }
