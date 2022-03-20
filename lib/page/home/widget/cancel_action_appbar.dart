import 'package:flutter/material.dart';
import 'package:home_screen_codes/page/home/notifier/is_deleting_notifier.dart';
import 'package:provider/provider.dart';

class CancelActionAppbar extends StatelessWidget {
  const CancelActionAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<IsDeletingNotifier>(
        builder: (context, notifier, child) => Row(
          children: [
            InkWell(
              onTap: () => notifier.value = false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.check)),
          ],
        ),
      );
}
