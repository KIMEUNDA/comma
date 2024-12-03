import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final int people;

  const ConfirmationPage({
    super.key,
    required this.date,
    required this.time,
    required this.people,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("예약 완료"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "예약이 완료되었습니다!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "날짜: ${date.toLocal().toString().split(' ')[0]}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "시간: ${time.format(context)}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "인원: $people명",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("돌아가기"),
            ),
          ],
        ),
      ),
    );
  }
}
