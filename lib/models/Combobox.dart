import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomComboBoxFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final List<String> options;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const CustomComboBoxFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.options,
    this.onChanged,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  _CustomComboBoxFormFieldState createState() => _CustomComboBoxFormFieldState();
}

class _CustomComboBoxFormFieldState extends State<CustomComboBoxFormField> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedOption,
      onChanged: (newValue) {
        setState(() {
          selectedOption = newValue;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
      onSaved: widget.onSaved,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: SvgPicture.asset(
          'assets/icons/User.dart.svg',
          color: Colors.grey,
          width: 20,
        ),
      ),
      items: widget.options.map<DropdownMenuItem<String>>((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    );
  }
}
