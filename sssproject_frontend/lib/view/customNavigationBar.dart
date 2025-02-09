import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/view/homScreen.dart';

class customNavigationBar extends StatefulWidget {
  const customNavigationBar({super.key});

  @override
  State<customNavigationBar> createState() => _customNavigationBarState();
}

class _customNavigationBarState extends State<customNavigationBar> with TickerProviderStateMixin{
  late TabController _tabController;
  int _index = 2 ;

  @override
  void initState() {
  super.initState();

  _tabController = TabController(length: _navItems.length, vsync: this, initialIndex: _index);
  _tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      _index = _tabController.index;
    });
  }

  void changeTab(int index) {
    _tabController.animateTo(index);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: textBlack,
        unselectedItemColor: textBlack,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold,),
        onTap: (int index) {
          changeTab(index);
        },
        currentIndex: _index,
          items: _navItems.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(
                _index == item.index ? item.activeIcon : item.inactiveIcon,
              ),
              label: item.label,
            );
          }).toList(),
          showUnselectedLabels: true,
        ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          const Center(child: Text('검색페이지'),),
          const Center(child: Text('권한설정'),),
          HomeScreen(changeTab: changeTab),
          const Center(child: Text('이미지 노이즈'),),
          const Center(child: Text('신고'),)
        ],
      ),
    );
  }
}

class NavItem {
  final int index;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
 
  const NavItem({
    required this.index,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}

const _navItems = [
  NavItem(
    index: 0,
    activeIcon: Icons.policy,
    inactiveIcon: Icons.policy,
    label: '검색',
  ),
  NavItem(
    index: 1,
    activeIcon: Icons.lock,
    inactiveIcon: Icons.lock,
    label: '권한설정',
  ),
  NavItem(
    index: 2,
    activeIcon: Icons.home,
    inactiveIcon: Icons.home,
    label: '홈',
  ),
  NavItem(
    index: 3,
    activeIcon: Icons.crop_free,
    inactiveIcon: Icons.crop_free,
    label: '노이즈 추가',
  ),
    NavItem(
    index: 4,
    activeIcon: Icons.warning,
    inactiveIcon: Icons.warning,
    label: '신고',
  ),
];