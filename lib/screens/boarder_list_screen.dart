import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../data/repositories/boarder_repository_impl.dart';
import '../models/boarder_model.dart';
import 'add_boarder_screen.dart';

class BoarderListScreen extends StatefulWidget {
  const BoarderListScreen({super.key});

  @override
  State<BoarderListScreen> createState() => _BoarderListScreenState();
}

class _BoarderListScreenState extends State<BoarderListScreen> {
  final BoarderRepositoryImpl _repository = GetIt.I<BoarderRepositoryImpl>();
  List<BoarderModel> _boarders = [];

  @override
  void initState() {
    super.initState();
    _loadBoarders();
  }

  Future<void> _loadBoarders() async {
    final result = await _repository.getBoarders();
    result.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(failure.message)),
      ),
      (boarders) => setState(() => _boarders = boarders),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boarder List')),
      body: ListView.builder(
        itemCount: _boarders.length,
        itemBuilder: (context, index) {
          final boarder = _boarders[index];
          return ListTile(
            title: Text(boarder.name),
            subtitle: Text('Room: ${boarder.room}, Rent: \$${boarder.rent}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddBoarderScreen()),
          );
          _loadBoarders(); // Refresh list after adding
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}