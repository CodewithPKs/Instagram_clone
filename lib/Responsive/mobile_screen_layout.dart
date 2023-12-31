import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Providers/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../utils/globle_veriables.dart';

class mobileScreenLayout extends StatefulWidget {
  const mobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<mobileScreenLayout> createState() => _mobileScreenLayoutState();
}

class _mobileScreenLayoutState extends State<mobileScreenLayout> {

  int _page = 0;
  late PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped (int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
              color: _page==0? primaryColor: secondaryColor,),
            label: '',
            backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                color: _page==1? primaryColor: secondaryColor,),
              label: '',
              backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,
                color: _page==2? primaryColor: secondaryColor,),
              label: '',
              backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                color: _page==3? primaryColor: secondaryColor,),
              label: '',
              backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                color: _page==4? primaryColor: secondaryColor,),
              label: '',
              backgroundColor: primaryColor
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
