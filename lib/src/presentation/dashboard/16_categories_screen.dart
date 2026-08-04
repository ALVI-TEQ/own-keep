import 'package:flutter/material.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/app_theme.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navCategories)),
      body: ListView(
        padding: EdgeInsets.all(OwnKeepSpacing.md),
        children: [
          const ListTile(
            leading: Icon(Icons.description),
            title: Text('Documents'),
            trailing: Text('42'),
          ),
          const ListTile(
            leading: Icon(Icons.image),
            title: Text('Images'),
            trailing: Text('120'),
          ),
          const ListTile(
            leading: Icon(Icons.video_file),
            title: Text('Videos'),
            trailing: Text('5'),
          ),
          const ListTile(
            leading: Icon(Icons.audiotrack),
            title: Text('Audio'),
            trailing: Text('2'),
          ),
        ],
      ),
    );
  }
}
