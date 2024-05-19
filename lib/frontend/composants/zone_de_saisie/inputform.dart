import 'package:flutter/material.dart';

class Input {
  static Padding buildInputForm(String label, IconData prefixIcon, bool pass,
      TextEditingController controller) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(30),
    );

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        obscureText: pass,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: border,
          enabledBorder: border,
          prefixIcon: Icon(
            prefixIcon,
            color: const Color(0xFF66DED4),
          ),
          suffixIcon: pass
              ? IconButton(
                  onPressed: () {
                    // Toggle password visibility
                  },
                  icon: Icon(
                    pass ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xFF66DED4),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
