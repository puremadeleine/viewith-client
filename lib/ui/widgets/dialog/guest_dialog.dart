import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/di/app_providers.dart';
import 'package:viewith/ui/app_design.dart';

void showGuestDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            '회원만 이용 가능한 서비스에요',
            style: AppDesign.typo.title2bold(color: AppDesign.colors.gray900),
          ),
        ),
        content: Text(
          '로그인이 필요한 서비스에요.\n지금 바로 로그인하여 서비스를 즐겨보세요.',
          style: AppDesign.typo.body1(color: AppDesign.colors.gray900),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          TextButton(
            child: Text(
              '취소',
              style: AppDesign.typo.body1(color: AppDesign.colors.gray600),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              '로그인 하러 가기',
              style: AppDesign.typo.body1SemiBold(color: AppDesign.colors.gray900),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(isGuestModeProvider.notifier).state = false;
              context.go(AppRoute.signIn.path);
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: AppDesign.colors.white,
      );
    },
  );
} 