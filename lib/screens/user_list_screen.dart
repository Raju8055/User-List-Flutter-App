  //Name: Raju s
  //phone Number: 8861308362
  //mail id: raju.be.cse78@gmail.com
import 'package:appscrip/custom_widgets/enveloprefreshindicator.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appscrip/custom_widgets/custom_circular_loader.dart';
import 'package:appscrip/screens/user_details_screen.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.indigo,
        elevation: 0,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search Users...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.white70),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (query) {
                    context.read<UserBloc>().add(SearchUsers(query));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const CustomCircularLoader();
          } else if (state is UserLoaded) {
            return EnvelopRefreshIndicator(
              onRefresh: () async {
                context.read<UserBloc>().add(RefreshUsers());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        leading: CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 141, 154, 231),
                          child: Text(
                            user.name[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          user.email,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailScreen(user: user),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is UserError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          return const Center(
            child: Text(
              'No users found.',
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
