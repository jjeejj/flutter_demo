// list 扩展方法

// SafeList 安全相关的扩展
extension SafeList<T> on List<T> {
  T? tryGet(int index) {
    return index < 0 || index >= length ? null : this[index];
  }
}
