import 'package:flutter/material.dart';
import 'package:list_generator/app/controllers/list_details_controller.dart';
import 'package:list_generator/app/models/todo_item_model.dart';
import 'package:list_generator/app/models/todo_model.dart';
import 'package:list_generator/app/widgets/custom_raised_button.dart';
import 'package:list_generator/app/widgets/custom_text_field.dart';

class ListDetailsView extends StatefulWidget {
  final ToDo toDo;

  ListDetailsView({this.toDo});

  @override
  _ListDetailsViewState createState() => _ListDetailsViewState();
}

class _ListDetailsViewState extends State<ListDetailsView> {
  List<ToDoItem> items = List();

  ToDo _toDoSelected;
  final _listController = TextEditingController();

  ListDetailsController listDetailsController = ListDetailsController();

  @override
  void initState() {
    super.initState();
    _toDoSelected = widget.toDo;
    listDetailsController.getAllToDoItems(_toDoSelected).then((list) {
      setState(() {
        items = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_toDoSelected.name)),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 3.0, 7.0, 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: CustomTextField(
                  text: "Novo item",
                  textEditingController: _listController,
                )),
                CustomRaisedButton(
                  onPressed: _addItem,
                  text: "Add +",
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              child: ListView.separated(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  return CheckboxListTile(
                    title: Text(items[index].description,
                        style: TextStyle(fontSize: 18.0)),
                    onChanged: (bool value) {
                      _updateTask(index, value);
                    },
                    value: items[index].isDone,
                    secondary: CircleAvatar(
                      child:
                          Icon(items[index].isDone ? Icons.check : Icons.error),
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return Divider();
                },
              ),
              onRefresh: _refresh,
            ),
          )
        ],
      ),
    );
  }

  void _updateTask(int index, bool done) {
    setState(() {
      items[index].done = done ? 1 : 0;
      listDetailsController.updateTask(items[index]);
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      listDetailsController.sortItems(items);
    });
  }

  void _addItem() {
    if (_listController.text.isNotEmpty) {
      setState(() {
        FocusScope.of(context).nextFocus();
        ToDoItem item =
            ToDoItem(_listController.text, todoId: _toDoSelected.id);
        listDetailsController.insertItem(item);
        _listController.text = "";
        items.add(item);
      });
    }
  }
}
