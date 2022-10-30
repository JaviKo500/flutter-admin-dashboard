import 'package:flutter/material.dart';


class BackgroundTwitter extends StatelessWidget {
  const BackgroundTwitter ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildDecoration(),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Image(
              image: AssetImage('twitter-white-logo.png'),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() => const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('twitter-bg.png'),
      fit: BoxFit.cover
    )
  );
}


class GetBackground extends StatelessWidget {

const GetBackground({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    return ( size.width > 1000) ? const Expanded(child: BackgroundTwitter()) : const BackgroundTwitter();
  }
}

