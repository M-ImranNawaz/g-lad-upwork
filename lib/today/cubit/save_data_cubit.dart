import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/today/model/today_model.dart';

part 'save_data_state.dart';

class SaveDataCubit extends Cubit<SaveDataState> {
  // final _dbRef = FirebaseFirestore.instance;

  SaveDataCubit() : super(SaveDataInitial());

  TextEditingController gratefulC = TextEditingController();
  TextEditingController learnedC = TextEditingController();
  TextEditingController appreciatedC = TextEditingController();
  TextEditingController delightedC = TextEditingController();

  onAddData() async {
    if (gratefulC.text.isEmpty ||
        appreciatedC.text.isEmpty ||
        learnedC.text.isEmpty ||
        delightedC.text.isEmpty) {
      emit(SaveDataValidFailure('All fields are required'));
      return;
    }
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      emit(SaveDataFailure("User not logged in"));
      return;
    }
    final data = TodayModel(
      grateful: gratefulC.text,
      learned: learnedC.text,
      appreciated: appreciatedC.text,
      delighted: delightedC.text,
      date: DateTime.now().toString(), // Format this as needed
    );
    emit(SaveDataLoading());
    try {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      CollectionReference todayCollection = userDoc.collection('todayData');

      await todayCollection.add(data.toMap());
      emit(SaveDataSuccess());
    } catch (e) {
      emit(SaveDataFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    gratefulC.dispose();
    learnedC.dispose();
    appreciatedC.dispose();
    delightedC.dispose();
    return super.close();
  }
}
