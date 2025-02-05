import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  final RestorableInt tabIndex = RestorableInt(0);
  final List<String> petNeeds = [
    "needs to go to the bathroom",
    "is thirsty",
    "is hungry",
    "needs to go on a walk",
    "needs a shower",
    "needs to be pet",
    "is sleepy",
  ];
  final Random random = Random();

  String getRandomNeed() {
    return petNeeds[random.nextInt(petNeeds.length)];
  }

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pets = [
      {"name": "Dog", "description": "A loyal and friendly companion."},
      {"name": "Cat", "description": "An independent and curious pet."},
      {"name": "Hamster", "description": "A small, adorable, and active critter."},
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Pet Care Tabs'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final pet in pets) Tab(text: pet['name']),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final pet in pets)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pet['name']!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    pet['description']!,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${pet['name']} ${getRandomNeed()}!",
                    style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
