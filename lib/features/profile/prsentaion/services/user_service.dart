import 'package:devti_agro/core/strings/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devti_agro/features/user/aplication/bloc/delete_add_update_user/delete_add_update_user_bloc.dart';
import 'package:devti_agro/features/user/aplication/model/user_model.dart';
import 'package:devti_agro/features/user/aplication/bloc/get_user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';

class UserService {
  final BuildContext context;

  UserService({required this.context});

  Future<bool> addUser(UserModel userModel) async {
    try {
      final deleteBloc = BlocProvider.of<AddDeleteUpdateUserBloc>(context);

      // Add user event
      deleteBloc.add(AddUserEvent(user: userModel));

      final state = await deleteBloc.stream.firstWhere(
        (state) => state is ErrorAddDeleteUpdateUserState || state is MessageAddDeleteUpdateUserState,
        orElse: () {
          // print("No relevant state received.");
          return const ErrorAddDeleteUpdateUserState(message: 'Unknown error.');
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        // print("Timeout occurred.");
        return const ErrorAddDeleteUpdateUserState(message: 'Timeout error.');
      });

      if (state is MessageAddDeleteUpdateUserState) {
        // print("Message state received: ${state.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User added successfully.'),
          ),
        );

        context.read<UserBloc>().add(RefreshUserEvent());

        return true;
      } else if (state is ErrorAddDeleteUpdateUserState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add user.'),
          ),
        );

        print("Error state received: ${state.message}");
      }

      return false;
    } catch (e) {
      print("Exception occurred: $e");
      return false;
    }
  }

  Future<void> updateUser(UserModel userModel) async {
    final bloc = BlocProvider.of<AddDeleteUpdateUserBloc>(context);

    bloc.add(UpdateUserEvent(user: userModel));

    final state = await bloc.stream.firstWhere(
      (state) => state is ErrorAddDeleteUpdateUserState || state is MessageAddDeleteUpdateUserState,
    );

    if (state is MessageAddDeleteUpdateUserState && state.message == UPDATE_SUCCESS_MESSAGE) {
      print("User updated successfully.");
    } else {
      print('Failed to update user.');
    }
  }
}
