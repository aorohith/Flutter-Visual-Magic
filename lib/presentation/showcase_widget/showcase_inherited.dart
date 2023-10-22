import 'package:flutter/material.dart';

class KeysToBeInherited extends InheritedWidget {
  final GlobalKey key1;
  final GlobalKey key2;
  final GlobalKey key3;
  final GlobalKey key4;
  // final GlobalKey key5;

  const KeysToBeInherited({
    super.key,
    required Widget child,
    required this.key1,
    required this.key2,
    required this.key3,
    required this.key4,
    // required this.key5,
  }) : super(child: child);

  static KeysToBeInherited of(BuildContext context) {
    final KeysToBeInherited? result =
        context.dependOnInheritedWidgetOfExactType<KeysToBeInherited>();
    assert(result != null);
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
