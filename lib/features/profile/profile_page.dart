import 'package:bolso_organizado/commons/constants/keys.dart';
import 'package:bolso_organizado/commons/constants/named_routes.dart';
import 'package:bolso_organizado/services/auth_service.dart';
import 'package:bolso_organizado/services/secure_storage.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Perfil"),
            TextButton(
              key: Keys.profilePagelogoutButton,
              onPressed: () async {
                await locator.get<AuthService>().signOut();
                await const SecureStorageService().deleteAll();
                if (mounted) {
                  Navigator.pushReplacementNamed(context, NamedRoute.INITIAL);
                }
              },
              child: const Text("Sair"),
            )
          ],
        ),
      ),
    );
  }
}
