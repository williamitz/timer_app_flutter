import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/providers/timer_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final countProvider = Provider.of<TimerProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text('Cuenta regresiva'),
        actions: [
          IconButton(
            onPressed: countProvider.isRunning ? null : () {
              countProvider.onReset();
            }, 
            icon: Icon( Icons.restart_alt_outlined )
          )
        ],
      ),

      body: const _CounterLabel(),

      floatingActionButton: FloatingActionButton(
        onPressed: countProvider.locked ? null : () {
          countProvider.startStopTime();
        },
        backgroundColor: countProvider.locked ? Colors.grey : Colors.blue,
        child:  Icon( countProvider.isRunning ? Icons.pause :  Icons.play_arrow ),
      ),

    );
  }
}

class _CounterLabel extends StatelessWidget {
  const _CounterLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // final countProvider = Provider.of<TimerProvider>(context);
    // final countProvider = ;

    return Center(
      child: Container(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon( Icons.timer_outlined, color: Colors.blue, size: 52, ),
            const SizedBox( width: 10,  ),
            Text( 
              context.select((TimerProvider countProvider) => countProvider.currentTime),
              style: const TextStyle(

                fontSize: 50,

              ),
             )

          ],
        ),

      ),
    );
  }
}