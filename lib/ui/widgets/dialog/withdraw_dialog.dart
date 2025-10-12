import 'package:flutter/material.dart';
import 'package:viewith/ui/app_design.dart';

void showWithdrawDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            '정말 탈퇴하시겠어요?',
            style: AppDesign.typo.title2bold(color: AppDesign.colors.gray900),
          ),
        ),
        content: Text(
          '탈퇴 후 정보는 복구할 수 없어요.\n정말로 탈퇴하시겠습니까?',
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
              '삭제',
              style: AppDesign.typo.body1SemiBold(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
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
