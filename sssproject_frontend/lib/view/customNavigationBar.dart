import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/view/homScreen.dart';
import 'package:sssproject_frontend/view/reportHelperScreen.dart';

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
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
      },
      
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: textGray.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, -4),
              ),
            ],
          ),
            child: Stack(
            children : [
              BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: textBlack,
              unselectedItemColor: textGray,
              onTap: (int index) {
                changeTab(index);
              },
              currentIndex: _index,
                items: _navItems.map((item) {
                  return BottomNavigationBarItem(
                    icon: Icon(
                      _index == item.index ? item.activeIcon : item.inactiveIcon,
                      size: 30,
                      weight: 1.0,
                    ),
                    label: item.label,
                  );
                }).toList(),
                showUnselectedLabels: true,
              ),
              Positioned(
                top: 0,
                left: MediaQuery.of(context).size.width / _navItems.length * _index + 12,
                child: Container(
                  width: 56,
                  height: 3,
                  decoration: BoxDecoration(
                    color: darkBlue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
      
        body: TabBarView(
          controller: _tabController,
          children: [
            const Center(child: Text('검색페이지'),),
            const Center(child: Text('권한설정'),),
            HomeScreen(changeTab: changeTab),
            const Center(child: Text('이미지 노이즈'),),
            const ReportHelperScreen(),
          ],
        ),
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
    activeIcon: Icons.policy_outlined,
    inactiveIcon: Icons.policy_outlined,
    label: '검색',
  ),
  NavItem(
    index: 1,
    activeIcon: Icons.lock_outline,
    inactiveIcon: Icons.lock_outline,
    label: '권한설정',
  ),
  NavItem(
    index: 2,
    activeIcon: Icons.home_outlined,
    inactiveIcon: Icons.home_outlined,
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
    activeIcon: Icons.warning_amber,
    inactiveIcon: Icons.warning_amber,
    label: '신고',
  ),
];