import 'package:flutter/material.dart';

class Winner extends StatelessWidget {
  final bool isFirst;
  final Color myColor;

  final double height;
  final String img;
  final String name;
  final String score;
  final String rank;

  const Winner(
      {super.key,
      required this.isFirst,
      required this.height,
      required this.myColor,
      required this.img,
      required this.name,
      required this.score,
      required this.rank});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                height: height,
                width: MediaQuery.of(context).size.width * 0.32,
                decoration: BoxDecoration(
                  color: myColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        score,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: myColor, width: 3),
                      image: DecorationImage(
                        image: NetworkImage(img),
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              if (isFirst)
                Image.asset(
                  'assets/crown.png',
                  height: 40,
                  width: 125,
                ),
              Padding(
                padding: const EdgeInsets.only(top: 120, left: 55),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      rank,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
