import 'package:bhajanavali/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';


class BhajanLyricsScreen extends StatefulWidget {
  const BhajanLyricsScreen({super.key});

  @override
  State<BhajanLyricsScreen> createState() => _BhajanLyricsScreenState();
}

class _BhajanLyricsScreenState extends State<BhajanLyricsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body : SfPdfViewer.file(File(pdfFilePath), pageLayoutMode: PdfPageLayoutMode.continuous, scrollDirection: PdfScrollDirection.horizontal)
    );
  }
}
