import 'package:flutter/material.dart';

enum ProfileMenu {
  contact('문의하기', Icons.help_outline),
  termsOfService('개인정보처리방침', Icons.privacy_tip_outlined),
  license('오픈소스 라이센스', Icons.article_outlined),
  logout('로그아웃', Icons.logout, textColor: Colors.red),
  withdraw('회원탈퇴', Icons.person_remove_outlined, textColor: Colors.grey);

  final String title;
  final IconData icon;
  final Color? textColor;

  const ProfileMenu(this.title, this.icon, {this.textColor});

  // 메뉴 그룹을 반환하는 메서드
  static List<List<ProfileMenu>> get groups => [
        [contact, termsOfService, license],
        [logout, withdraw]
      ];
}
