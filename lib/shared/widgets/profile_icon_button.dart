import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/shared/cubit/navigation_cubit.dart';

/// Reusable wrapper to navigate to Profile page when tapped.
class ProfileIconButton extends StatelessWidget {
  const ProfileIconButton({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<NavigationCubit>().navigateToProfile(context),
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
