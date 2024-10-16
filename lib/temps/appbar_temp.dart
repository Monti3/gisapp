import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarTemp extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTemp(
    this.context,
    this.title, {
    super.key,
  });
  final BuildContext context;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
