import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';

class NavigationMenuDrawer extends StatelessWidget {
  const NavigationMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.shield, size: 48, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  l10n.appTitle,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(l10n.navHome),
            onTap: () => context.go('/dashboard/home'),
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text(l10n.navAllFiles),
            onTap: () => context.go('/dashboard/all-files'),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text(l10n.navCategories),
            onTap: () => context.go('/dashboard/categories'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
