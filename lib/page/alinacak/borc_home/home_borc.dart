import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hesapp/constant/route.dart';

class HomeBorc extends StatefulWidget {
  const HomeBorc({super.key});

  @override
  State<HomeBorc> createState() => _HomeBorcState();
}

class _HomeBorcState extends State<HomeBorc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.go(AppRoutes.home),
            icon: const Icon(Icons.arrow_back_ios_new)),
        automaticallyImplyLeading: false,
        title: const Text('Borçlu Listem'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Deneme'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(AppRoutes.borcAdd),
        child: const Icon(Icons.add),
      ),
    );
  }

  String formatDatetime(DateTime datetime) {
    return "${datetime.day}/${datetime.month}/${datetime.year} ";
  }
}
