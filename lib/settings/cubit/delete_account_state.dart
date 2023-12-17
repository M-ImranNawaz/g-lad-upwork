part of 'delete_account_cubit.dart';

abstract class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountSuccess extends DeleteAccountState {}

class DeleteAccountFailure extends DeleteAccountState {
  final String error;
  DeleteAccountFailure(this.error);
}

class DeleteAccountValidFailure extends DeleteAccountState {
  final String error;
  DeleteAccountValidFailure(this.error);
}
