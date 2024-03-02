import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


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
      body : SfPdfViewer.network("https://bhajanavali.github.io/book_compressed.pdf", pageLayoutMode: PdfPageLayoutMode.continuous, scrollDirection: PdfScrollDirection.horizontal)
      //SfPdfViewer.asset('assets/lyrics/book.pdf', pageLayoutMode: PdfPageLayoutMode.continuous, scrollDirection: PdfScrollDirection.horizontal)
    );
  }
}
