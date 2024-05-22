import 'dart:io';
import 'package:yaml/yaml.dart' as yaml;

void main() async {
  final _projectPath = await Process.run("pwd", []);
  final projectPath = (_projectPath.stdout as String).replaceAll('\n', '');
  stdout.write('项目的根目录: $projectPath 开始编译 apk \n');

  // 开始编译
  final process = await Process.start('flutter', ['build', 'apk', '--verbose'],
      workingDirectory: projectPath, mode: ProcessStartMode.inheritStdio);

  final buildResult = await process.exitCode;
  if (buildResult != 0) {
    stdout.write('打包失败,请查看日志');
    return;
  }
  process.kill();

  // 重命名
  final file = File('$projectPath/pubspec.yaml');
  final fileContent = await file.readAsString();
  final yamlMap = yaml.loadYaml(fileContent);
  // 获取版本
  final version = yamlMap['version'].toString().replaceAll('+', '-');
  final appName = yamlMap['name'].toString();
  stdout.write('appName,$appName');

  final apkDirectory = '$projectPath/build/app/outputs/flutter-apk/';
  const buildAppName = 'app-release.apk';
  final apkFile = File(apkDirectory + buildAppName);
  final appPath = '$apkDirectory${appName}_$version.apk';
  await apkFile.rename(appPath);
  stdout.write('apk 打包成功 >>>>> $appPath \n');
}
