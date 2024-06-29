import 'package:databases_final_project/database/database_handler.dart';
import 'package:databases_final_project/models/member.dart';
import 'package:databases_final_project/ui/form.dart';
import 'package:databases_final_project/ui/member_profile_page.dart';
import 'package:flutter/material.dart';

class MemberBuilder extends StatefulWidget {
  const MemberBuilder({super.key});

  @override
  State<StatefulWidget> createState() => _MemberState();
}

class _MemberState extends State<MemberBuilder> {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  final TextEditingController _searchController = TextEditingController();
  late bool extendFAB;
  late Future<List<Member>> _members;

  Future<List<Member>> _getMembers() async {
    return await _databaseHandler.getMembers();
  }

  Future<List<Member>> _searchMembers(String keyword) async {
    return await _databaseHandler.searchMembers(keyword);
  }

  Future resetMembers() async => setState(() {
        _searchController.text = '';
        _members = _getMembers();
      });

  Future filterMembers(String keyword) async => setState(() {
        _members = _searchMembers(keyword);
      });

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    extendFAB = MediaQuery.of(context).size.width >= 700;
  }

  @override
  void initState() {
    super.initState();
    _members = _getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        isExtended: extendFAB,
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FormPage()))
              .then((_) => resetMembers());
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Record'),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverAppBar(
            title: TextField(
              controller: _searchController,
              onChanged: (value) => filterMembers(value),
              decoration: InputDecoration(
                hintText: 'Search records',
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
            child: FutureBuilder<List<Member>>(
                future: _members,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (contex, index) {
                      Member member = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MemberProfilePage(member: member)))
                              .then((_) => resetMembers());
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            child: member.generateIcon(),
                          ),
                          title: Text(member.memberName),
                          subtitle: Text(member.formatMid()),
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
