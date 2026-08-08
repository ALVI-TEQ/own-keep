import 'package:flutter/material.dart';
import '../components/ownkeep_components.dart';

class ComponentGalleryScreen extends StatelessWidget {
  const ComponentGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnKeepAppScaffold(
      title: 'Component Gallery',
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          OwnKeepCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Buttons', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 16),
                OwnKeepPrimaryButton(label: 'Primary Button', onPressed: () {}),
              ],
            ),
          ),
          OwnKeepCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cards', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 16),
                Text('This is inside an OwnKeepCard.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
