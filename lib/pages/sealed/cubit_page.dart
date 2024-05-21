import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wechat_demo/pages/sealed/cubit.dart';
import 'package:flutter_wechat_demo/pages/sealed/ui_state.dart';

class CubitPage extends StatefulWidget {
  final String title;

  const CubitPage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _CubitPageState();
}

class _CubitPageState extends State<CubitPage> {
  @override
  Widget build(BuildContext context) {
    RandomNumber? nums;
    return BlocProvider<CubitState>(
      create: (context) => CubitState(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<CubitState, UIState>(
                builder: (context, state) {
                  if (state is LoadingState<RandomNumber>) {
                    nums = state.data;
                  }
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<CubitState>().randomDivision();
                        },
                        child: const Text('Divide'),
                      ),
                      const SizedBox(height: 8),
                      nums != null
                          ? Text(
                              'Division of ${nums?.num1} by ${nums?.num2} is:',
                              style: const TextStyle(fontSize: 20),
                            )
                          : const SizedBox.shrink()
                      // Text(
                      //   'Division of ${nums?.num1} by ${nums?.num2} is:',
                      //   style: const TextStyle(fontSize: 20),
                      // )
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              BlocBuilder<CubitState, UIState>(
                builder: (context, state) {
                  return switch (state) {
                    InitialState() => const SizedBox.shrink(),
                    LoadingState() => const CircularProgressIndicator(),
                    SuccessState() => Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.greenAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          state.data.toString(),
                          style: const TextStyle(fontSize: 20),
                        )),
                    ErrorState() => Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.greenAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(state.message),
                      ),
                    _ => const SizedBox.shrink(),
                  };
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
