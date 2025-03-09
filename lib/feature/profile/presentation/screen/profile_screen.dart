import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/feature/profile/presentation/model/profile_enum.dart';
import 'package:viewith/ui/app_design.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          '내 프로필',
          style: AppDesign.typo.title2bold(color: AppDesign.colors.gray50),
        )),
        backgroundColor: AppDesign.colors.gray800,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildBackground(children: [
          _buildNickname(),
          _buildEmail(),
          AppDesign.spacing.h24,
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(child: _buildCounterContainer('내가 작성한\n좌석 후기', 50)),
                AppDesign.spacing.w12,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoute.bookmarkedReviews.name);
                    },
                    child: _buildCounterContainer('즐겨찾기 한\n좌석 후기', 30),
                  ),
                ),
              ],
            ),
          )
        ]),
        Expanded(child: _buildListView()),
      ],
    );
  }

  Widget _buildBackground({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppDesign.colors.gray800,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDesign.spacing.sp16, vertical: AppDesign.spacing.sp24),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildNickname() {
    return Text('1열 사수 다람쥐', style: AppDesign.typo.title1(color: AppDesign.colors.gray50));
  }

  Widget _buildEmail() {
    return Text('test@email.com', style: AppDesign.typo.body2(color: AppDesign.colors.gray50));
  }

  Widget _buildCounterContainer(String title, int count) {
    return Container(
      decoration: BoxDecoration(
        color: AppDesign.colors.gray800,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppDesign.colors.gray900,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: AppDesign.spacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppDesign.typo.title2semiBold(color: AppDesign.colors.gray50),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
            AppDesign.spacing.h12,
            const Spacer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '$count',
                style: AppDesign.typo.h2(color: AppDesign.colors.gray50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    const items = Profile.values;
    return Padding(
      padding: AppDesign.spacing.screenPadding,
      child: ListView.separated(
        itemBuilder: (context, index) => _buildItem(items[index].title),
        separatorBuilder: (context, index) {
          return Divider(color: AppDesign.colors.gray200);
        },
        itemCount: items.length,
      ),
    );
  }

  Widget _buildItem(String text) {
    return Padding(
      padding: AppDesign.spacing.vertical16,
      child: Text(
        text,
        style: AppDesign.typo.body2(),
      ),
    );
  }
}
