import 'package:flutter/material.dart';

class HeroAnimtion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Hero Animation"
      //   ),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login_bg.png"),
            fit: BoxFit.fill,
          )
        ),
        child: Stack(
          children: [
            ListView.builder(
                itemBuilder: (context, index) {
                  return HeroItem(index);
                },
              itemCount: 20,
              // controller: ,
            )
          ],
        ),
      )
    );
  }

  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }
}

// class _HeroAnimtionState extends State<HeroAnimtion> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
// }


class HeroItem extends StatelessWidget {
  final int index;
  const HeroItem(this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:  Text('Item $index'),
      leading: Hero(
        createRectTween: (begin, end) {
          return MaterialRectArcTween(begin: begin, end: end);
        },
        tag: "hero-item-$index",
        child: const Image(
          image: AssetImage("images/small.png"),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return ImageDetail(index);
                }
            )
        );
      },
    );
  }
}

class ImageDetail extends StatelessWidget {
  final int index;
  const ImageDetail(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        createRectTween: (begin, end) {
          return MaterialRectArcTween(begin: begin, end: end);
        },
        tag: "hero-item-$index",
        child: Center(
          child: GestureDetector(
            child: const Image(
              image: AssetImage("images/big.png"),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )

        ),
      ),
    );
  }

}