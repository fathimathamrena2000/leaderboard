import 'package:flutter/material.dart';

class ListUsers extends StatelessWidget {
  final String rank;
  final String img;
  final String name;
  final String score;

  const ListUsers({
    super.key,
    required this.img,
    required this.name,
    required this.rank,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: Text(
                  rank,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ClipOval(
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  img,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  score,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
