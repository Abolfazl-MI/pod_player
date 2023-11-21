import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/app/config/router/route_names.dart';

class DrawerOption {
  final String title;
  final IconData iconData;

  DrawerOption({required this.title, required this.iconData});
}

List<DrawerOption> drawerOptions = [
  DrawerOption(title: 'Home', iconData: CupertinoIcons.house),
  DrawerOption(title: 'Episods', iconData: Icons.podcasts),
  DrawerOption(title: 'Subscriptions', iconData: Icons.category_outlined),
  DrawerOption(title: 'Settings', iconData: CupertinoIcons.settings),
];

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key, required this.drawerKey}) : super(key: key);
  final GlobalKey<ScaffoldState> drawerKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView(
          padding: EdgeInsets.zero,
          children: drawerOptions
              .map((e) => InkWell(
                    onTap: () {
                      String titleTaped = e.title;
                      String routeName = '';
                      switch (titleTaped) {
                        case 'Subscriptions':
                          routeName = RouteNames.sub;
                        case 'Home':
                          routeName = RouteNames.home;
                        default:
                          'Home';
                      }
                      drawerKey.currentState?.openEndDrawer();
                      Navigator.pushNamed(context, routeName);
                    },
                    child: ListTile(
                      title: Text(e.title),
                      leading: Icon(e.iconData),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
