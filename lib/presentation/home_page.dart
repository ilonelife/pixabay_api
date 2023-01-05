import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixabay/data/pixabay_api.dart';
import 'package:pixabay/model/pixabay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pixabay> _pixabay = [];

  final _api = PixabayApi();
  final _textEditingController = TextEditingController();

  Future _showResult(String query) async {
    List<Pixabay> pixabay = await _api.fetchPixabay(query);
    setState(() {
      _pixabay = pixabay;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _showResult('car');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pixabay : 이미지 검색',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    _showResult(_textEditingController.text);
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SizedBox(
                width: double.infinity,
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: 30,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  itemBuilder: (context, idx) => Image.network(
                    _pixabay[idx % 10].previewURL,
                    fit: BoxFit.cover,
                  ),
                  staggeredTileBuilder: (idx) =>
                      (idx % 6 == 0 || (idx - 4) % 6 == 0)
                          ? const StaggeredTile.count(2, 2)
                          : const StaggeredTile.count(1, 1),
                )),
          ),
        ],
      ),
    );
  }
}
