import 'package:busyman/services/sizeconfig.dart';
import 'package:flutter/material.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late App _app = App(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Task Details',
          style: TextStyle(color: Color(0xff297687)),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff297687),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          const Text(
            "Name of the Task",
            style: TextStyle(
                color: Color(0xff297687),
                fontWeight: FontWeight.w700,
                fontSize: 20),
          ),
          SizedBox(
            height: _app.appVerticalPadding(1.0),
          ),
          const Text(
            "Name of the Task",
            style: TextStyle(
                color: Color(0xff858585),
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          SizedBox(
            height: _app.appVerticalPadding(1.0),
          ),
          FilterChip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color(0xff81B4FE),
            label:
                const Text('Political', style: TextStyle(color: Colors.white)),
            selectedColor: Colors.purpleAccent,
            onSelected: (bool selected) {},
            elevation: 6,
          ),
          SizedBox(
            height: _app.appVerticalPadding(3.0),
          ),
          Row(
            children: [
              Icon(Icons.arrow_forward_ios),
              Icon(Icons.arrow_forward_ios),
              SizedBox(
                width: _app.appHorizontalPadding(2),
              ),
              Text("Start"),
              Text("22 Oct 2020"),
              Text("12:00 pm"),
            ],
          ),
          SizedBox(
            height: _app.appVerticalPadding(0.5),
          ),
          Row(
            children: [
              const Icon(Icons.arrow_forward_ios),
              const Icon(Icons.arrow_forward_ios),
              SizedBox(
                width: _app.appHorizontalPadding(2),
              ),
              const Text("Start"),
              const Text("22 Oct 2020"),
              const Text("12:00 pm"),
            ],
          ),
          SizedBox(
            height: _app.appVerticalPadding(3.0),
          ),
          const Text("Working for: Gaurav Maheshwari"),
          SizedBox(
            height: _app.appVerticalPadding(2.0),
          ),
          const Text("Assigned to"),
        ],
      )),
    );
  }
}
