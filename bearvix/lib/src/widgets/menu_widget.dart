import 'package:bearvix/src/pages/pagesPrefer/home_page.dart';
import 'package:bearvix/src/pages/pagesPrefer/settings_page.dart';
import 'package:flutter/material.dart';


class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('..//assets/menu-img.jpg'),
              fit: BoxFit.cover
              )
          ),
          child: Container(),
          ),

          ListTile(
            leading: const Icon(Icons.pages, color: Colors.blue),
            title: const Text('Home'),
            onTap: ()=>Navigator.pushReplacementNamed(context, HomePage.routeName),
          ),
           ListTile(
            leading: const Icon(Icons.party_mode, color: Colors.blue),
            title: const Text('Party Mode'),
            onTap: (){},
          ),
           ListTile(
            leading: const Icon(Icons.people, color: Colors.blue),
            title: const Text('People'),
            onTap: (){},
          ),
           ListTile(
            leading: const Icon(Icons.settings, color: Colors.blue),
            title: const Text('Settings'),
            onTap: (){ 
              // Navigator.pop(context);
              Navigator.pushReplacementNamed(context, SettingsPage.routeName,);
            }

          )
      ],
    ),
   );
  }
}