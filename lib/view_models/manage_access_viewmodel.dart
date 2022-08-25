import 'dart:async';

import 'package:Busyman/models/models.dart';
import 'package:Busyman/screens/Twitter/backend/utils/global_variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ManageAccessVM {
  static ManageAccessVM instance = ManageAccessVM._();
  ManageAccessVM._();
  List<ManageAccountUserModel> listAccountManagedby = [];
  late StreamSubscription<Event> _onDataAddedSubscription;
  late StreamSubscription<Event> _onDataChangedSubscription;
  late StreamSubscription<Event> _onDataRemovedSubscription;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  late Query _query;
  
  init(){
   listAccountManagedby = [];
  }

  disposeAccountManagedByStreams(){
    _onDataAddedSubscription.cancel();
    _onDataChangedSubscription.cancel();
    _onDataRemovedSubscription.cancel();
  }

  onUserAdded(Event event) {
    print("--------added----------");
    print(event.snapshot.exists);
    print(event.snapshot.value);
    print("------------------");
  }
  onUserChanged(Event event) {
    print("---------changed---------");
    print(event.snapshot.exists);
    print(event.snapshot.value);
    print("------------------");
  }
  onUserRemoved(Event event) {
    print("-----------Removed-------");
    print(event.snapshot.exists);
    print(event.snapshot.value);
    print("------------------");
  }
  setQueryOnAccountManagedBy(){
    _query = _database.reference().child("Users/${FirebaseAuth.instance.currentUser!.uid}/OtherAccounts/AccountManagedBy");
    _onDataAddedSubscription = _query.onChildAdded.listen(onUserAdded);
    _onDataChangedSubscription = _query.onChildChanged.listen(onUserChanged);
    _onDataRemovedSubscription = _query.onChildRemoved.listen(onUserRemoved);
  }

  onRemoveAccountManagedBy(String id){
    _database.reference().child("Users/${FirebaseAuth.instance.currentUser!.uid}/OtherAccounts/AccountManagedBy/$id").remove();
  }
  
  onRemoveAccountManagingOf(String id){
    _database.reference().child("Users/${FirebaseAuth.instance.currentUser!.uid}/OtherAccounts/AccountManagingOf/$id").remove();
  }

  onScanSuccessfull(){
    _database.reference().child("Users/${FirebaseAuth.instance.currentUser!.uid}/OtherAccounts/AccountManagingOf").push()
    .update(ManageAccountUserModel(id: "id", uid: "uid", phoneNo: "phoneNo", name: "Name").toJson());
  }


}