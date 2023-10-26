import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';

class Aloalo extends StatefulWidget {
  const Aloalo({super.key});

  @override
  State<Aloalo> createState() => AloaloState();
}

class AloaloState extends State<Aloalo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AvifImage.network(
          'https://objects.slimeread.com/be5cee8b-2d61-46de-a022-70775d0c56d1/85891680-3297-4c18-9b49-bffd4edf2b15/_2624_100_2.jpg.avif',
          // height: 200,
          fit: BoxFit.contain,
        ),
        // child: Image.network('https://objects.slimeread.com/be5cee8b-2d61-46de-a022-70775d0c56d1/85891680-3297-4c18-9b49-bffd4edf2b15/_2624_100_2.jpg.avif'),
      ),
    );
  }
}
