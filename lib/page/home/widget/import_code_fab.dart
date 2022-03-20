import 'package:flutter/material.dart';
import 'package:home_screen_codes/page/home/notifier/import_fab_should_extended_notifier.dart';
import 'package:home_screen_codes/page/home/widget/source_picker_dialog.dart';
import 'package:provider/provider.dart';

class ImportCodeFab extends StatelessWidget {
  const ImportCodeFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Consumer<ImportFabShouldExtendedNotifier>(
        builder: (context, notifier, child) => FloatingActionButton.extended(
          label: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                child: child,
              ),
            ),
            child: notifier.value
                ? Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 4.0),
                        child: Icon(Icons.qr_code),
                      ),
                      Text('Import a code')
                    ],
                  )
                : const Icon(Icons.qr_code),
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => const SourcePickerDialog(),
          ),
          tooltip: 'Import a code',
          // icon: const Icon(Icons.qr_code_sharp),
        ),
      );
}
