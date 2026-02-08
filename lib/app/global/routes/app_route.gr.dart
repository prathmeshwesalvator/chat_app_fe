// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_route.dart';

/// generated route for
/// [AppShellPage]
class AppShellRoute extends PageRouteInfo<void> {
  const AppShellRoute({List<PageRouteInfo>? children})
      : super(AppShellRoute.name, initialChildren: children);

  static const String name = 'AppShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppShellPage();
    },
  );
}

/// generated route for
/// [CallsTabPage]
class CallsTabRoute extends PageRouteInfo<void> {
  const CallsTabRoute({List<PageRouteInfo>? children})
      : super(CallsTabRoute.name, initialChildren: children);

  static const String name = 'CallsTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CallsTabPage();
    },
  );
}

/// generated route for
/// [ContactChatPage]
class ContactChatRoute extends PageRouteInfo<ContactChatRouteArgs> {
  ContactChatRoute({
    Key? key,
    required int contactId,
    required String contactUsername,
    List<PageRouteInfo>? children,
  }) : super(
          ContactChatRoute.name,
          args: ContactChatRouteArgs(
            key: key,
            contactId: contactId,
            contactUsername: contactUsername,
          ),
          rawPathParams: {
            'contactId': contactId,
            'contactUsername': contactUsername,
          },
          initialChildren: children,
        );

  static const String name = 'ContactChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ContactChatRouteArgs>(
        orElse: () => ContactChatRouteArgs(
          contactId: pathParams.getInt('contactId'),
          contactUsername: pathParams.getString('contactUsername'),
        ),
      );
      return ContactChatPage(
        key: args.key,
        contactId: args.contactId,
        contactUsername: args.contactUsername,
      );
    },
  );
}

class ContactChatRouteArgs {
  const ContactChatRouteArgs({
    this.key,
    required this.contactId,
    required this.contactUsername,
  });

  final Key? key;

  final int contactId;

  final String contactUsername;

  @override
  String toString() {
    return 'ContactChatRouteArgs{key: $key, contactId: $contactId, contactUsername: $contactUsername}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ContactChatRouteArgs) return false;
    return key == other.key &&
        contactId == other.contactId &&
        contactUsername == other.contactUsername;
  }

  @override
  int get hashCode =>
      key.hashCode ^ contactId.hashCode ^ contactUsername.hashCode;
}

/// generated route for
/// [ContactPage]
class ContactRoute extends PageRouteInfo<void> {
  const ContactRoute({List<PageRouteInfo>? children})
      : super(ContactRoute.name, initialChildren: children);

  static const String name = 'ContactRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContactPage();
    },
  );
}

/// generated route for
/// [ContactsTabPage]
class ContactsTabRoute extends PageRouteInfo<void> {
  const ContactsTabRoute({List<PageRouteInfo>? children})
      : super(ContactsTabRoute.name, initialChildren: children);

  static const String name = 'ContactsTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContactsTabPage();
    },
  );
}

/// generated route for
/// [HomeTabPage]
class HomeTabRoute extends PageRouteInfo<void> {
  const HomeTabRoute({List<PageRouteInfo>? children})
      : super(HomeTabRoute.name, initialChildren: children);

  static const String name = 'HomeTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeTabPage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [LoginPageDesktop]
class LoginRouteDesktop extends PageRouteInfo<void> {
  const LoginRouteDesktop({List<PageRouteInfo>? children})
      : super(LoginRouteDesktop.name, initialChildren: children);

  static const String name = 'LoginRouteDesktop';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPageDesktop();
    },
  );
}

/// generated route for
/// [LoginPageMobile]
class LoginRouteMobile extends PageRouteInfo<void> {
  const LoginRouteMobile({List<PageRouteInfo>? children})
      : super(LoginRouteMobile.name, initialChildren: children);

  static const String name = 'LoginRouteMobile';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPageMobile();
    },
  );
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}

/// generated route for
/// [ShowQrPage]
class ShowQrRoute extends PageRouteInfo<void> {
  const ShowQrRoute({List<PageRouteInfo>? children})
      : super(ShowQrRoute.name, initialChildren: children);

  static const String name = 'ShowQrRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ShowQrPage();
    },
  );
}
