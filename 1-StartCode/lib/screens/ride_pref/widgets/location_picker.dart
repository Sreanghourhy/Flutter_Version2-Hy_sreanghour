import 'package:flutter/material.dart';
import 'package:flutter2_assignment/dummy_data/dummy_data.dart';
import 'package:flutter2_assignment/model/ride/locations.dart';
import 'package:flutter2_assignment/theme/theme.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final TextEditingController _controller = TextEditingController();
  List<Location> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_filterLocations);
  }

  @override
  void dispose() {
    _controller.removeListener(_filterLocations);
    _controller.dispose();
    super.dispose();
  }

  void _filterLocations() {
    final query = _controller.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredLocations = [];
      } else {
        filteredLocations = fakeLocations.where((location) {
          final locationName = location.name.toLowerCase();
          return locationName.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: BlaColors.greyLight,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.only(left: 10),
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Station Road or The Bridge Cafe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: BlaColors.greyLight,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16),
                      suffixIcon: _controller.text.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _controller.clear();
                              },
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredLocations.isEmpty
                ? Center(
                    child: Text(
                      _controller.text.isEmpty
                          ? "Start typing to search for locations"
                          : "No locations found",
                      style: BlaTextStyles.button.copyWith(
                        color: BlaColors.textLight,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: filteredLocations.length,
                    itemBuilder: (context, index) {
                      final location = filteredLocations[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(location.name),
                            subtitle: Text(location.country.name),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              print("Selected location: ${location.name}");
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
