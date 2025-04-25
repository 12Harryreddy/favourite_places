import 'dart:io';

import 'package:favourite_places/model/place.dart';
import 'package:favourite_places/provider/user_places.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/widgets/user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() {
    return _AddPlaceState();
  }
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  final _titleController = TextEditingController();
  PlaceLocation? _selectedlocation;
  File? _selectImage;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _onSave() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty ||
        _selectImage == null ||
        _selectedlocation == null) {
      return;
    }

    ref
        .read(UserPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectImage!, _selectedlocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Place Name',
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInput(
              onPickImage: (image) {
                _selectImage = image;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            UserLocation(
              onPickLocation: (PlaceLocation location) {
                _selectedlocation = location;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _onSave,
              child: const Text('Add place'),
            ),
          ],
        ),
      ),
    );
  }
}
