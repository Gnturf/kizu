import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/entity/user_entity.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/chat/business/repository/contact_repository.dart';
import 'package:kizu/features/chat/business/usecases/fetch_all_contact.dart';
import 'package:kizu/features/chat/data/datasources/remote_contact_data_source.dart';
import 'package:kizu/features/chat/data/repositoryImpl/contact_repository_impl.dart';

class ContactProvider extends ChangeNotifier {
  List<UserEntity>? contactList;
  Failure? failure;

  Future<Either<Failure, List<UserEntity>>> fetchAllUserContact() async {
    final ContactRepository contactRepository = ContactRepositoryImpl(
      remoteContactDataSource: RemoteContactDataSourceImpl(domain: '10.0.2.2'),
    );

    final eitherFailureOrAllContact =
        await GetAllContact(contactRepository: contactRepository).call();

    eitherFailureOrAllContact.fold(
      (newFailure) {
        failure = newFailure;
        contactList = null;
        notifyListeners();
      },
      (newContactList) {
        failure = null;
        contactList = newContactList;
        notifyListeners();
      },
    );

    return eitherFailureOrAllContact;
  }
}

final contactProvider = ChangeNotifierProvider<ContactProvider>(
  (ref) => ContactProvider(),
);
