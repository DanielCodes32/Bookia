import 'package:flutter/material.dart';

void errordiag(BuildContext context, String message) {
  ScaffoldMessenger.of( context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    content: Text(message)));
}