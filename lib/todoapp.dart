import 'package:flutter/cupertino.dart';
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Task added successfully"),
          backgroundColor: Colors.green,)
      );
    }
  }

  void _showDateTimePicker(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext builder){
        return Container(
          height: 280,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 30),
                Text(
                  "Set Task Date & Time",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close,
                    color: Colors.grey),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  )              
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: CupertinoDatePicker(
                  onDateTimeChanged: (DateTime newDatetime){
                    _tempDateTime = newDatetime;
                  },
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: _selectedDate ?? DateTime.now(),
                )
              ),
            ],
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}