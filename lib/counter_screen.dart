import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class WebsocketClient{
  Stream<int> getCounterStream([int start]);
}

class FakeWebsocketClient implements WebsocketClient{
  @override
  Stream<int> getCounterStream([int start = 0]) async* {
    int i = start;
    while(true) {
      yield i++;
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
}

final websocketClientProvider = Provider<WebsocketClient>((ref) {
  return FakeWebsocketClient();
});

final counterProvider = StreamProvider.family<int, int>((ref, start)  {
  final wsClient = ref.read(websocketClientProvider);
  return wsClient.getCounterStream(start);
});

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<int> counter = ref.watch(counterProvider(5));

    return Scaffold(
      appBar: AppBar(
          title: const Text("Counter")
      ),
      body: Center(
        child: Text(
            counter.when(
                data: (int value) => value,
                error: (Object e, _) => e,
                loading: () => 0
            ).toString(),
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black
            )
        ),
      ),
    );
  }

}
