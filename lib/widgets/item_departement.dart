
import 'package:flutter/material.dart';

class ItemDepartement extends StatelessWidget{
  final String image;
  final String titre;
  const ItemDepartement({Key? key, required this.image, required this.titre}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.blue,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(image),
                ),
            ),
          ),
          Center(
            child: Text(
              titre,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }}