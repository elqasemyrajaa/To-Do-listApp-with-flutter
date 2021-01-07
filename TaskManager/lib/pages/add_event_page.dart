import 'package:TaskManager/model/database.dart';
import 'package:TaskManager/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:TaskManager/widgets/custom_modal_action.dart';
import 'package:TaskManager/widgets/custom_textField.dart';
import 'package:TaskManager/widgets/custom_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime timee = DateTime.now();

  final _textTaskControler = TextEditingController();
  final _textTaskControler2 = TextEditingController();
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

  Future _pickTime() async {
    TimeOfDay timepick = await showTimePicker(
        context: context, initialTime: new TimeOfDay.now());
    if (timepick != null) {
      setState(() {
        _selectedTime = timepick;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Database>(context);

    _textTaskControler.clear();
    _textTaskControler2.clear();
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
            "Add new Event",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          )),
          SizedBox(
            height: 12,
          ),
          CustomTextField(
              labelText: "Enter event name", controller: _textTaskControler),
          SizedBox(
            height: 12,
          ),
          CustomTextField(
              labelText: "Enter description", controller: _textTaskControler2),
          SizedBox(
            height: 12,
          ),
          CustomDateTimePicker(
            icon: Icons.date_range,
            onPressed: _pickDate,
            value: new DateFormat("dd-MM-yyyy").format(_selectedDate),
          ),
          CustomDateTimePicker(
            icon: Icons.access_time,
            onPressed: _pickTime,
            value:'${_selectedTime.hour}:${_selectedTime.minute}',
          ),
          SizedBox(
            height: 15,
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
                        time:  new DateTime(_selectedDate.year,_selectedDate.month,_selectedDate.day,_selectedTime.hour,_selectedTime.minute),
                        isFinish: false,
                        task: _textTaskControler.text,
                        description: _textTaskControler2.text,
                        todoType: TodoType.TYPE_EVENT.index,
                        id: null))
                    .whenComplete(() => Navigator.of(context).pop());
              }
            },
          ),
        ],
      ),
    );
  }
}
