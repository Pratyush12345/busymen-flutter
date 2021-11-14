import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  final Function(String val)? callback;
  Filters({this.callback});
  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  List<bool> selectedFilters = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              widget.callback!('Political');

              selectedFilters[0] = selected;
              selectedFilters[1] = false;
              selectedFilters[2] = false;
              selectedFilters[3] = false;
              selectedFilters[4] = false;
            });
          },
          elevation: 6,
        ),
        FilterChip(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          selected: selectedFilters[1],
          backgroundColor: const Color(0xff81B4FE),
          label: const Text('Ward',
              style: TextStyle(color: Colors.white, fontSize: 10)),
          selectedColor: const Color(0xff205072),
          checkmarkColor: Colors.white,
          onSelected: (bool selected) {
            setState(() {
              widget.callback!('Ward');

              selectedFilters[0] = false;
              selectedFilters[1] = selected;
              selectedFilters[2] = false;
              selectedFilters[3] = false;
              selectedFilters[4] = false;
            });
          },
          elevation: 6,
        ),
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
              widget.callback!('Work');

              selectedFilters[0] = false;
              selectedFilters[1] = false;
              selectedFilters[2] = selected;
              selectedFilters[3] = false;
              selectedFilters[4] = false;
            });
          },
          elevation: 6,
        ),
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
              widget.callback!('Business');

              selectedFilters[0] = false;
              selectedFilters[1] = false;
              selectedFilters[2] = false;
              selectedFilters[3] = selected;
              selectedFilters[4] = false;
            });
          },
          elevation: 6,
        ),
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
              widget.callback!('Extra');

              selectedFilters[0] = false;
              selectedFilters[1] = false;
              selectedFilters[2] = false;
              selectedFilters[3] = false;
              selectedFilters[4] = selected;
            });
          },
          elevation: 6,
        ),
      ],
    );
  }
}
