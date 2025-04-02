import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:viewith/app/route/app_router.dart';
import 'package:viewith/ui/app_design.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: 'f19982018282c10ca37dccbd5268f139',
    javaScriptAppKey: 'f7156459734be7d179d146df422982',
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        appBarTheme: AppBarTheme(backgroundColor: AppDesign.colors.white),
        scaffoldBackgroundColor: AppDesign.colors.white,
        tabBarTheme: const TabBarTheme(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
        ),
        colorScheme: ThemeData().colorScheme.copyWith(primary: AppDesign.colors.gray900),
        canvasColor: AppDesign.colors.white,
      ),
      routerConfig: router,
    );
  }
}
