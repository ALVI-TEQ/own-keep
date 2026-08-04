import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../providers/vault_provider.dart';
import '../components/ownkeep_components.dart';
import '../components/ownkeep_dashboard_components.dart';
import '../../theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';

class HomeDashboardScreen extends ConsumerStatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  ConsumerState<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends ConsumerState<HomeDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleScan(BuildContext context) async {
    final picker = ImagePicker();
    try {
      final file = await picker.pickImage(source: ImageSource.camera);
      if (file != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Document scanned successfully!')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Camera error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Ensure the vault is unlocked before displaying the dashboard
    final vault = ref.watch(unlockedVaultProvider);
    if (vault == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/splash');
      });
      return Scaffold(backgroundColor: Theme.of(context).scaffoldBackgroundColor);
    }
    
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(OwnKeepSpacing.md),
          children: [
            // Header
            SizedBox(height: OwnKeepSpacing.md),
            Text(
              'Good evening, Arjun 👋',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: OwnKeepSpacing.xs),
            Text(
              'Everything important is safe and organized',
              style: TextStyle(
                color: OwnKeepColors.textSecondary,
                fontSize: 14,
              ),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            
            // Search
            const OwnKeepSearchField(placeholder: 'Search anything...'),
            SizedBox(height: OwnKeepSpacing.xl),
            
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OwnKeepActionTile(
                  icon: Icons.document_scanner,
                  label: 'Scan',
                  color: OwnKeepColors.primaryBlue,
                  onTap: () => _handleScan(context),
                ),
                OwnKeepActionTile(
                  icon: Icons.add,
                  label: 'Add New',
                  color: OwnKeepColors.accentGreen,
                  onTap: () => context.push('/features/add-item-menu'),
                ),
                OwnKeepActionTile(
                  icon: Icons.auto_awesome,
                  label: 'AI Assistant',
                  color: OwnKeepColors.primaryPurple,
                  onTap: () => context.push('/features/ai-organize'),
                ),
                OwnKeepActionTile(
                  icon: Icons.note_add,
                  label: 'Quick Note',
                  color: OwnKeepColors.accentOrange,
                  onTap: () => context.push('/features/add-notes'),
                ),
              ],
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            
            // Recent Items Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Items', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => context.go('/dashboard/recent'),
                  child: Text('View all', style: TextStyle(color: OwnKeepColors.primaryBlue)),
                ),
              ],
            ),
            SizedBox(height: OwnKeepSpacing.sm),
            
            // Recent Items List
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  OwnKeepRecentCard(
                    type: 'PDF',
                    typeColor: OwnKeepColors.accentRed,
                    title: 'Passport',
                    subtitle: 'Today, 10:30 AM',
                    onTap: () {},
                  ),
                  OwnKeepRecentCard(
                    type: 'DOC',
                    typeColor: OwnKeepColors.primaryBlue,
                    title: 'Insurance Policy',
                    subtitle: 'Yesterday',
                    onTap: () {},
                  ),
                  OwnKeepRecentCard(
                    type: 'ID',
                    typeColor: OwnKeepColors.accentGreen,
                    title: 'Driving Licence',
                    subtitle: '2 days ago',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            
            // Smart Collections Header
            Text('Smart Collections', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: OwnKeepSpacing.md),
            
            // Smart Collections Grid
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: OwnKeepSpacing.sm,
              mainAxisSpacing: OwnKeepSpacing.sm,
              childAspectRatio: 0.75,
              children: [
                OwnKeepSmartCollectionCard(
                  icon: Icons.circle,
                  iconColor: OwnKeepColors.primaryBlue,
                  label: 'Personal',
                  count: '28',
                  onTap: () {},
                ),
                OwnKeepSmartCollectionCard(
                  icon: Icons.square,
                  iconColor: OwnKeepColors.accentGreen,
                  label: 'Finance',
                  count: '16',
                  onTap: () {},
                ),
                OwnKeepSmartCollectionCard(
                  icon: Icons.favorite,
                  iconColor: OwnKeepColors.accentRed,
                  label: 'Health',
                  count: '12',
                  onTap: () {},
                ),
                OwnKeepSmartCollectionCard(
                  icon: Icons.home,
                  iconColor: OwnKeepColors.accentOrange,
                  label: 'Property',
                  count: '9',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            
            // Today's Reminder
            OwnKeepCard(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: OwnKeepColors.primaryBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.calendar_month, color: OwnKeepColors.primaryBlue),
                  ),
                  SizedBox(width: OwnKeepSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Today\'s Reminder', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text('Vehicle insurance expires in 15 days', style: TextStyle(color: OwnKeepColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: OwnKeepColors.textSecondary),
                ],
              ),
            ),
            SizedBox(height: OwnKeepSpacing.xl),
            
            // Storage Overview
            const OwnKeepStorageBar(
              percentage: 0.24,
              labelText: '2.4 GB of 10 GB used',
            ),
            SizedBox(height: 100), // Padding for floating nav bar
          ],
        ),
      ),
    );
  }
}
