import 'package:flutter/material.dart';
import 'package:myproject/providers/counter_provider.dart';
import 'package:myproject/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class CounterProviderScreen extends StatelessWidget {
  const CounterProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // load provider กรณีไม่ได้ include ใน main.dart
    // final provider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider ${DateTime.now().microsecondsSinceEpoch}'),
        actions: [
          Consumer<TimerProvider>(
            builder: (context, provider, child) {
              return (TextButton(
                onPressed: provider.isRunning
                    ? provider.stopTimer
                    : provider.startTimer,
                child: Text(
                  provider.seconds.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ));
            },
          ),
          Consumer<TimerProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                  (Text(
                    provider.countDown.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  )),
                  IconButton(
                    onPressed: provider.isRunning
                        ? provider.stopTimer
                        : provider.countDown10Sec,
                    icon: Icon(Icons.access_alarm),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    IconButton(
                      onPressed: provider.increment,
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: provider.getColor(),
                      ),
                    ),
                    Text(
                      provider.counter.toString(),
                      style: TextStyle(
                        fontSize: 120,
                        color: provider.getColor(),
                      ),
                    ),
                    IconButton(
                      onPressed: provider.decrement,
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: provider.getColor(),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 100),
            Text(
              'Open at : ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Timestamp : ${DateTime.now().microsecondsSinceEpoch.toString()}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<TimerProvider>(
        builder: (context, provider, child) {
          return FloatingActionButton(
            onPressed: () => provider.isRunning
                ? provider.stopTimer()
                : provider.startTimer(),
            child: Icon(provider.isRunning ? Icons.pause : Icons.play_arrow),
          );
        },
      ),
    );
  }
}
