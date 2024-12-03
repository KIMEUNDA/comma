import 'package:flutter/material.dart';
import 'confirmation_page.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _selectedPeople = 1;

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _submitReservation(BuildContext context) {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("날짜와 시간을 선택해주세요.")),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationPage(
            date: _selectedDate!,
            time: _selectedTime!,
            people: _selectedPeople,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("동방 예약 페이지"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _selectedDate == null
                  ? "선택된 날짜: 없음"
                  : "선택된 날짜: ${_selectedDate!.toLocal().toString().split(' ')[0]}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickDate,
              child: const Text("날짜 선택"),
            ),
            const SizedBox(height: 20),
            Text(
              _selectedTime == null
                  ? "선택된 시간: 없음"
                  : "선택된 시간: ${_selectedTime!.format(context)}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickTime,
              child: const Text("시간 선택"),
            ),
            const SizedBox(height: 20),
            Text(
              "인원을 선택하세요",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            DropdownButton<int>(
              value: _selectedPeople,
              items: List.generate(8, (index) => index + 1)
                  .map((number) => DropdownMenuItem<int>(
                value: number,
                child: Text("$number명"),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPeople = value!;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _submitReservation(context),
              child: const Text("예약하기"),
            ),
          ],
        ),
      ),
    );
  }
}
