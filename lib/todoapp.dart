import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              SizedBox(height: 10),
              ElevatedButton(
                style:ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00A99D),
                foregroundColor: Colors.white,
                fixedSize: Size(160,46),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
                ),
                onPressed: (){
                setState(() {
                  _selectedDate = _tempDateTime;
                  _dateTimeValidate = null;
                });
                Navigator.pop(context);
                }, 
                child: 
                Text("Select",
                style: TextStyle(fontSize: 18,
                fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Center(
                child: Text(
                  "Form Page",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              SizedBox(height: 20),
              Text(
                "Task Date & Time: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(children: [
                Expanded(child: Text(
                  _selectedDate == null
                  ?"Selecet a date and time"
                  :DateFormat('EEE, MMM d, y h:mm a').format(_selectedDate!),
                  style: TextStyle(
                    fontSize: 16,
                    color: _dateTimeValidate == null
                    ?Colors.red
                    :Colors.black
                  ),
                ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today,
                  color: Colors.teal),
                  onPressed: () => _showDateTimePicker(context)
                  ,)
              ],),
              if(_dateTimeValidate != null)
              Padding(padding: EdgeInsets.only(left: 5, top: 5),
              child: Text(
                _dateTimeValidate!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12),
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _key,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: "Task Name",
                          hintText: "Enter your task",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 1.5), 
                            borderRadius: BorderRadius.circular(8)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 2), 
                            borderRadius: BorderRadius.circular(8)
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.5), 
                            borderRadius: BorderRadius.circular(8)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2), 
                            borderRadius: BorderRadius.circular(8)
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: addData,
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ),
              SizedBox(height: 20),
              Text(
                "Task List",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Expanded(child: ListView.builder(
                itemBuilder: (context, index){
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _todoList[index]['task'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                                'Due: ${DateFormat('EEE, MMM d • hh:mm a').format(_todoList[index]['dateTime'])}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                _todoList[index]['done'] ? 'Done' : 'Not Done',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _todoList[index]['done'] ? Colors.green : Colors.red,
                                ),
                              ),
                          ],
                        ),
                        Checkbox(
                            activeColor: Colors.teal,
                            value: _todoList[index]['done'],
                            onChanged: (bool? value) {
                              setState(() {
                                _todoList[index]['done'] = value!;
                              });
                            },
                          ),
                      ],
                    )
                  );
                }
              ))
            ]
          ),
        )
      )
    );
  }
}