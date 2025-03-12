import 'package:flutter/material.dart';
import 'package:flutter_term_2_exercises/activity_4_provider_count_end/provider/count_notifier.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterModel>(
      builder: (BuildContext context, counter, Widget? child) {
        return Column(
          children: [
            Text("Count =  ${counter.count}"),
            ElevatedButton(
              onPressed: () => {counter.increment()},
              child: Text("ADD 1"),
            ),
          ],
        );
      },
    );
  }
}
