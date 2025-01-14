// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields, unused_element, prefer_const_constructors_in_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gluco/services/api.dart';
import 'package:gluco/styles/customcolors.dart';
import 'package:gluco/views/historyvo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gluco/extensions/buildcontext/loc.dart';

class SideBar extends StatefulWidget {
  SideBar();

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final String _url = 'http://egluco.bio.br/';

  void _launchURL() async {
    if (!await launch(_url, forceWebView: false)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            // decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            decoration: BoxDecoration(
              color: CustomColors.blueGreen.withOpacity(0.25),
            ),
            child: Image(
              image: AssetImage('assets/images/logoblue.png'),
            ),
            // child: Text(
            //   'E-Gluco',
            //   style: Theme.of(context).textTheme.headline6,
            // ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              context.loc.my_profile,
              style: Theme.of(context).textTheme.headline6,
            ),
            onTap: () async {
              await Navigator.popAndPushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.watch_outlined),
            title: Text(
              context.loc.devices,
              style: Theme.of(context).textTheme.headline6,
            ),
            onTap: () async {
              await Navigator.popAndPushNamed(context, '/devices');
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.developer_mode),
          //   title: Text(
          //     'Dev',
          //     style: Theme.of(context).textTheme.headline6,
          //   ),
          //   onTap: () async {
          //     await Navigator.popAndPushNamed(context, '/teste');
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(
              context.loc.about_us,
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: Icon(Icons.open_in_new),
            onTap: () {
              _launchURL();
              Navigator.pop(context);
            },
          ),
          Visibility(
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                context.loc.log_out,
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () async {
                HistoryVO.disposeHistory();
                await API.instance.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
            ),
            visible: true,
          ),
        ],
      ),
    );
  }
}
