import 'package:flutter/material.dart';
import 'package:list_generator/app/models/item.dart';
import 'package:list_generator/app/widgets/custom_raised_button.dart';
import 'package:list_generator/app/widgets/custom_text_field.dart';

class DetailsListView extends StatefulWidget {
  @override
  _DetailsListViewState createState() => _DetailsListViewState();
}

class _DetailsListViewState extends State<DetailsListView> {
  List<Item> items = [
    Item("Item 1", false),
    Item("Item 2", false),
    Item("Item 3", false),
    Item("Item 4", false),
    Item("Item 5", false),
    Item("Item 6", false)
  ];

  @override
  Widget build(BuildContext context) {
    final _listController = TextEditingController();

    void _addItem() {
      setState(() {
        Item item = Item("", false);
        item.description = _listController.text;
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
