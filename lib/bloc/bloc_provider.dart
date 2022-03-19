import 'package:flutter/material.dart';

import 'package:home_screen_codes/bloc/bloc_base.dart';

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    required Key key,
    required this.child,
    required this.blocs,
  }) : super(key: key) {
    _masterKey = key as GlobalKey;
  }

  final Widget child;
  final List<T> blocs;

  @override
  _BlocProviderState createState() => _BlocProviderState();

  static T of<T extends BlocBase?>(BuildContext context) {
    _BlocProviderInherited? provider = context
        .getElementForInheritedWidgetOfExactType<_BlocProviderInherited>()
        ?.widget as _BlocProviderInherited?;
    return provider!.blocs.firstWhere((x) => x is T) as T;
  }

  static T master<T extends BlocBase>() =>
      (_masterKey.currentWidget! as BlocProvider)
          .blocs
          .firstWhere((x) => x is T) as T;

  static late GlobalKey _masterKey;
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  void initState() {
    super.initState();
    for (final bloc in widget.blocs) {
      bloc.initState();
    }
  }

  @override
  void dispose() {
    for (final bloc in widget.blocs) {
      bloc.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _BlocProviderInherited(
        blocs: widget.blocs,
        child: widget.child,
      );
}

class _BlocProviderInherited extends InheritedWidget {
  const _BlocProviderInherited({
    Key? key,
    required Widget child,
    required this.blocs,
  }) : super(key: key, child: child);

  final List<BlocBase> blocs;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
