import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimelinePage extends StatelessWidget {
  final int count;

  const TimelinePage({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView.builder(
          itemCount: count,
          itemBuilder: (context, index) {
            return TimelineWidget(
              isLast: index == count - 1,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child:
                      // index == 5
                      //     ? Container(
                      //         height: 100,
                      //         decoration: BoxDecoration(
                      //             color: Colors.green.shade700,
                      //             borderRadius: BorderRadius.circular(8)),
                      //       )
                      //     :
                      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title $index",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "SubTitle $index",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      )
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}

class TimelineWidget extends StatelessWidget {
  final bool isLast;
  final Widget child;

  const TimelineWidget({super.key, required this.isLast, required this.child});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade700,
                ),
              ),
              if (isLast)
                const SizedBox.shrink()
              else
                Expanded(
                  child: Container(
                    width: .5,
                    color: Colors.green.shade500,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(child: child)
        ],
      ),
    );
  }
}
