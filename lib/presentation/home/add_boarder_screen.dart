import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../data/models/boarder_model.dart';
import 'home_providers.dart';

class AddBoarderScreen extends ConsumerStatefulWidget {
  const AddBoarderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddBoarderScreen> createState() => _AddBoarderScreenState();
}

class _AddBoarderScreenState extends ConsumerState<AddBoarderScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  String _genId() {
    final rnd = Random().nextInt(99999);
    return '${DateTime.now().millisecondsSinceEpoch}_$rnd';
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(homeControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Boarder')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
              ),
              const SizedBox(height: 8),
              FormBuilderTextField(
                name: 'room',
                decoration: const InputDecoration(labelText: 'Room number'),
                validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
              ),
              const SizedBox(height: 8),
              FormBuilderTextField(
                name: 'rent',
                decoration: const InputDecoration(labelText: 'Monthly rent'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.numeric(context),
                  FormBuilderValidators.min(context, 0.0),
                ]),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final ok = _formKey.currentState?.saveAndValidate() ?? false;
                      if (!ok) return;
                      final values = _formKey.currentState!.value;
                      final boarder = Boarder(
                        id: _genId(),
                        name: values['name'] as String,
                        room: values['room'] as String,
                        rent: double.tryParse('${values['rent']}') ?? 0.0,
                      );
                      await controller.addBoarder(boarder);
                      // return to dashboard
                      if (context.mounted) Navigator.of(context).pop(true);
                    },
                    child: const Text('Save'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final ok = _formKey.currentState?.saveAndValidate() ?? false;
                      if (!ok) return;
                      final values = _formKey.currentState!.value;
                      final boarder = Boarder(
                        id: _genId(),
                        name: values['name'] as String,
                        room: values['room'] as String,
                        rent: double.tryParse('${values['rent']}') ?? 0.0,
                      );
                      await controller.addBoarder(boarder);
                      // keep form for adding another
                      _formKey.currentState?.reset();
                    },
                    child: const Text('Save & Add Another'),
                  ),
                  const Spacer(),
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
