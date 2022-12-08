import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../model/excel_model.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List<List<dynamic>> data = [];
  List<ModelItem> list = [];
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Data Screen'),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        reverse: false,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 0.5,
              color: Colors.white54,
              child: ListTile(
                textColor: Colors.black87,
                leading: CircleAvatar(child: Text(list[index].id)),
                title: Text(list[index].name),
                subtitle: Text(list[index].phone),
                trailing: Text(list[index].gender),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            importFromExcel();
          });
        },
        child: const Icon(Icons.list),
      ),
    );
  }

  importFromExcel() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    filePath = result.files.first.path!;
    var bytes = File(filePath!).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table]?.maxCols);
      print(excel.tables[table]?.maxRows);

    //  excel.tables[table]!.rows.remove(0);

      for (List row in excel.tables[table]!.rows) {
        print("row element 1 ${row[0]}");

        if (row[0] != "id") {
          list.add(ModelItem(
            id: row[0].toString(),
            name: row[1],
            phone: row[2],
            gender: row[3].toString(),
          ));
        }
      }
      setState(() {});

      print("row element ssss ${list.length}");

      for (var element in list) {
        print("row element ssss ${element.toMap()}");
      }
    }
  }
}
