import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final IconData TrailingIcon;
  final Function onAction;

  const DrawerItemWidget(
      {Key? key,
      required this.onAction,
      required this.title,
      required this.leadingIcon,
      required this.TrailingIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      leading: Icon(
        leadingIcon,
        color: Theme.of(context).primaryColor,
      ),
      trailing: Icon(TrailingIcon, color: Theme.of(context).primaryColor),
      onTap: () => onAction(),
    );
  }
}
