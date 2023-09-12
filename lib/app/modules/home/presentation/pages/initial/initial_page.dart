import 'package:anime_app/app/ui/components/input.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Input(
            TextEditingController(),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Icon(Icons.search_rounded),
            ),
            hint: 'Insira o nome do anime',
          ),
        ],
      ),
    );
  }
}
