import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

class PdfViewScreen extends StatefulWidget {
  final String path;

  const PdfViewScreen({super.key, required this.path});

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool _isReady = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Newsletter"),
        backgroundColor: Colors.teal[100],
        foregroundColor: Colors.teal[900],
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages!;
                _isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                _errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                _errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              setState(() {
                _isReady = true;
              });
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                _currentPage = page!;
              });
            },
          ),
          !_isReady
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : _errorMessage.isEmpty
              ? Container()
              : Center(
            child: Text(_errorMessage),
          ),
        ],
      ),
      floatingActionButton: _isReady
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (_currentPage > 0)
            FloatingActionButton.extended(
              backgroundColor: Colors.teal[300],
              label: const Text("Previous"),
              onPressed: () {
                setState(() {
                  _currentPage--;
                });
              },
            ),
          if (_currentPage < _totalPages - 1)
            FloatingActionButton.extended(
              backgroundColor: Colors.teal[300],
              label: const Text("Next"),
              onPressed: () {
                setState(() {
                  _currentPage++;
                });
              },
            ),
        ],
      )
          : null,
    );
  }
}
