import 'package:flutter/material.dart';
import 'package:list_generator/app/controllers/home_controller.dart';
import 'package:list_generator/app/models/todo_model.dart';
import 'package:list_generator/app/views/list_details_view.dart';
import 'package:list_generator/app/widgets/custom_raised_button.dart';
import 'package:list_generator/app/widgets/custom_text_field.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ToDo> _toDoList = List();

  HomeController homeController = HomeController();

  @override
  void initState() {
    super.initState();
    homeController.getAllToDo().then((list) {
      setState(() {
        _toDoList = list;
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
        _toDoList.add(todo);
        homeController.insertTodo(todo);
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
            child: RefreshIndicator(
              child: ListView.separated(
                itemCount: _toDoList.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      '${_toDoList[index].name}',
                    ),
                    trailing: GestureDetector(
                      child: _toDoList[index].isStarred
                          ? Icon(
                              Icons.star,
                              color: Colors.amber,
                            )
                          : Icon(Icons.star_border),
                      onTap: () {
                        setState(() {
                          _toDoList[index].starred =
                              _toDoList[index].isStarred ? 0 : 1;
                          homeController.updateTodo(_toDoList[index]);
                        });
                      },
                    ),
                    onTap: () {
                      _showListDetailsView(_toDoList[index]);
                    },
                  );
                },
                separatorBuilder: (_, __) {
                  return Divider();
                },
              ),
              onRefresh: _refresh,
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

  void _showListDetailsView(ToDo toDo) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListDetailsView(
                  toDo: toDo,
                )));
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
  }
}
