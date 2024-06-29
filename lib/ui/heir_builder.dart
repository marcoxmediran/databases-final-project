import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/heir.dart';
import 'package:flutter/material.dart';

class HeirBuilder extends StatefulWidget {
  const HeirBuilder({super.key});

  @override
  State<StatefulWidget> createState() => _HeirState();
}

class _HeirState extends State<HeirBuilder> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Heir>> _heirs;

  Future<List<Heir>> _getHeirs() async {
    return await _databaseHandler.getHeirs();
  }

  Future<List<Heir>> _searchHeirs(String keyword) async {
    return await _databaseHandler.searchHeirs(keyword);
  }

  Future searchHeirs(String keyword) async => setState(() {
        _heirs = _searchHeirs(keyword);
      });

  @override
  void initState() {
    super.initState();
    _heirs = _getHeirs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverAppBar(
            title: TextField(
              controller: _searchController,
              onChanged: (value) => searchHeirs(value),
              decoration: InputDecoration(
                hintText: 'Search heirs',
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 4),
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.search)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(128),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverFillRemaining(
            child: FutureBuilder<List<Heir>>(
                future: _heirs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (contex, index) {
                      Heir heir = snapshot.data![index];
                      return InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(heir.heirName),
                          subtitle: Text(heir.formatKey()),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
