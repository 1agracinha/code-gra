import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: First()));
}

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Get.snackbar("Hi", "I'm modern snackbar");
          },
        ),
        title: Text('First Route'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<Controller>( // You only need to initialize your controller the first time you use it. Don't use init in your other GetBuilders anymore
                init: Controller(),
                builder: (s) => Text(
                      'clicks: ${s.count}',
                    )),
            RaisedButton(
              child: Text('Next Route'),
              onPressed: () {
                // use Get.to to navigate to Second Screen
                Get.to(Second());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Controller.to.increment();
          }),
    );
  }
}

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second Route'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<Controller>(
              // no init
              builder: (_) => Text('${_.count}'),
            ),
            RaisedButton(
              child: Text("Go to last page"),
              onPressed: () {
                Get.to(Third());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Controller.to.increment();
          }),
    );
  }
}

class Third extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Route"),
      ),
      body: Center(
        // you can use this syntax too
        child: Text("Clicks: ${Get.find<Controller>().count}"),
      ),
    );
  }
}

class Controller extends GetController {
  /// You definitely don't need to use this method.
  /// I use it because it facilitates a lot in productivity
  /// when I have dozens of references to a controller.
  /// In order to use the Get.find<Controller>().count syntax
  /// you can take advantage of the IDE's autocomplete
  /// and type without typing the type like this:
  /// Controller.to.count
  static Controller get to => Get.find();

  int count = 0;
  void increment() {
    count++;

    /// use update method to update all count variables
    update(this);
  }
}