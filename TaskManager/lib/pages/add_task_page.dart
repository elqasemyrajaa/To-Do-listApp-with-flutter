import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:TaskManager/model/database.dart';
import 'package:TaskManager/model/todo.dart';
import 'package:TaskManager/widgets/custom_datetime_picker.dart';
import 'package:TaskManager/widgets/custom_modal_action.dart';
import 'package:TaskManager/widgets/custom_textfield.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  final _textTaskControler = TextEditingController();

  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datepick != null)
      setState(() {
        _selectedDate = datepick;
      });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Database>(context);

    _textTaskControler.clear();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
            "Add new task",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          )),
          SizedBox(
            height: 24,
          ),
          CustomTextField(
              labelText: 'Enter task name', controller: _textTaskControler),
          SizedBox(height: 11),
          CustomDateTimePicker(
            icon: Icons.date_range,
            onPressed: _pickDate,
            value: new DateFormat("dd-MM-yyyy").format(_selectedDate),
          ),
          SizedBox(
            height: 24,
          ),
          CustomModalActionButton(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: () {
              if (_textTaskControler.text == "") {
                print("data not found");
              } else {
                provider
                    .insertTodoEntries(new TodoData(
                        date: _selectedDate,
                        time: DateTime.now(),
                        isFinish: false,
                        task: _textTaskControler.text,
                        description: "",
                        todoType: TodoType.TYPE_TASK.index,
                        id: null))
                    .whenComplete(() => Navigator.of(context).pop());
              }
            },
          )
        ],
      ),
    );
  }
}
