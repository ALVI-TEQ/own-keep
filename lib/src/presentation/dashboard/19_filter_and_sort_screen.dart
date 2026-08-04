import 'package:flutter/material.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../components/ownkeep_components.dart';

class FilterAndSortScreen extends StatelessWidget {
  const FilterAndSortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(title: Text(l10n.filterAndSort)),
      body: ListView(
        padding: EdgeInsets.all(OwnKeepSpacing.md),
        children: [
          Text('Sort By', style: Theme.of(context).textTheme.titleMedium),
          RadioListTile(
            title: Text('Name (A-Z)'),
            value: 1,
            groupValue: 1,
            onChanged: (val) {},
          ),
          RadioListTile(
            title: Text('Date Added (Newest)'),
            value: 2,
            groupValue: 1,
            onChanged: (val) {},
          ),
          const Divider(),
          Text('Filter By Type', style: Theme.of(context).textTheme.titleMedium),
          CheckboxListTile(
            title: Text('PDFs'),
            value: true,
            onChanged: (val) {},
          ),
          CheckboxListTile(
            title: Text('Images'),
            value: false,
            onChanged: (val) {},
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          OwnKeepPrimaryButton(
            label: 'Apply Filters',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
