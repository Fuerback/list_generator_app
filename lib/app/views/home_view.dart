import 'package:flutter/material.dart';
import 'package:list_generator/app/db/db_provider.dart';
import 'package:list_generator/app/models/todo_model.dart';
import 'package:list_generator/app/views/list_details_view.dart';
import 'package:list_generator/app/widgets/custom_raised_button.dart';
import 'package:list_generator/app/widgets/custom_text_field.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ToDo> _itemsList = List();

  DBProvider dbProvider = DBProvider.db;

  @override
  void initState() {
    super.initState();
    dbProvider.getAllToDo().then((list) {
      setState(() {
        _itemsList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _listController = TextEditingController();

    void _addList() {
      setState(() {
        ToDo todo = ToDo(name: _listController.text);
        _listController.text = "";
        _itemsList.add(todo);
        dbProvider.insertTodo(todo);
        FocusScope.of(context).nextFocus();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Minhas listas')),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              itemCount: _itemsList.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(
                    '${_itemsList[index].name}',
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListDetailsView()));
                  },
                );
              },
              separatorBuilder: (_, __) {
                return Divider();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 2.0, 7.0, 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: CustomTextField(
                  text: "Nova lista",
                  textEditingController: _listController,
                )),
                CustomRaisedButton(
                  onPressed: _addList,
                  text: "Add +",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
