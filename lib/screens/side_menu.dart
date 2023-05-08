import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/local/auth_service.dart';
import 'package:notes_app/screens/login.dart';

import 'notification_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      height: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
          ),
          const ProfileCard(),
          SizedBox(
            height: 20,
          ),
          SideMenuTile(
            title: "Medical record",
            svg: Icon(
              Icons.history_edu,
              color: Colors.white,
            ),
            press: () {},
          ),
          SideMenuTile(
            title: "Notification",
            svg: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationScreen()));
            },
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            onTap: () {
              AuthService.instance.logout();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
            minLeadingWidth: 5,
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).cardColor,
            ),
            title: Text(
              "Logout",
              style: TextStyle(color: Theme.of(context).cardColor),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: Theme.of(context).cardColor,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.error,
              backgroundImage: AssetImage(
                "assets/Icons/1024.png",
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Patient",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          Text(
            "patient@gmail.com",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
          SizedBox(
            width: 250,
            child: Divider(
              thickness: 0.8,
              color: Theme.of(context).cardColor,
            ),
          )
        ],
      ),
    );
  }
}

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.svg,
    required this.title,
    required this.press,
  });

  final Widget svg;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Theme.of(context).colorScheme.secondary,
      splashColor: Theme.of(context).colorScheme.secondary,
      minLeadingWidth: 5,
      autofocus: true,
      onTap: press,
      leading: SizedBox(
        height: 26,
        width: 26,
        child: svg,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.email,
  });
  final String name, email;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(CupertinoIcons.person, color: Theme.of(context).cardColor),
      ),
      title: Text(
        name,
        style: TextStyle(color: Theme.of(context).cardColor),
      ),
      subtitle: Text(
        email,
        style: TextStyle(color: Theme.of(context).cardColor),
      ),
    );
  }
}
