import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movieapp/presentation/widgets/button.dart';
class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final Function onPressed;

  const AppErrorWidget({Key key,@required this.errorType,@required this.onPressed}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            // ignore: unrelated_type_equality_checks
            errorType == AppErrorType.api
                ?TranslationConstants.somethingWentWrong.t(context)
                :TranslationConstants.checkNetwork.t(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          FlatButton(onPressed: onPressed, child: Button(
            onPressed:onPressed, //fetching trading movie
            text: TranslationConstants.retry,
          )),
          //  ButtonBar(
          //      children:[
          //        Button(
          //         onPressed:()=>bloc.add(CarouselLoadEvent()),
          //         text: TranslationConstants.retry,
          //       ),
          //   ],)
        ]
    );
  }
}
