import 'package:easy_lib/service/provider/page_change_provider.dart';
import 'package:easy_lib/service/provider/provider_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/nested_tab.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({Key? key}) : super(key: key);

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageChangeProvider pprov=ProviderManager.pageChangeProvider;
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: ClipOval(
              child: Container(
                height: 30,
                width: 32,
                color: Colors.indigo, // 设置背景色为红色
                child: const Icon(
                  CupertinoIcons.bag_fill,
                  size: 20, // 设置图标大小
                  color: Colors.white, // 设置图标颜色
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: (){},
              icon: const Icon(
                Icons.add,
                size: 30,
                weight: 2.0,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: (){},
              icon: const Icon(
                Icons.search,
                size: 27,
                weight: 2.0,
                color: Colors.white,
              ),
            ),
          ],
          title: Selector<PageChangeProvider, int>(
            selector: (context, provider) => provider.currentIndex,
            builder: (context, currentIndex, child)=>Text(
                pprov.nowPageName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
            ),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(), // 禁止滑动
          children: <Widget>[
              Center(child: Text('Home')),
              Center(child: Text('Files')),
              NestedTabBar('Shared'),
              Center(child: Text('Profile')),
            ],
        ),
        bottomNavigationBar: Container(
          constraints: const BoxConstraints(maxHeight: 65),
          padding: const EdgeInsets.only(top: 0),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.black12, width: 0.7), // 设置顶部边框
            ),
          ),
          child: TabBar(
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            dividerHeight: 0,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
            onTap: (index) {
              pprov.updateIndex(index);
            },
            tabs: <Widget>[
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 3),
                text: 'Home',
                icon: Selector<PageChangeProvider, bool>(
                  selector: (context, provider) => provider.currentIndex==0,
                  builder: (context, selec, child) => selec?const Icon(Icons.home,size: 29):const Icon(Icons.home_outlined,size: 29),
                ),
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 3),
                text: 'BookShelf',
                icon: Selector<PageChangeProvider, bool>(
                  selector: (context, provider) => provider.currentIndex==1,
                  builder: (context, selec, child) => selec?const Icon(CupertinoIcons.folder_fill,):const Icon(CupertinoIcons.folder),
                ),
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 3),
                text: 'Shared',
                icon: Selector<PageChangeProvider, bool>(
                  selector: (context, provider) => provider.currentIndex==2,
                  builder: (context, selec, child) => selec?const Icon(CupertinoIcons.person_2_fill,size: 27):const Icon(CupertinoIcons.person_2,size: 27),
                ),
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 3),
                text: 'Profile',
                icon: Selector<PageChangeProvider, bool>(
                  selector: (context, provider) => provider.currentIndex==3,
                  builder: (context, selec, child) => selec?const Icon(CupertinoIcons.person_fill):const Icon(CupertinoIcons.person),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}