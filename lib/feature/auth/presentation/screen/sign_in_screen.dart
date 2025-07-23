import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart' as apple;
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/feature/auth/presentation/controller/sign_in_controller.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/widgets/button/rounded_button.dart';
import 'package:viewith/di/app_providers.dart';

import '../../../../ui/gen/assets.gen.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      signInScreenControllerProvider,
      (previous, next) {
        if (next is AsyncData<void>) {
          context.goNamed(AppRoute.home.name);
        }

        if (next is AsyncError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('로그인 실패: ${next.error}')),
          );
        }
      },
    );

    return Scaffold(
      body: Padding(
        padding: AppDesign.spacing.horizontal8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(child: Assets.images.appLogo.image(width: 120, height: 120)),
            _buildTitle(),
            const Spacer(),
            _buildSignInWithAppleButton(ref),
            AppDesign.spacing.h12,
            _buildSignInWithKakaoButton(ref),
            AppDesign.spacing.h20,
            _buildStartWithUnauthorizedStatusButton(context, ref),
            AppDesign.spacing.h12
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text('viewith', style: AppDesign.typo.title1ExtraBold());
  }

  Widget _buildSignInWithAppleButton(WidgetRef ref) {
    return apple.SignInWithAppleButton(
      onPressed: () async {
        try {
          final credential = await apple.SignInWithApple.getAppleIDCredential(
            scopes: [
              apple.AppleIDAuthorizationScopes.email,
              apple.AppleIDAuthorizationScopes.fullName,
            ],
          );
          await ref.read(signInScreenControllerProvider.notifier).signInWithApple(
                idToken: credential.identityToken!,
                authorizationCode: credential.authorizationCode,
              );
        } catch (e) {
          // TODO: Handle error
          print('Apple sign in error: $e');
        }
      },
      style: apple.SignInWithAppleButtonStyle.black,
      height: 56,
      borderRadius: BorderRadius.circular(100),
    );
  }

  Widget _buildSignInWithKakaoButton(WidgetRef ref) {
    return RoundedButton(
      onTap: () async {
        await ref.read(signInScreenControllerProvider.notifier).signInWithKakao();
      },
      text: '카카오로 시작하기',
      backgroundColor: AppDesign.colors.kakao,
      image: Assets.images.kakao.svg(),
    );
  }

  Widget _buildStartWithUnauthorizedStatusButton(BuildContext context, WidgetRef ref) {
    return RoundedButton(
      onTap: () {
        ref.read(isGuestModeProvider.notifier).state = true;
        context.go(AppRoute.home.path);
      },
      text: '로그인 없이 시작하기',
    );
  }
}
