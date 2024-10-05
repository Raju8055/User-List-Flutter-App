  //Name: Raju s
  //phone Number: 8861308362
  //mail id: raju.be.cse78@gmail.com
import 'package:appscrip/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  List<UserModel> _allUsers = [];

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<RefreshUsers>(_onRefreshUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      _allUsers = await userRepository.fetchUsers();
      emit(UserLoaded(_allUsers));
    } catch (e) {
      emit(UserError('Failed to fetch users'));
    }
  }

  Future<void> _onRefreshUsers(RefreshUsers event, Emitter<UserState> emit) async {
    try {
      _allUsers = await userRepository.fetchUsers();
      emit(UserLoaded(_allUsers));
    } catch (e) {
      emit(UserError('Failed to refresh users'));
    }
  }

  Future<void> _onSearchUsers(SearchUsers event, Emitter<UserState> emit) async {
    if (event.query.isEmpty) {
      emit(UserLoaded(_allUsers));
    } else {
      final filteredUsers = _allUsers
          .where((user) => user.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(UserLoaded(filteredUsers));
    }
  }
}
