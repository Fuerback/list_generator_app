import 'package:flutter/material.dart';
import 'package:list_generator/app/controllers/home_controller.dart';
import 'package:list_generator/app/models/todo_model.dart';
import 'package:list_generator/app/views/list_details_view.dart';
import 'package:list_generator/app/widgets/custom_app_bar.dart';
import 'package:list_generator/app/widgets/custom_body_rounded.dart';
import 'package:list_generator/app/widgets/custom_info_message.dart';
import 'package:list_generator/app/widgets/custom_raised_button.dart';
import 'package:list_generator/app/widgets/custom_text_field.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ToDo> _toDoList = List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _listController = TextEditingController();
  final _editListController = TextEditingController();

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
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Minhas listas',
      ),
      backgroundColor: Colors.blue,
      body: CustomBodyRounded(
        child: _toDoList.isEmpty
            ? CustomInfoMessage(
                message: "Você não possui listas ",
              )
            : Column(
                children: <Widget>[
                  Expanded(
                    child: RefreshIndicator(
                      backgroundColor: Colors.white,
                      child: ListView.separated(
                        itemCount: _toDoList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Center(
                              child: Text(
                                '${_toDoList[index].name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            trailing: GestureDetector(
                              child: _toDoList[index].isStarred
                                  ? Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    )
                                  : Icon(Icons.star_border),
                              onTap: () {
                                _setFavorite(context, _toDoList[index]);
                              },
                            ),
                            onTap: () {
                              _showListDetailsView(_toDoList[index]);
                            },
                            onLongPress: () {
                              return modalBottomSheet(context, index);
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
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: const Text('Nova lista'),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text("Criar nova lista"),
                content: CustomTextField(
                  autoFocus: true,
                  textEditingController: _listController,
                  hintText: "Nome da lista",
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        _listController.text = "";
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancelar")),
                  CustomRaisedButton(
                    onPressed: () {
                      _addList();
                      Navigator.of(context).pop();
                    },
                    text: "Criar",
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future modalBottomSheet(BuildContext context, int index) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Text("Editar Lista"),
                                  content: CustomTextField(
                                    autoFocus: true,
                                    hintText: _toDoList[index].name,
                                    textEditingController: _editListController,
                                  ),
                                  actions: [
                                    FlatButton(
                                        onPressed: () {
                                          _editListController.text = "";
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancelar")),
                                    CustomRaisedButton(
                                      onPressed: () {
                                        _toDoList[index].name =
                                            _editListController.text;
                                        _editListController.text = "";
                                        homeController
                                            .updateTodo(_toDoList[index]);
                                        Navigator.of(context).pop();
                                      },
                                      text: "Editar",
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "Editar",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 20.0),
                          )),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              homeController.removeTodo(_toDoList[index]);
                              _toDoList.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ))
                    ],
                  ),
                );
              });
        });
  }

  void _setFavorite(BuildContext context, ToDo toDo) {
    setState(() {
      toDo.starred = toDo.isStarred ? 0 : 1;
      homeController.updateTodo(toDo);
    });
    final snack = SnackBar(
      content: Text('Lista \'${toDo.name}\' favoritada.'),
      duration: Duration(seconds: 1),
    );

    Scaffold.of(context).showSnackBar(snack);
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

    setState(() {
      homeController.sortLists(_toDoList);
    });
  }

  void _addList() {
    if (_listController.text.isNotEmpty) {
      setState(() {
        ToDo todo = ToDo(name: _listController.text);
        _listController.text = "";
        _toDoList.add(todo);
        homeController.insertTodo(todo);
        FocusScope.of(context).nextFocus();
      });
    }
  }
}
