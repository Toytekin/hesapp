import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hesapp/constant/route.dart';
import 'package:hesapp/cubit/user_add_cubit.dart';
import 'package:hesapp/model/user_model.dart';
import 'package:hesapp/page/BORC/borc_detay/secilen_user_cubit.dart';

class HomeBorc extends StatefulWidget {
  const HomeBorc({super.key});

  @override
  State<HomeBorc> createState() => _HomeBorcState();
}

class _HomeBorcState extends State<HomeBorc> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool searc = true;

  @override
  void initState() {
    super.initState();
    context.read<UserAddCubit>().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.go(AppRoutes.home),
            icon: const Icon(Icons.arrow_back_ios_new)),
        automaticallyImplyLeading: false,
        title: searc
            ? const Text('Borçlu Listem')
            : TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Ara...',
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                  context.read<UserAddCubit>().filterUsers(query);
                },
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                searc = !searc;
                if (searc == false) {
                  _searchQuery = '';
                  _searchController.clear();
                  context.read<UserAddCubit>().getAllUsers();
                }
              });
            },
            icon: Icon(_searchQuery.isEmpty ? Icons.search : Icons.close),
          ),
        ],
      ),
      body: Center(child: BlocBuilder<UserAddCubit, List<UserModel>>(
        builder: (context, state) {
          if (state.isNotEmpty) {
            return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                var item = state[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      context.read<SecilenUserCubit>().secilenUser(item);
                      context.go(AppRoutes.borcDetat);
                    },
                    title: Text(item.userName),
                  ),
                );
              },
            );
          } else {
            return const Text('Kullanıcı bulunamadı');
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(AppRoutes.borcAdd),
        child: const Icon(Icons.add),
      ),
    );
  }
}
