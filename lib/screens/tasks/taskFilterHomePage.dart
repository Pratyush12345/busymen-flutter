import 'package:flutter/material.dart';

class HomePageFilters extends StatefulWidget {
  final Function(String val)? callback;
  final bool? isedit;
  final String? category;
  HomePageFilters({this.callback, required this.isedit, this.category});
  @override
  State<HomePageFilters> createState() => _HomePageFiltersState();
}

class _HomePageFiltersState extends State<HomePageFilters> {
  List<bool> selectedFilters = [false, false, false, false, false, false, false];
  @override
    void initState() {
      if(widget.isedit!){
        if(widget.category == "Political")
        selectedFilters[0] = true;
        else if(widget.category == "Ward")
        selectedFilters[1] = true;
        else if(widget.category == "Work")
        selectedFilters[2] = true;
        else if(widget.category == "Business")
        selectedFilters[3] = true;
        else if(widget.category == "Extra")
        selectedFilters[4] = true;
        else if(widget.category == "Done")
        selectedFilters[5] = true;
        else if(widget.category == "Undone")
        selectedFilters[6] = true;

      }
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FilterChip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            selected: selectedFilters[0],
            backgroundColor: const Color(0xff81B4FE),
            label: const Text('Political',
                style: TextStyle(color: Colors.white, fontSize: 10)),
            selectedColor: const Color(0xff205072),
            checkmarkColor: Colors.white,
            onSelected: (bool selected) {
              setState(() {
                if(selected)
                widget.callback!('Political');
                else
                widget.callback!('');

                selectedFilters[0] = selected;
                selectedFilters[1] = false;
                selectedFilters[2] = false;
                selectedFilters[3] = false;
                selectedFilters[4] = false;
                selectedFilters[5] = false;
                selectedFilters[6] = false;
              });
            },
            elevation: 2,
          ),
          SizedBox(width: 10.0,),
          FilterChip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            selected: selectedFilters[1],
            backgroundColor: const Color(0xffd1b3ff),
            label: const Text('Ward',
                style: TextStyle(color: Colors.white, fontSize: 10)),
            selectedColor: const Color(0xff205072),
            checkmarkColor: Colors.white,
            onSelected: (bool selected) {
              setState(() {
                
                if(selected)
                widget.callback!('Ward');
                else
                widget.callback!('');
                
                selectedFilters[0] = false;
                selectedFilters[1] = selected;
                selectedFilters[2] = false;
                selectedFilters[3] = false;
                selectedFilters[4] = false;
                selectedFilters[5] = false;
                selectedFilters[6] = false;
              });
            },
            elevation: 2,
          ),
          SizedBox(width: 10.0,),
          FilterChip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color(0xffFEB765),
            selected: selectedFilters[2],
            label: const Text('  Work   ',
                style: TextStyle(color: Colors.white, fontSize: 10)),
            selectedColor: const Color(0xff205072),
            checkmarkColor: Colors.white,
            onSelected: (bool selected) {
              setState(() {
                
                if(selected)
                widget.callback!('Work');
                else
                widget.callback!('');
                
                selectedFilters[0] = false;
                selectedFilters[1] = false;
                selectedFilters[2] = selected;
                selectedFilters[3] = false;
                selectedFilters[4] = false;
                selectedFilters[5] = false;
                selectedFilters[6] = false;
              });
            },
            elevation: 2,
          ),
          SizedBox(width: 10.0,),
          FilterChip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color(0xff5CC581),
            selected: selectedFilters[3],
            label: const Text('Business',
                style: TextStyle(color: Colors.white, fontSize: 10)),
            selectedColor: const Color(0xff205072),
            checkmarkColor: Colors.white,
            onSelected: (bool selected) {
              setState(() {
                
                if(selected)
                widget.callback!('Business');
                else
                widget.callback!('');
                
                selectedFilters[0] = false;
                selectedFilters[1] = false;
                selectedFilters[2] = false;
                selectedFilters[3] = selected;
                selectedFilters[4] = false;
                selectedFilters[5] = false;
                selectedFilters[6] = false;
              });
            },
            elevation: 2,
          ), 
          SizedBox(width: 10.0,),
          FilterChip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color(0xffFF866B),
            selected: selectedFilters[4],
            label: const Text('  Extra  ',
                style: TextStyle(color: Colors.white, fontSize: 10)),
            selectedColor: const Color(0xff205072),
            checkmarkColor: Colors.white,
            onSelected: (bool selected) {
              setState(() {
                
                if(selected)
                widget.callback!('Extra');
                else
                widget.callback!('');
                
                selectedFilters[0] = false;
                selectedFilters[1] = false;
                selectedFilters[2] = false;
                selectedFilters[3] = false;
                selectedFilters[4] = selected;
                selectedFilters[5] = false;
                selectedFilters[6] = false;
              });
            },
            elevation: 2,
          ),
          SizedBox(width: 10.0,),
        FilterChip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color(0xff00ace6),
            selected: selectedFilters[5],
            label: const Text('  Done  ',
                style: TextStyle(color: Colors.white, fontSize: 10)),
            selectedColor: const Color(0xff205072),
            checkmarkColor: Colors.white,
            onSelected: (bool selected) {
              setState(() {
                
                if(selected)
                widget.callback!('Done');
                else
                widget.callback!('');
                
                selectedFilters[0] = false;
                selectedFilters[1] = false;
                selectedFilters[2] = false;
                selectedFilters[3] = false;
                selectedFilters[4] = false;
                selectedFilters[5] = selected;
                selectedFilters[6] = false;
              });
            },
            elevation: 2,
          ),
          SizedBox(width: 10.0,),
          FilterChip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color(0xffcc6699),
            selected: selectedFilters[6],
            label: const Text('  Undone  ',
                style: TextStyle(color: Colors.white, fontSize: 10)),
            selectedColor: const Color(0xff205072),
            checkmarkColor: Colors.white,
            onSelected: (bool selected) {
              setState(() {
                
                if(selected)
                widget.callback!('Undone');
                else
                widget.callback!('');
                
                selectedFilters[0] = false;
                selectedFilters[1] = false;
                selectedFilters[2] = false;
                selectedFilters[3] = false;
                selectedFilters[4] = false;
                selectedFilters[5] = false;
                selectedFilters[6] = selected;
              });
            },
            elevation: 2,
          ),
          SizedBox(width: 10.0,),
        ],

      ),
    );
  }
}
