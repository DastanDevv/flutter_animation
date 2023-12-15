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

  void changeTheme() {
    setState(() {
      isDay = !isDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const tabColor = Colors.white24;

    List<Color> lightBgColors = [
      const Color(0xFF8C2480),
      const Color(0xFFCE587D),
      const Color(0xFFFF9485),
      // if (isFullSun) const Color(0xFFFF9D80),
    ];
    var darkBgColors = const [
      Color(0xFF0D1441),
      Color(0xFF283584),
      Color(0xFF376AB2),
    ];

    return Scaffold(
      body: AnimatedContainer(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDay ? lightBgColors : darkBgColors,
            begin: Alignment.topCenter,
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
                onTap: (value) => changeTheme(),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                indicator: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
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
