import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movieapp/common/constants/languages.dart';
import 'package:movieapp/common/constants/route_constants.dart';
import 'package:movieapp/common/screenutil/screenutil.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/app_localizations.dart';
import 'package:movieapp/presentation/blocs/language/language_bloc.dart';
import 'package:movieapp/presentation/blocs/login/login_bloc.dart';
import 'package:movieapp/presentation/routes.dart';

import 'blocs/loading/loading_bloc.dart';
import 'fade_page_route_builder.dart';
import 'journeys/home/home_screen.dart';
import 'journeys/loading/loading_screen.dart';
import 'themes/theme_color.dart';
import 'themes/theme_text.dart';

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  LanguageBloc _languageBloc;
  LoginBloc _loginBloc;
  LoadingBloc _loadingBloc;
  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
    _languageBloc.add(LoadPreferredLanguageEvent());
    _loginBloc=getItInstance<LoginBloc>();
    _loadingBloc= getItInstance<LoadingBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    _loginBloc?.close();
    _loadingBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
    providers: [
    BlocProvider<LanguageBloc>.value(
      value: _languageBloc,
    ),
    BlocProvider<LoginBloc>.value(
    value: _loginBloc,
    ),
      BlocProvider<LoadingBloc>.value(
        value: _loadingBloc,
      ),
      ],
      child: BlocProvider<LanguageBloc>.value(
        value: _languageBloc,
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            if (state is LanguageLoaded) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Movie App',
                theme: ThemeData(
                  unselectedWidgetColor: AppColor.royalBlue,
                  primaryColor: AppColor.vulcan,
                  accentColor: AppColor.royalBlue,
                  scaffoldBackgroundColor: AppColor.vulcan,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: ThemeText.getTextTheme(),
                  appBarTheme: const AppBarTheme(elevation: 0),
                ),
                supportedLocales:
                    Languages.languages.map((e) => Locale(e.code)).toList(),
                locale: state.locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                builder: (context, child) {
                  return LoadingScreen(
                    screen: child,
                  );
                },
                initialRoute: RouteList.initial,
                onGenerateRoute: (RouteSettings settings) {
                  final routes = Routes.getRoutes(settings);
                  final WidgetBuilder builder = routes[settings.name]; //widget builder from the map
                  return FadePageRouteBuilder(
                    builder: builder,
                    settings: settings,
                  );
                },
                // home: HomeScreen(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
