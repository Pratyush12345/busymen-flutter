import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

class ContactTile extends StatefulWidget {
  late final Map<String, bool> contactMap;
  final String contact;
  ContactTile(this.contact, this.contactMap);
  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(widget.contact),
        value: widget.contactMap[widget.contact],
        tileColor: const Color(0xffF3F3F3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onChanged: (val) {
          setState(() {
            if (widget.contactMap[widget.contact] == true) {
              widget.contactMap[widget.contact] = false;
            } else {
              widget.contactMap[widget.contact] = true;
            }
          });
        });
  }
}
