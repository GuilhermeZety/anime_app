import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/ui/components/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Input(
            controller,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Icon(Icons.search_rounded),
            ),
            onSubmit: (_) => Modular.to.pushNamed('/search/', arguments: controller),
            hint: 'Insira o nome do anime',
          ).hero('search'),
        ],
      ),
    );
  }
}
