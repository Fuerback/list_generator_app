import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _itemController = TextEditingController();

  List _todoList = [];

  @override
  void initState() {
    super.initState();
    _readData().then((value) {
      setState(() {
        _todoList = json.decode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tarefas'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [addItemWidget(_itemController), listView(_todoList)],
      ),
    );
  }

  Widget listView(List list) {
    return Expanded(
        child: ListView.builder(
            padding: EdgeInsets.only(top: 10.0),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(list[index]['title']),
                value: list[index]['ok'],
                secondary: CircleAvatar(
                    child: Icon(list[index]['ok'] ? Icons.check : Icons.error)),
                onChanged: (check) {
                  setState(() {
                    _todoList[index]['ok'] = check;
                    _saveData();
                  });
                },
              );
            }));
  }

  Widget addItemWidget(var controller) {
    return Container(
      padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  labelText: "Nova tarefa",
                  labelStyle: TextStyle(color: Colors.blueAccent)),
            ),
          ),
          RaisedButton(
            onPressed: _addItem,
            color: Colors.blueAccent,
            child: Text('Add'),
            textColor: Colors.white,
          )
        ],
      ),
    );
  }

  void _removeItem(int index) {
    setState(() {
      _todoList.removeAt(index);
      _saveData();
    });
  }

  void _addItem() {
    setState(() {
      Map<String, dynamic> newItem = Map();
      newItem['title'] = _itemController.text;
      _itemController.text = '';
      newItem['ok'] = false;
      _todoList.add(newItem);
      _saveData();
    });
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');
  }

  Future<File> _saveData() async {
    String data = json.encode(_todoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
