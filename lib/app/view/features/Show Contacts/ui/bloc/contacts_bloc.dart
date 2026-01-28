import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/usecases/contact_usecases.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_event.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactUsecases contactUsecases;

  ContactsBloc({required this.contactUsecases}) : super(const ContactsState()) {
    on<LoadContacts>((event, emit) async {
      emit(state.copyWith(contactStatus: Blocstatus.loading));

      final response = await contactUsecases.fetchContacts();

      response.fold(
        (l) {
          emit(
            state.copyWith(
              contactStatus: Blocstatus.error,
              errroMessage: l.errorMessage.toString(),
            ),
          );
        },
        (r) {
          emit(state.copyWith(contactStatus: Blocstatus.success, contacts: r));
        },
      );
    });
  }
}
