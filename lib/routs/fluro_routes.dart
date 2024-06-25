import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/pages/app_configuration/app_configuration.dart';
import 'package:flutter_demo/pages/app_index/app_index.dart';
import 'package:flutter_demo/pages/app_write_new/app_write_new.dart';
import 'package:flutter_demo/pages/default/error.dart';

// error
var errorHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const ErrorPage();
});

// app index
var indexHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const AppIndexPage();
});

// app config
var appConfigurationHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const AppConfigurationPage();
});

// app write new
var writeDiaryHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  if (params.isNotEmpty && params['id'] != null) {
    return AppWriteNewPage(id: params['id']![0]);
  } else {
    return const AppWriteNewPage(id: "");
  }
});

class FluroRoutes {
  static String indexPage = '/';
  static String errorPage = '/error';
  static String writeDiaryPage = 'writeDiary';
  static String appConfigurationPage = '/appConfiguration';

  static void configureRoutes(FluroRouter router) {
    router.define(indexPage, handler: indexHandler);
    router.define(appConfigurationPage, handler: appConfigurationHandler);
    router.define('$writeDiaryPage/:id', handler: writeDiaryHandler);
    router.notFoundHandler = errorHandler;
  }
}
