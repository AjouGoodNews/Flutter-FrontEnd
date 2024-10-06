import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  final List<Widget> _screens = [

  ];

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _screens[_selectedIndex]),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.black,
            backgroundColor: Colors.white,
            onTap: (index) => _onItemTapped(index),
            currentIndex: _selectedIndex,
            showUnselectedLabels: true,
            selectedLabelStyle: CustomTextStyle.caption1.apply(color: primary),
            unselectedLabelStyle: CustomTextStyle.caption1,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.newspaper_outlined,
                  size: 24,
                  color: _selectedIndex == 0 ? Colors.black : Colors.black12,
                ),
                label: '스크랩',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_outlined,
                  size: 24,
                  color: _selectedIndex == 1 ? Colors.black : Colors.black12,
                ),
                label: '검색',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outlined,
                  size: 24,
                  color: _selectedIndex == 2 ? Colors.black : Colors.black12,
                ),
                label: '설정',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}