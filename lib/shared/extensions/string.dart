// String 字符串方法扩展
extension StringExtensions on String {
  // 首字母大写
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return substring(0, 1).toUpperCase() + substring(1);
  }
}
