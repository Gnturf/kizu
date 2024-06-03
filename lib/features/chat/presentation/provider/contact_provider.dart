import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/entity/contact_entity.dart';
import 'package:kizu/features/chat/business/repository/contact_repository.dart';
import 'package:kizu/features/chat/business/usecases/fetch_contact.dart';
import 'package:kizu/features/chat/data/datasources/remote_contact_data_source.dart';
import 'package:kizu/features/chat/data/repository_impl/contact_repository_impl.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactEntity>? contactList;
  Failure? failure;

  Future<Either<Failure, List<ContactEntity>>> fetchContacts() async {
    final ContactRepository contactRepository = ContactRepositoryImpl(
      remoteContactDataSource: RemoteContractDataSourceImpl(domain: "10.0.2.2"),
    );

    final eitherFailureOrContactList =
        await FetchContact(contactRepository: contactRepository).call();

    eitherFailureOrContactList.fold(
      (newFailure) {
        contactList = null;
        failure = newFailure;
        notifyListeners();
      },
      (newContactList) {
        contactList = newContactList;
        failure = null;
        notifyListeners();
      },
    );

    return eitherFailureOrContactList;
  }

  void cleanProvider() {
    contactList = null;
    failure = null;
    notifyListeners();
  }
}

final contactProvider =
    ChangeNotifierProvider<ContactProvider>((ref) => ContactProvider());
