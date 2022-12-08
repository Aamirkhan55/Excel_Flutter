import 'package:excelflutter_app/screen/excel_screen.dart';
import 'package:flutter/material.dart';

import 'data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _changePage(index);
              },
              children: const [
                ExcelScreen(),
                DataScreen(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  void _changePage (int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  BottomNavigationBar bottomNavBar () {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: "Excel File",
          icon: IconButton(
              onPressed: () {
                setState(() {
                  createExcel();
                });
              },
              icon:const Icon(Icons.file_copy_outlined)),
        ),
        const  BottomNavigationBarItem(
          label: 'Data File',
          icon:Icon(Icons.list_alt))
      ],
      currentIndex: selectedIndex,
      backgroundColor: Colors.blue,
      selectedItemColor: Colors.white,
      onTap: _onBottomNavBarItemTapped,
    );
  }

  void _onBottomNavBarItemTapped (int index) {
    setState(() {
      selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }
}
