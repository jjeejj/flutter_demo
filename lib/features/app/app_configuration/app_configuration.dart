import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/main.dart';
import 'package:flutter_demo/core/routing/routs/fluro_routes.dart';
import 'package:flutter_demo/shared/utils/shared_pref.dart';

class AppConfigurationPage extends StatefulWidget {
  const AppConfigurationPage({super.key});

  @override
  State<StatefulWidget> createState() => _AppConfigurationPageState();
}

class _AppConfigurationPageState extends State<AppConfigurationPage> {
  final TextEditingController _nameInputController = TextEditingController();

  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Widget _buildInputForm() {
    return CupertinoTextField(
      placeholder: '请输入您的名字',
      keyboardType: TextInputType.name,
      controller: _nameInputController,
    );
  }

  Widget _buildConfirmButton() {
    return CupertinoButton(
        child: const Text("继续"),
        onPressed: () {
          _saveToSharePref();
        });
  }

  void _saveToSharePref() {
    var name = _nameInputController.text;
    if (name == '') {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text("请检查"),
              content: const Text("请检查输入的名称"),
              actions: [
                CupertinoDialogAction(
                  child: const Text("确定"),
                  onPressed: () {
                    Navigator.of(context).pop;
                  },
                )
              ],
            );
          });
    } else {
      // 保存资料
      SharedPreUtil.setStringData("username", name);
      router.navigateTo(context, FluroRoutes.indexPage, clearStack: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text("个人资料配置"),
          ),
          child: SafeArea(
              child: Container(
            margin: const EdgeInsets.all(50),
            child: Column(
              children: [
                Expanded(
                    child: Center(
                  child: _buildInputForm(),
                )),
                _buildConfirmButton()
              ],
            ),
          ))),
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
    );
  }
}
