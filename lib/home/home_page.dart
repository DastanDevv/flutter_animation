import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final duration = const Duration(seconds: 3);
  bool isDay = true;

  /// Changes the theme between day and night.
  void changeTheme() {
    setState(() {
      isDay = !isDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height; // Get the height of the screen
    final width =
        MediaQuery.of(context).size.width; // Get the width of the screen
    const tabColor = Colors.white24; // Define a constant color for tabs

    List<Color> lightBgColors = [
      const Color(0xFF8C2480), // Color 1 for light background
      const Color(0xFFCE587D), // Color 2 for light background
      const Color(0xFFFF9485), // Color 3 for light background
      // if (isFullSun) const Color(0xFFFF9D80), // (Optional) Color 4 for light background based on a condition
    ];

    var darkBgColors = const [
      Color(0xFF0D1441), // Color 1 for dark background
      Color(0xFF283584), // Color 2 for dark background
      Color(0xFF376AB2), // Color 3 for dark background
    ];

    return Scaffold(
      body: AnimatedContainer(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Define the colors for the gradient based on whether it is day or night
            colors: isDay ? lightBgColors : darkBgColors,
            // Set the starting point of the gradient at the top center
            begin: Alignment.topCenter,
            // Set the ending point of the gradient at the bottom center
            end: Alignment.bottomCenter,
          ),
        ),
        duration: duration,
        child: Stack(children: [
          AnimatedPositioned(
            bottom: isDay ? 300 : -140,
            right: 0,
            left: 0,
            duration: duration,
            child: SvgPicture.asset('assets/sun.svg'),
          ),
          Positioned(
            bottom: -55,
            right: 0,
            left: 0,
            child: AnimatedCrossFade(
              duration: duration,
              firstChild: Image.asset(
                'assets/land_tree_light.png',
                width: width,
              ),
              secondChild: Image.asset(
                'assets/land_tree_dark.png',
                width: width,
              ),
              crossFadeState:
                  isDay ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            ),
          ),
          Container(
            height: 70,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(30, 130, 30, 0),
            decoration: BoxDecoration(
              color: tabColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: DefaultTabController(
              length: 2,
              child: TabBar(
                // Call the changeTheme function when a tab is tapped
                onTap: (value) => changeTheme(),
                // Set the color of the selected tab's label to black
                labelColor: Colors.black,
                // Set the color of the unselected tab's label to white
                unselectedLabelColor: Colors.white,
                // Set the style of the tab's label
                labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                // Set the decoration for the tab indicator
                indicator: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                // Define the tabs
                tabs: const [
                  Tab(text: 'Morning Light'),
                  Tab(text: 'Night Dark'),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
