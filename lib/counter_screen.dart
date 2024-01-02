import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider((ref) => 0);

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counter = ref.watch(counterProvider);

    ref.listen<int>(counterProvider, (previous, next) {
          if (next >= 5) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Alert"),
                  content: Text("Counter has reached it's limit ${counter+1}. Time to refresh!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK")
                    )
                  ],
                );
              }
            );
          }
        }
    );

    return Scaffold(
      appBar: AppBar(
          title: const Text("Counter"),
          actions: [
            IconButton(
                onPressed: () {
                  ref.invalidate(counterProvider);
                },
                icon: const Icon(Icons.refresh)
            )
          ]
      ),
      body: Center(
        child: Text(
            "$counter",
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          ref.read(counterProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}
