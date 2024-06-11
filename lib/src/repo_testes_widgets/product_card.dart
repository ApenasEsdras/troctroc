import 'package:flutter/material.dart';
import '../styles/colors_app.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final num price;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'R\$ ${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 145, 0),
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorsApp.instance.Laranja,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
