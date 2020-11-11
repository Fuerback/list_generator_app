import 'package:flutter/material.dart';
import 'package:list_generator/app/controllers/list_details_controller.dart';
import 'package:list_generator/app/models/todo_item_model.dart';
import 'package:list_generator/app/models/todo_model.dart';
import 'package:list_generator/app/widgets/custom_add_item.dart';
import 'package:list_generator/app/widgets/custom_app_bar.dart';
import 'package:list_generator/app/widgets/custom_body_rounded.dart';
import 'package:list_generator/app/widgets/custom_info_message.dart';
import 'package:list_generator/app/widgets/custom_raised_button.dart';
import 'package:list_generator/app/widgets/custom_text_field.dart';

class ListDetailsView extends StatefulWidget {
  final ToDo toDo;

  ListDetailsView({this.toDo});

  @override
  _ListDetailsViewState createState() => _ListDetailsViewState();
}

class _ListDetailsViewState extends State<ListDetailsView> {
  List<ToDoItem> _items = List();

  ToDo _toDoSelected;
  final _itemController = TextEditingController();

  ListDetailsController listDetailsController = ListDetailsController();

  @override
  void initState() {
    super.initState();
    _toDoSelected = widget.toDo;
    listDetailsController.getAllToDoItems(_toDoSelected).then((list) {
      setState(() {
        _items = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: _toDoSelected.name,
          actionIcon: Icon(Icons.settings),
          onPressed: () {
            modalBottomSheet(context);
          },
        ),
        backgroundColor: Colors.blue,
        body: CustomBodyRounded(
          child: Column(
            children: <Widget>[
              CustomAddItem(
                onPressed: _addItem,
                itemController: _itemController,
              ),
              _items.isEmpty
                  ? Expanded(
                      child: CustomInfoMessage(
                        message: "Você não possui itens ",
                      ),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        backgroundColor: Colors.white,
                        child: ListView.separated(
                          itemCount: _items.length,
                          itemBuilder: (_, index) {
                            return CheckboxListTile(
                              title: Text(_items[index].description,
                                  style: TextStyle(fontSize: 18.0)),
                              onChanged: (bool value) {
                                _updateItem(index, value);
                              },
                              value: _items[index].isDone,
                              secondary: CircleAvatar(
                                child: Icon(_items[index].isDone
                                    ? Icons.check
                                    : Icons.error),
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
        ));
  }

  Future modalBottomSheet(BuildContext context) {
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
                            _clearSelectedItems();
                          },
                          child: Text(
                            "Limpar selecionados",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 20.0),
                          )),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: Text(
                                        "Limpar lista " + _toDoSelected.name),
                                    content: Text(
                                        "Tem certeza que deseja limpar a lista?"),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Não")),
                                      CustomRaisedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          _clearAllItems();
                                        },
                                        text: "Sim",
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          },
                          child: Text(
                            "Limpar lista",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ))
                    ],
                  ),
                );
              });
        });
  }

  void _clearSelectedItems() {
    setState(() {
      var toRemove = [];
      _items.forEach((item) {
        if (item.isDone) {
          toRemove.add(item);
          listDetailsController.removeItem(item);
        }
      });

      _items.removeWhere((e) => toRemove.contains(e));
    });
  }

  void _clearAllItems() {
    setState(() {
      _items.forEach((item) {
        listDetailsController.removeItem(item);
      });

      _items.clear();
    });
  }

  void _updateItem(int index, bool done) {
    setState(() {
      _items[index].done = done ? 1 : 0;
      listDetailsController.updateItem(_items[index]);
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      listDetailsController.sortItems(_items);
    });
  }

  void _addItem() {
    if (_itemController.text.isNotEmpty) {
      setState(() {
        FocusScope.of(context).nextFocus();
        ToDoItem item =
            ToDoItem(_itemController.text, todoId: _toDoSelected.id);
        listDetailsController.insertItem(item);
        _itemController.text = "";
        _items.add(item);
      });
    }
  }
}
