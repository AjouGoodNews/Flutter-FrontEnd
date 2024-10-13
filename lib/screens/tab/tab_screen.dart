import 'package:flutter/material.dart';
import 'package:goodnews/screens/category/category_screen.dart';
import 'package:goodnews/screens/home/home.dart';
import 'package:goodnews/screens/scrap/scrap_screen.dart';
import 'package:goodnews/screens/search/search_screen.dart';
import 'package:goodnews/screens/setting/setting_screen.dart';
import 'package:goodnews/themes/custom_color.dart';
import 'package:goodnews/themes/custom_font.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  final List<Widget> _screens = [
    const ScrapScreen(),
    const SearchScreen(),
    const HomeScreen(),
    const CategoryScreen(),
    const SettingScreen()
  ];

  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _screens[_selectedIndex]),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: primary,
            backgroundColor: Colors.white,
            onTap: (index) => _onItemTapped(index),
            currentIndex: _selectedIndex,
            showUnselectedLabels: true,
            selectedLabelStyle: CustomTextStyle.caption1.copyWith(color: primary),
            unselectedLabelStyle: CustomTextStyle.caption1.copyWith(color: Colors.black),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.assignment_outlined,
                  size: 24,
                  color: _selectedIndex == 0 ? primary : Colors.black,
                ),
                label: '스크랩',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_outlined,
                  size: 24,
                  color: _selectedIndex == 1 ? primary : Colors.black,
                ),
                label: '검색',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 24,
                  color: _selectedIndex == 2 ? primary : Colors.black,
                ),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category_outlined,
                  size: 24,
                  color: _selectedIndex == 3 ? primary : Colors.black,
                ),
                label: '카테고리',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                  size: 24,
                  color: _selectedIndex == 4 ? primary : Colors.black,
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