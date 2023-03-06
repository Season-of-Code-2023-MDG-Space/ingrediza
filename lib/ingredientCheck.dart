import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'main.dart';

class ingredientCheck extends StatefulWidget {
  final String codes;
  ingredientCheck({required this.codes});

  @override
  State<ingredientCheck> createState() => _ingredientCheckState();
}

class _ingredientCheckState extends State<ingredientCheck> {
  void fetchAdditiveInfo(String additiveCodes) async {
    var url = Uri.parse(
        "https://world.openfoodfacts.org/cgi/search.pl?action=process&tagtype_0=additives&tag_contains_0=contains&tag_0=$additiveCodes&sort_by=unique_scans_n&page_size=10&json=1");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var item in data['products']) {
        print(
            "Additive ${item['additives_tags'][0]}: ${item['additives'][item['additives_tags'][0]]['harmful_effects']}");
      }
    } else {
      print("Failed to retrieve additive information: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
            color: Color.fromARGB(255, 5, 46, 6), child: Text('INFORMATION')),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              fetchAdditiveInfo(widget.codes);
            },
            child: Text('do'),
          )
        ],
      ),
    );
  }
}





//   String _productName = '';
//   List<dynamic> _sideEffects = [];
//   final String apiUrl =
//       'https://world.openfoodfacts.org/cgi/search.pl?search_terms=';
//   Future<http.Response> fetchProducts(String ingredient) {
//     String url = apiUrl + ingredient;
//     return http.get(Uri.parse(url));
//   }

//   Future<Map<String, dynamic>> getProducts(String ingredient) async {
//     final response = await fetchProducts(ingredient);
//     final parsed = jsonDecode(response.body);
//     return parsed;
//   }

//   Future<void> checkIngredient(String ingredient) async {
//     final products = await getProducts(ingredient);
//     if (products['products'].length > 0) {
//       final product = products['products'][0];
//       final name = product['product_name'];
//       final sideEffects = product['allergens_from_ingredients'];
//       print('$name may cause the following side effects: $sideEffects');
//     } else {
//       print('No products found containing $ingredient');
//     }
//   }

//   void initState() {
//     super.initState();
//     checkIngredient(widget.codes);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Title(
//             color: Color.fromARGB(255, 5, 46, 6), child: Text('INFORMATION')),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Product Name: $_productName'),
//           Text('Side Effects: ${_sideEffects.join(', ')}'),
//         ],
//       ),
//     );
//   }
// }
