import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:innovatika/pages/device_setup.dart';

AppBar commonApp({
  required BuildContext context,
  GlobalKey? key,
  String? title,
  Widget? widget,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    // leading: const Text("Compu Rf"),
    title: Navigator.canPop(context) && title == null
        ? null
        : Text(
            title != null && title.isNotEmpty ? title : "InnoVatika",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
    leading: Navigator.canPop(context)
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
            ),
          )
        : null,
    actions: Navigator.canPop(context)
        ? null
        : [
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DeviceSetup(),
                  ),
                );
              },
              label: const Text("Add a Device"),
              icon: const Icon(Iconsax.add),
            )
          ],
  );
}
