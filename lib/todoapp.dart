import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;
  DateTime _tempDateTime = DateTime.now();
  String? _dateTimeValidate;

  List<Map<String, dynamic>> _todoList = [];

  void addData(){
    setState(() {
      _dateTimeValidate = _selectedDate == null?
      'Please select a date' : null;
    });

    if (_key.currentState!.validate() && _selectedDate != null) {
      setState(() {
        _todoList.add({
          'task': _controller.text,
          'date': _selectedDate,
          'done': false
        });
        _controller.clear();
        _selectedDate = null;
      });

      
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}