import 'package:flutter/material.dart';
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
  List<ToDoItem> items = [
    ToDoItem('item 1', todoId: '1'),
    ToDoItem('item 2', todoId: '1')
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _listController = TextEditingController();

    void _addItem() {
      setState(() {
        FocusScope.of(context).nextFocus();
        ToDoItem item = ToDoItem(_listController.text, todoId: '1');
        _listController.text = "";
        items.add(item);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Nome lista')),
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
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(
                    '${items[index].description}',
                  ),
                  onTap: () {},
                );
              },
              separatorBuilder: (_, __) {
                return Divider();
              },
            ),
          )
        ],
      ),
    );
  }
}
