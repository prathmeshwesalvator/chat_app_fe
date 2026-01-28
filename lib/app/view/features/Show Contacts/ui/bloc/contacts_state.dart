import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/domain/entities/contact_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'contacts_state.freezed.dart';


@freezed
abstract class ContactsState with _$ContactsState {
  const factory ContactsState({
    @Default([]) final List<ContactEntities> contacts,
    Blocstatus? contactStatus,
    @Default('') final String errroMessage,
  }) = _ContactsState;
}
