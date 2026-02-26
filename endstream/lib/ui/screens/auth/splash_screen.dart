import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/auth/auth_cubit.dart';
import '../../background/static_tree_background.dart';
import 'splash_branch_animation.dart';
import 'splash_logo_node.dart';

/// Splash screen with branch growth animation and auth state navigation.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..forward();

    // Check session after a short delay to allow animation to start.
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<AuthCubit>().checkSession();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go('/hub');
        } else if (state is Unauthenticated || state is AuthError) {
          context.go('/login');
        }
      },
      child: Scaffold(
        backgroundColor: TreeColors.background,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const StaticTreeBackground(),
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SplashBranchAnimation(progress: _controller.value),
                      const SizedBox(height: 24),
                      SplashLogoNode(progress: _controller.value),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
