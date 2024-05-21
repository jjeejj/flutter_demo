sealed class UIState {
  const UIState();
}

// 初始状态
class InitialState extends UIState {
  const InitialState();
}

class LoadingState<T> extends UIState {
  final T data;

  const LoadingState(this.data);
}

class SuccessState<T> extends UIState {
  final T data;

  const SuccessState(this.data);
}

class ErrorState extends UIState {
  final String message;

  const ErrorState(this.message);
}
