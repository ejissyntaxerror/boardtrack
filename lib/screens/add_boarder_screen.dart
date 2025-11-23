import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import '../data/repositories/boarder_repository_impl.dart';
import '../models/boarder_model.dart';

class AddBoarderScreen extends StatefulWidget {
  const AddBoarderScreen({super.key});

  @override
  State<AddBoarderScreen> createState() => _AddBoarderScreenState();
}

class _AddBoarderScreenState extends State<AddBoarderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roomController = TextEditingController();
  final _rentController = TextEditingController();
  final BoarderRepositoryImpl _repository = GetIt.I<BoarderRepositoryImpl>();

  Future<void> _addBoarder() async {
    if (_formKey.currentState!.validate()) {
      final boarder = BoarderModel(
        id: const Uuid().v4(),
        name: _nameController.text,
        room: _roomController.text,
        rent: _rentController.text,
      );
      final result = await _repository.addBoarder(boarder);
      result.fold(
        (failure) => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message))),
        (_) => Navigator.pop(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Boarder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: _roomController,
                decoration: const InputDecoration(labelText: 'Room Number'),
                validator: (value) => value!.isEmpty ? 'Enter room' : null,
              ),
              TextFormField(
                controller: _rentController,
                decoration: const InputDecoration(labelText: 'Monthly Rent'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    double.tryParse(value!) == null ? 'Enter valid rent' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addBoarder,
                child: const Text('Add Boarder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
