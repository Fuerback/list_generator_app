import 'package:flutter/material.dart';
import 'package:list_generator/app/models/item_list.dart';
import 'package:list_generator/app/views/details_list_view.dart';
import 'package:list_generator/app/widgets/custom_raised_button.dart';
import 'package:list_generator/app/widgets/custom_text_field.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ItemList> _itemsList = [
    ItemList("lista 1", false, Map()),
    ItemList("lista 2", false, Map()),
    ItemList("lista 3", false, Map()),
    ItemList("lista 4", false, Map()),
    ItemList("lista 5", false, Map())
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

        ItemList itemList = ItemList("", false, Map());
        itemList.name = _listController.text;
        itemList.items.addAll(newToDo);
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
                            builder: (context) => DetailsListView()));
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
