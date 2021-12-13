import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BufferScreen extends StatefulWidget {
  @override
  State<BufferScreen> createState() => _BufferScreenState();
}

class _BufferScreenState extends State<BufferScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          "Scan",
        ),
      );
  }
}
