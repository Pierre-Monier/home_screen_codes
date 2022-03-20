import 'package:flutter/material.dart';
import 'package:home_screen_codes/page/home/notifier/is_deleting_notifier.dart';
import 'package:home_screen_codes/page/home/widget/cancel_action_appbar.dart';
import 'package:provider/provider.dart';

class HomeViewAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeViewAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        title: const Text('My codes'),
        actions: [
          Consumer<IsDeletingNotifier>(
            builder: (context, notifier, child) => notifier.value
                ? const Center(
                    child: CancelActionAppbar(),
                  )
                : IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      notifier.value = true;
                    },
                  ),
          ),
        ],
      );

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
