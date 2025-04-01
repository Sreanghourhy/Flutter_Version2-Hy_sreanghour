// REPOSITORY
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'async_value.dart';
import 'fruit_form.dart';

// REPOS
abstract class FruitRepository {
  Future<Fruit> addFruit({required String color, required double price});
  Future<List<Fruit>> getFruits();
  Future<void> removeFruit(String id);
}

class FirebaseFruitRepository extends FruitRepository {
  static const String baseUrl =
      'https://week8-beceb-default-rtdb.asia-southeast1.firebasedatabase.app';
  static const String fruitsCollection = "fruits";
  static const String allFruitsUrl = '$baseUrl/$fruitsCollection.json';

  @override
  Future<Fruit> addFruit({required String color, required double price}) async {
    Uri uri = Uri.parse(allFruitsUrl);

    final newFruitData = {'color': color, 'price': price};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newFruitData),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add user');
    }

    final newId = json.decode(response.body)['name'];

    return Fruit(id: newId, color: color, price: price);
  }

  @override
  Future<List<Fruit>> getFruits() async {
    Uri uri = Uri.parse(allFruitsUrl);
    final http.Response response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load');
    }

    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];
    return data.entries
        .map((entry) => FruitDto.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  Future<void> removeFruit(String id) async {
    final Uri uri = Uri.parse('$baseUrl/$fruitsCollection/$id.json');
    final http.Response response = await http.delete(uri);

    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.noContent) {
      throw Exception('Failed to delete fruit');
    }
  }
}

class MockFruitRepository extends FruitRepository {
  final List<Fruit> fruits = [];

  @override
  Future<Fruit> addFruit({required String color, required double price}) {
    return Future.delayed(Duration(seconds: 1), () {
      Fruit newFruit = Fruit(id: "0", color: color, price: 12);
      fruits.add(newFruit);
      return newFruit;
    });
  }

  @override
  Future<List<Fruit>> getFruits() {
    return Future.delayed(Duration(seconds: 1), () => fruits);
  }

    @override
  Future<void> removeFruit(String id) {
    return Future.delayed(Duration(seconds: 1), () {
      fruits.removeWhere((fruit) => fruit.id == id);
    });
  }

}

// MODEL & DTO
class FruitDto {
  static Fruit fromJson(String id, Map<String, dynamic> json) {
    return Fruit(id: id, color: json['color'], price: json['price']);
  }

  static Map<String, dynamic> toJson(Fruit fruit) {
    return {'name': fruit.color, 'price': fruit.price};
  }
}

// MODEL
class Fruit {
  final String id;
  final String color;
  final double price;

  Fruit({required this.id, required this.color, required this.price});

  @override
  bool operator ==(Object other) {
    return other is Fruit && other.id == id;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode;
}

// PROVIDER
class FruitProvider extends ChangeNotifier {
  final FruitRepository _repository;
  AsyncValue<List<Fruit>>? fruitsState;

  FruitProvider(this._repository) {
    fetchUsers();
  }

  bool get isLoading =>
      fruitsState != null && fruitsState!.state == AsyncValueState.loading;
  bool get hasData =>
      fruitsState != null && fruitsState!.state == AsyncValueState.success;

  void fetchUsers() async {
    try {
      fruitsState = AsyncValue.loading();
      notifyListeners();

      fruitsState = AsyncValue.success(await _repository.getFruits());

      print("SUCCESS: list size ${fruitsState!.data!.length.toString()}");
    } catch (error) {
      print("ERROR: $error");
      fruitsState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void addFruit(String color, double price) async {
    _repository.addFruit(color: color, price: price);
    fetchUsers();
  }

void removeFruit(String id) async {
    try {
      await _repository.removeFruit(id);
      fetchUsers(); // Refresh the list after removal
    } catch (error) {
      print("ERROR: $error");
    }
  }

}

class App extends StatelessWidget {
  const App({super.key});

  void _onAddPressed(BuildContext context) {
    Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const FruitForm(),
     )
    );
  }

  @override
  Widget build(BuildContext context) {
    final fruitProvider = Provider.of<FruitProvider>(context);

    Widget content = Text('');
    if (fruitProvider.isLoading) {
      content = CircularProgressIndicator();
    } else if (fruitProvider.hasData) {
      List<Fruit> fruits = fruitProvider.fruitsState!.data!;

      if (fruits.isEmpty) {
        content = Text("No data yet");
      } else {
        content = ListView.builder(
          itemCount: fruits.length,
          itemBuilder:
              (context, index) => ListTile(
                title: Text(fruits[index].color),
                subtitle: Text("${fruits[index].price}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FruitForm(fruit: fruits[index]),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.blue),
                      onPressed: () {
                        fruitProvider.removeFruit(fruits[index].id);
                      },
                    ),
                  ],
                ),
              ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => _onAddPressed(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(child: content),
    );
  }
}

// 5 - MAIN
void main() async {
  final FruitRepository fruitRepository = FirebaseFruitRepository();

  runApp(
    ChangeNotifierProvider(
      create: (context) => FruitProvider(fruitRepository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const App()),
    ),
  );
}
