// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales/core/language/language_controller.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/shared_preference_helper.dart';
import 'package:sales/features/home/presentation/pages/home/home_screen.dart';
import 'package:sales/features/initialization/presentation/Page/initialization_screen.dart';
import 'package:sales/ur_class.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'core/theme.dart';
import 'injection.dart' as di;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  configLoading();
  await SharedPrefHelper.sp.initSharedPreferences();
  await di.init();
  runApp(
      const ProviderScope(child: MyApp())
  );
}



class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Widget getChild(){
    if((SharedPrefHelper.sp.getBool('isLogged')??false)){
    return const HomeScreen();
    }else{
      return const InitializationScreen();
    }
  }

  @override
  Widget build(BuildContext context,ref) {
    final language = ref.watch(languageProvider);
    // GetUrlClass().check();
    return ProviderScope(
      child:ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            // navigatorKey:navigatorKey,
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            title: 'Makhzon',
            builder:EasyLoading.init(
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: language,
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            home: getChild(),
          );
        },
      )
    );
  }
}


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 500)
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 38.0
    ..radius = 0.0
    ..progressWidth=0.2
    ..progressColor = AppColors.primary
    ..backgroundColor = Colors.transparent
    ..boxShadow = <BoxShadow>[]
    ..maskType=EasyLoadingMaskType.clear
    ..indicatorColor = AppColors.primary
    ..textColor = Colors.white
    ..maskColor = AppColors.lightGrey
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}


class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
      Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,
      ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}


MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}