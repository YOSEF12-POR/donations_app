// import 'package:donations_app/modules/cases_de/cases_de.dart';
// import 'package:donations_app/modules/favorites/favorites_screen.dart';
// import 'package:donations_app/modules/settings/settings_screen.dart';
// import 'package:donations_app/shared/components/componets.dart';
// import 'package:flutter/material.dart';


// class AppDrawer extends StatelessWidget {
//   const AppDrawer({Key? key}) : super(key: key);

//   Widget buildListTile(String title, IconData icon, link) {
//     return ListTile(
//       leading: Icon(icon, size: 30, color: Colors.orangeAccent),
//       title: Text(
//         title,
//         style: TextStyle(
//             fontFamily: 'Jannah', fontSize: 25, fontWeight: FontWeight.bold),
//       ),
//       onTap: link,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           Container(
//             height: 100,
//             width: double.infinity,
//             padding: EdgeInsets.only(top: 40),
//             alignment: Alignment.center,
//             color: Theme.of(context).accentColor,
//             child: Text(
//               'جسور الخير',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           buildListTile('Favorites', Icons.card_travel, () {
//            navigateTo(context, CasesDe());
//           }),


//           // buildListTile('تواصل', Icons.email, () {
//           //   Navigator.of(context)
//           //       .pushReplacementNamed(CounctionPage.screenRoute);
//           // }),
//           // buildListTile('تبرع', Icons.volunteer_activism, () {
//           //   Navigator.of(context)
//           //       .pushReplacementNamed(Donate_NowPage.screenRoute);

//           // }),
//           // buildListTile('من نحن', Icons.not_listed_location_outlined, () {
//           //   Navigator.of(context)
//           //       .pushReplacementNamed(About_As.screenRoute);

//           // }),

//         ],
//       ),
//     );
//   }
// }
