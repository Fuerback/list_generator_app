import 'package:flutter/material.dart';
import 'package:list_generator/app/models/todo_model.dart';
import 'package:list_generator/app/views/list_details_view.dart';
import 'package:list_generator/app/widgets/custom_raised_button.dart';
import 'package:list_generator/app/widgets/custom_text_field.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ToDo> _itemsList = [
    ToDo(name: 'lista 1', id: '1'),
    ToDo(name: 'lista 2', id: '2'),
    ToDo(name: 'lista 3', id: '3')
  ];

  @override
  Widget build(BuildContext context) {
    final _listController = TextEditingController();

    void _addList() {
      setState(() {
        Map<String, dynamic> newToDo = Map();
        newToDo["description"] = "item 1";
        newToDo["done"] = false;

        FocusScope.of(context).nextFocus();

        ToDo itemList = ToDo(name: _listController.text);
        _listController.text = "";
        _itemsList.add(itemList);
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
