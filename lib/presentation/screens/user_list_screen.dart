import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo_project/presentation/viewmodels/user_list_provider.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListState();
}

class _UserListState extends ConsumerState<UserListScreen> {
  late UserListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = ref.watch(getUsersProvider);
    provider.init();

    return Scaffold(
      appBar: AppBar(title: const Text("Users"),),
      body: provider.haveData
          ? Padding(
          padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network("${provider.list[index].avatar}")
                    ),
                    title: Text('${provider.list[index].firstName}'),
                    subtitle: Text('${provider.list[index].lastName}')
                  );
                }
              )
            ],
          ),
        ),
      )
          :const Center(child: CircularProgressIndicator())
    );
  }
}
