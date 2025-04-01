import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart'; // Import FruitProvider and Fruit model

class FruitForm extends StatefulWidget {
  final Fruit? fruit; // Pass a fruit object if editing, null if adding

  const FruitForm({Key? key, this.fruit}) : super(key: key);

  @override
  _FruitFormState createState() => _FruitFormState();
}

class _FruitFormState extends State<FruitForm> {
  final _formKey = GlobalKey<FormState>();
  late String _color;
  late double _price;

  @override
  void initState() {
    super.initState();
    _color = widget.fruit?.color ?? '';
    _price = widget.fruit?.price ?? 0.0;
  }

  void _saveForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final fruitProvider = context.read<FruitProvider>();

      if (widget.fruit == null) {
        // Add new fruit
        fruitProvider.addFruit(_color, _price);
      } else {
        // Edit existing fruit (mock repository only for now)
        final index = fruitProvider.fruitsState!.data!.indexWhere(
          (fruit) => fruit.id == widget.fruit!.id,
        );
        if (index != -1) {
          fruitProvider.fruitsState!.data![index] = Fruit(
            id: widget.fruit!.id,
            color: _color,
            price: _price,
          );
          fruitProvider.notifyListeners();
        }
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fruit == null ? 'Add Fruit' : 'Edit Fruit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _color,
                decoration: InputDecoration(labelText: 'Color'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a color';
                  }
                  return null;
                },
                onSaved: (value) {
                  _color = value!;
                },
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveForm(context),
                child: Text(widget.fruit == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
