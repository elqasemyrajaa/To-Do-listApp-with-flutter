import 'package:TaskManager/model/database.dart';
import 'package:TaskManager/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:TaskManager/widgets/custom_icon_decoration.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class Event {
  final String time;
  final String task;
  final String desc;
  final bool isFinish;

  const Event(this.time, this.task, this.desc, this.isFinish);
}

class _EventPageState extends State<EventPage> {
  Database provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Database>(context);
    double iconsize = 20;
    return StreamProvider.value(
      value: provider.getTodoByType(TodoType.TYPE_EVENT.index),
      child: Consumer<List<TodoData>>(
        builder: (context, _dataList, child) {
          return _dataList == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Row(
                        children: [
                          lineStyle(context, iconsize, index, _dataList.length,
                              _dataList[index].isFinish),
                          displayTime(_dataList[index]),
                          displayContent(_dataList[index])
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  Widget displayContent(TodoData data) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x2000000),
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data.task),
              SizedBox(
                height: 12,
              ),
              Text(data.description),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayTime(TodoData data) {
    return InkWell(
      child: Container(
          width: 80,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(new DateFormat.jm().format(data.time)),
          )),
      onLongPress: () {
        provider
                     .deleteTodoEntries(data.id)
                    .whenComplete(() => print("well done"));
      },
    );
  }

  Widget lineStyle(BuildContext context, double iconsize, int index,
      int listLenght, bool isFinish) {
    return Container(
      decoration: CustomIconDecoration(
          iconSize: iconsize,
          lineWidth: 1,
          firstData: index == 0 ?? true,
          lastData: index == listLenght - 1 ?? true),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                  color: Color(0x2000000), blurRadius: 5, offset: Offset(0, 3))
            ]),
        child: Icon(
          isFinish ? Icons.fiber_manual_record : Icons.radio_button_unchecked,
          size: iconsize,
          color: Color.fromRGBO(142, 188, 35, 1),
        ),
      ),
    );
  }
}
