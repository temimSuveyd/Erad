// import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

Future<String?> custom_show_popupMenu(
  BuildContext context,
  Offset textFieldPosition,
  RenderBox textFieldBox,
  List<PopupMenuEntry<String>>? items,
) {
  return showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      textFieldPosition.dx,
      textFieldPosition.dy + textFieldBox.size.height,
      textFieldPosition.dx + textFieldBox.size.width,
      textFieldPosition.dy + textFieldBox.size.height + 200,
    ),
    constraints: BoxConstraints(
      maxWidth: textFieldBox.size.width,
      minWidth: textFieldBox.size.width,
    ),
    items: items!,
  );
}
