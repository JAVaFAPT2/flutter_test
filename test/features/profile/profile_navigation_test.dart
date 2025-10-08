import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vietnamese_fish_sauce_app/core/domain/entities/user.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/presentation/widgets/profile_overview.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/profile_icon_button.dart';
import 'package:vietnamese_fish_sauce_app/shared/cubit/navigation_cubit.dart';

class _SpyNavCubit extends NavigationCubit {
  bool called = false;
  @override
  void navigateToProfile(BuildContext context) {
    called = true;
    super.navigateToProfile(context);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ProfileOverview renders user info (override)', (tester) async {
    const user = User(
      id: 'u1',
      phone: '0900000000',
      fullName: 'Tester',
      email: 'tester@example.com',
      address: 'HCM',
      createdAt: null,
    );
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileOverview(userOverride: user),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tester'), findsOneWidget);
    expect(find.text('tester@example.com'), findsOneWidget);
  });

  testWidgets('ProfileIconButton calls NavigationCubit.navigateToProfile',
      (tester) async {
    final spy = _SpyNavCubit();
    await tester.pumpWidget(
      BlocProvider<NavigationCubit>.value(
        value: spy,
        child: const MaterialApp(
          home: Scaffold(
            body: ProfileIconButton(
              child: SizedBox(width: 50, height: 50),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ProfileIconButton));
    await tester.pump();

    expect(spy.called, isTrue);
  });
}
