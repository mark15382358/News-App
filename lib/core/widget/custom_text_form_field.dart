import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
   CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.validator,
    this.maxLines = 1,
    this.suffix,
    this.obsecureText=false ,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final Function(String?)? validator;
  final int? maxLines;
  final Widget? suffix;
  final bool obsecureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

bool isVisible = false;

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          style: Theme.of(context).textTheme.labelMedium,
          maxLines: widget.maxLines,
          validator: widget.validator != null
              ? (String? value) => widget.validator!(value)
              : null,
          obscureText: widget.obsecureText&&!isVisible,
          decoration: InputDecoration(
            hintText: widget.hintText,

            suffixIcon:widget.obsecureText?
             IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon: isVisible
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
            ):null,
          ),
        ),
      ],
    );
  }
}
