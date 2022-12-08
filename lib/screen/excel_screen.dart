import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelScreen extends StatefulWidget {
  const ExcelScreen({Key? key}) : super(key: key);

  @override
  State<ExcelScreen> createState() => _ExcelScreenState();
}

class _ExcelScreenState extends State<ExcelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Excel Sheet'),
      ),
      body: const Center(
        child:Text(
          'Excel Sheet ',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
Future<void> createExcel() async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  sheet.getRangeByName("A1").setText("id");
  sheet.getRangeByName("B1").setText("name");
  sheet.getRangeByName("C1").setText("gender");
  sheet.getRangeByName("D1").setText("phone");

  //Dummy Data you can remove it .

  sheet.getRangeByName("A2").setText("1");
  sheet.getRangeByName("B2").setText("ali");
  sheet.getRangeByName("C2").setText("male");
  sheet.getRangeByName("D2").setText("03001111223");

  sheet.getRangeByName("A3").setText("2");
  sheet.getRangeByName("B3").setText("asif");
  sheet.getRangeByName("C3").setText("male");
  sheet.getRangeByName("D3").setText("03331122334");

  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();
  final String path = (await getApplicationSupportDirectory()).path;
  final String filename = '$path/Output.xlsx';
  final File file = File(filename);
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open(filename);
}
