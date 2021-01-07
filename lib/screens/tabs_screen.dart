import 'package:Burn/globals/global.dart';
import 'package:Burn/globals/globalVar.dart';
import 'package:Burn/screens/community_screen.dart';
import 'package:Burn/screens/leader_board.dart';
import 'package:Burn/screens/profile_screen.dart';
import 'package:Burn/screens/workout_screen.dart';
import 'package:Burn/widgets/chart_activity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'settings_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var color = AllCoustomTheme.getThemeData();
  int currentIndex = 0;
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        Scaffold(
          body: body(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Card(
            elevation: 6.0,
            // color: color.scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.yellowAccent),
                // color: color.scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: currentIndex == 0 ? 1.0 : 0.5,
                    child: InkWell(
                      onTap: () => setBottomBarIndex(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Workout',
                            style: textText(
                                fontSize: 12,
                                color: color.primaryColor,
                                bold: true),
                          ),
                          Icon(
                            Icons.home_outlined,
                            color: color.primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: currentIndex == 1 ? 1.0 : 0.5,
                    child: InkWell(
                      onTap: () => setBottomBarIndex(1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Community',
                            style: textText(
                                fontSize: 12,
                                color: color.primaryColor,
                                bold: true),
                          ),
                          Icon(
                            Icons.people_outline,
                            color: color.primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: currentIndex == 2 ? 1.0 : 0.5,
                    child: InkWell(
                      onTap: () => setBottomBarIndex(2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Leaderboard',
                            style: textText(
                                fontSize: 12,
                                color: color.primaryColor,
                                bold: true),
                          ),
                          Icon(
                            Icons.input_outlined,
                            color: color.primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  // Opacity(
                  //   opacity: currentIndex == 3 ? 1.0 : 0.5,
                  //   child: InkWell(
                  //     onTap: () => setBottomBarIndex(3),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           'Profile',
                  //           style: textText(
                  //               fontSize: 12,
                  //               color: color.primaryColor,
                  //               bold: true),
                  //         ),
                  //         Icon(
                  //           Icons.person,
                  //           color: color.primaryColor,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Opacity(
                    opacity: currentIndex == 4 ? 1.0 : 0.5,
                    child: InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        setBottomBarIndex(4);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Settings',
                            style: textText(
                                fontSize: 12,
                                color: color.primaryColor,
                                bold: true),
                          ),
                          Icon(
                            Icons.settings,
                            color: color.primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  body() {
    return currentIndex == 0
        ? WorkoutScreen()
        : currentIndex == 1
            ? CommunityScreen()
            : currentIndex == 2
                ? LeaderBoard()
                : currentIndex == 3
                    ? ProfileScreen()
                    : currentIndex == 4
                        ? SettingsScreen()
                        : Container();
  }
}
