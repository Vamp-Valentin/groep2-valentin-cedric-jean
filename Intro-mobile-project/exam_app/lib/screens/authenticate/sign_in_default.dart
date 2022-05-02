import 'package:exam_app/screens/authenticate/register.dart';
import 'package:exam_app/screens/authenticate/sign_in_admin.dart';
import 'package:exam_app/screens/authenticate/sign_in_student.dart';
import 'package:flutter/material.dart';

//Store this globally
final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class defaultLoginPage extends StatefulWidget {
  defaultLoginPage({Key? key}) : super(key: key);

  @override
  State<defaultLoginPage> createState() => _defaultLoginPageState();
}

class _defaultLoginPageState extends State<defaultLoginPage> with SingleTickerProviderStateMixin{
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text('Student'),
            ),
            Tab(
              child: Text('Admin'),
            ),
          ],
        ),
      ),
      body: Navigator(
        key: _navKey,
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => TabBarView(
            controller: _tabController,
            children: [
              SignInStudent(),
              SignInAdmin(),
            ],
          ),
        ),
      ),
    );
  }
}