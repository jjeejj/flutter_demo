import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/features/demo_examples/sealed/ui_state.dart';
import 'package:flutter_demo/shared/utils/logger.dart';

class CubitState extends Cubit<UIState> {
  CubitState() : super(const InitialState());

  Future<void> randomDivision() async {
    final num1 = Random().nextInt(10);
    final num2 = Random().nextInt(3);
    final randomNumbers = RandomNumber(num1: num1, num2: num2);
    emit(LoadingState<RandomNumber>(randomNumbers));
    await Future.delayed(const Duration(milliseconds: 50));
    // await Future.delayed(const Duration(seconds: 2));
    if (num2 == 0) {
      LoggerHelper.e('Division by zero');
      emit(const ErrorState('Division by zero'));
      return;
    }
    final result = num1 / num2;
    emit(SuccessState<double>(result));
  }
}

class RandomNumber {
  final int num1;
  final int num2;

  const RandomNumber({required this.num1, required this.num2});
}
