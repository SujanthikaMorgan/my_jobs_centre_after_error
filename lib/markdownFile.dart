import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html2md/html2md.dart' as html2md;

class MarkDownTest extends StatelessWidget {
  final String description;
  const MarkDownTest({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: MarkdownBody(
          data: html2md.convert(description),
        ),
      ),
    );
  }
}
