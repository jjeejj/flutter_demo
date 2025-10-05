// 结果类型
sealed class Result{}

class Success<T> extends Result {
  final T data;
  Success(this.data);
}

class Error extends Result {
  final String errorMessage;
  Error(this.errorMessage);
}

// 状态机
sealed class ConnectionState{}

// 连接中
class Connecting extends ConnectionState{}

// 连接成功
class Connected extends ConnectionState{
  final String address;
  Connected(this.address);
}

class Disconnected extends ConnectionState {}
