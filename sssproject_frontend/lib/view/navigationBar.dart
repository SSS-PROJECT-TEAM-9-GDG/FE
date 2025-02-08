import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/custom_icons_icons.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> with TickerProviderStateMixin{
  late TabController _tabController;
  int _index = 0 ;

  @override
  void initState() {
  super.initState();

  _tabController = TabController(length: _navItems.length, vsync: this);
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
  
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          _tabController.animateTo(index);
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
        ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          // HomePage(),
          // SchedulePage(),
          // Center(child: Text('채팅')),
          // Center(child: Text('My')),
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
    activeIcon: CustomIcons.shieldSearch,
    inactiveIcon: CustomIcons.shieldSearch,
    label: '검색',
  ),
  NavItem(
    index: 1,
    activeIcon: CustomIcons.unlock,
    inactiveIcon: CustomIcons.unlock,
    label: '권한설정',
  ),
  NavItem(
    index: 2,
    activeIcon: CustomIcons.home,
    inactiveIcon: CustomIcons.home,
    label: '홈',
  ),
  NavItem(
    index: 3,
    activeIcon: CustomIcons.scanBarcode,
    inactiveIcon: CustomIcons.scanBarcode,
    label: '노이즈 추가',
  ),
    NavItem(
    index: 4,
    activeIcon: CustomIcons.alarm,
    inactiveIcon: CustomIcons.alarm,
    label: '신고',
  ),
];