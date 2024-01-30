import 'package:bacteriofago/medic_icons_icons.dart';
import 'package:bacteriofago/medicine_list.dart';
import 'package:bacteriofago/medicine_notifications.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;
  final _pageViewController = PageController();

  List<Widget> _appBarActions = [];

  _setAppBarContent() {
    switch (_currentPageIndex) {
      case 0:
        setState(() {
          _appBarActions = MedicineList.appBarActions;
        });
        break;
      case 1:
        setState(() {
          _appBarActions = [];
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _setAppBarContent();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        title: const Text('Bacteriofago'),
        actions: _appBarActions,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) => {
          _pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceOut)
        },
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _currentPageIndex,
        destinations: const [
          NavigationDestination(
              icon: Icon(MedicIcons.clinic_medical), label: 'Medicamentos'),
          NavigationDestination(
              selectedIcon: Icon(Icons.notifications_active),
              icon: Icon(Icons.notifications_active_outlined),
              label: 'Recordatorios')
        ],
      ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
          _setAppBarContent();
        },
        controller: _pageViewController,
        children: <Widget>[
          const MedicineList(),
          MedicineNotifications(),
        ],
      ),
    );
  }
}
