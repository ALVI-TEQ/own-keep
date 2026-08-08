import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/subscription/feature_entitlements.dart';

const _testProEntitlementKey = 'ownkeep_test_pro_entitlement';

class OwnKeepPlanNotifier extends Notifier<OwnKeepPlan> {
  OwnKeepPlanNotifier({this.initialPlan = OwnKeepPlan.free});

  final OwnKeepPlan initialPlan;

  @override
  OwnKeepPlan build() => initialPlan;

  Future<OwnKeepPlan> currentPlan() async {
    final preferences = await SharedPreferences.getInstance();
    final plan = preferences.getBool(_testProEntitlementKey) == true
        ? OwnKeepPlan.pro
        : OwnKeepPlan.free;
    state = plan;
    return plan;
  }

  Future<void> enableTestPro() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_testProEntitlementKey, true);
    state = OwnKeepPlan.pro;
  }

  Future<void> resetTestPurchase() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_testProEntitlementKey);
    state = OwnKeepPlan.free;
  }
}

final ownKeepPlanProvider = NotifierProvider<OwnKeepPlanNotifier, OwnKeepPlan>(
  OwnKeepPlanNotifier.new,
);
