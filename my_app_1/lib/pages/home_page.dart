import 'package:flutter/material.dart';
import 'package:my_app_1/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List toDoList = [
    ["Learn Flutter", false],
    ["Drink Coffee", false],
    ["Soul Strike", false],
  ];

  //funtion checkbox สำหรับเช็คว่า list ตำแหน่งไหน false หรือ true
  void checkBoxChanged(int index) {
    setState(() {
      //ถ้าfalse จะถูกเซ็ตให้ตรงกันข้าม ถ้าtrue จะถูกเซ็ตให้ตรงกันข้าม
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      //เพิ่มitems เข้าไปในlist โดยเก็บtextจาก controller และส่งfasle ไปในList
      toDoList.add([_controller.text, false]);
    });
  }

  void deleteTask(int index) {
    setState(() {
      //ลบ items ออกจากlist โดยอิงจากค่า index แต่ละอัน
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,

        title: Text("Simple Todo App", style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, index) {
          return TodoList(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFuntion: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // เปิดเส้นกล่องด้านนอกเป็นสีขาว
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Add a new todo items",
                  filled: true,
                  fillColor: Colors.deepPurple.shade200,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              // เปิดเส้นกล่องด้านนอกเป็นสีขาว
            ),
          ),
          FloatingActionButton(onPressed: saveNewTask, child: Icon(Icons.add)),
        ],
      ),
    );
  }
}
