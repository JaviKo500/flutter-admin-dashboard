import 'package:flutter/material.dart';


class NavbarAvatar extends StatelessWidget {
  const NavbarAvatar ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: 30,
        height: 30,
        child: Image.network('https://w0.peakpx.com/wallpaper/346/324/HD-wallpaper-goku-black-dragin-ball.jpg', fit: BoxFit.cover,)
      ),
    );
  }
}