import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_todo_app/data/database.dart';
import 'package:fe_todo_app/data/repository/todo_repository.dart';
import 'package:fe_todo_app/widgets/add_todo.dart';
import 'package:fe_todo_app/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward(from: 0);
  late final AnimationController _offsetController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward(from: 0);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 2.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _offsetController,
    curve: Curves.elasticIn,
  ));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _offsetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
        backgroundColor: Color(0xFF6cb4b1),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "TODO APP",
                      style: TextStyle(
                          color: Color(0xFF707070),
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 14),
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context, builder: (_) => AddTodo());
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shape: CircleBorder(),
                      primary: Color(0xFF04a3a3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                decoration: BoxDecoration(
                    color: Color(0xFF6cb4b1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(38),
                      topRight: Radius.circular(38),
                    )),
                child: StreamBuilder<QuerySnapshot>(
                    stream: Database.readTodos(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("Something went wrong!"));
                      } else if (snapshot.hasData || snapshot.data != null) {
                        return SlideTransition(
                          position: _offsetAnimation,
                          child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              key: UniqueKey(),
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context, index) => Card(
                                elevation: 8,
                                    child: ListTile(
                                      onTap: () {
                                        Provider.of<TodoRepository>(context,
                                                listen: false)
                                            .showSelectedTodo(
                                                snapshot.data!.docs[index].id);
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (_) => TodoItem());
                                      },
                                      title: Text(
                                        snapshot.data!.docs[index].get("title"),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                      subtitle: Text(
                                        snapshot.data!.docs[index]
                                            .get("todoTask"),
                                        style: TextStyle(
                                          color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      trailing: Container(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            var checkStatus = snapshot
                                                .data!.docs[index]
                                                .get("isCompleted");
                                            var docId =
                                                snapshot.data!.docs[index].id;
                                            Database.changeTodoStatus(
                                                docId: docId, isCompleted: !checkStatus);
                                          },
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            primary: snapshot.data!.docs[index]
                                                    .get("isCompleted")
                                                ? Color(0xFF0ecc57)
                                                : Color(0xFF969897),
                                          ),
                                        ),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  )),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ))
        ],
      ),
    );
  }
}
