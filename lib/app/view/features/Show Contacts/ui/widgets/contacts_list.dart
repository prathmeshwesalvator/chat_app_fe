import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/global/utils/haptic_feedback.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_bloc.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_event.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/bloc/contacts_state.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/widgets/contact_tile.dart';
import 'package:chat_app_fe/app/view/features/Show%20Contacts/ui/widgets/contact_shimmer_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late AnimationController _errorAnimationController;
  late Animation<double> _errorAnimation;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();

    _errorAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _errorAnimation = CurvedAnimation(
      parent: _errorAnimationController,
      curve: Curves.easeInOut,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeController.forward();

    _searchController.addListener(() {
      if (mounted) {
        setState(() => _searchQuery = _searchController.text.toLowerCase());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _errorAnimationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    try {
      HapticFeedback.mediumImpact();
      context.read<ContactsBloc>().add(LoadContacts());
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to refresh contacts');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(CupertinoIcons.exclamationmark_triangle_fill,
                color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildSearchBar(
      ThemeData theme, ColorScheme colorScheme, Brightness brightness) {
    final glassColor = brightness == Brightness.dark
        ? colorScheme.surface.withOpacity(0.5)
        : Colors.white.withOpacity(0.85);

    final borderColor = brightness == Brightness.dark
        ? Colors.white.withOpacity(0.12)
        : Colors.white.withOpacity(0.6);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: glassColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: TextField(
            controller: _searchController,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Search contacts...',
              hintStyle: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.5),
              ),
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                      onPressed: () {
                        _searchController.clear();
                        FocusScope.of(context).unfocus();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onChanged: (_) {
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
      ThemeData theme, ColorScheme colorScheme, String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primaryContainer.withOpacity(0.3),
            ),
            child: Icon(
              icon,
              size: 64,
              color: colorScheme.primary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
      ThemeData theme, ColorScheme colorScheme, String error) {
    return FadeTransition(
      opacity: _errorAnimation,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.red.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                size: 48,
                color: Colors.red[700],
              ),
              const SizedBox(height: 16),
              Text(
                'Oops! Something went wrong',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.red[900],
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.red[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                onPressed: () {
                  _errorAnimationController.reverse();
                  context.read<ContactsBloc>().add(LoadContacts());
                },
                child: const Text(
                  'Try Again',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;

    return BlocConsumer<ContactsBloc, ContactsState>(
      listener: (context, state) {
        if (state.deleteStatus == Blocstatus.success) {
          _showSuccessSnackBar("Contact deleted successfully");
        }
        if (state.contactStatus == Blocstatus.error) {
          _errorAnimationController.forward();
          _showErrorSnackBar(state.errroMessage);
        } else {
          _errorAnimationController.reverse();
        }
      },
      builder: (context, state) {
        // Loading state with shimmer
        if (state.contactStatus == Blocstatus.loading &&
            state.contacts.isEmpty) {
          return Column(
            children: [
              _buildSearchBar(theme, colorScheme, brightness),
              Expanded(
                child: CustomScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, __) => const ContactShimmerTile(),
                          childCount: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        // Error state
        if (state.contactStatus == Blocstatus.error && state.contacts.isEmpty) {
          return Column(
            children: [
              _buildSearchBar(theme, colorScheme, brightness),
              Expanded(
                child: _buildErrorState(
                  theme,
                  colorScheme,
                  state.errroMessage,
                ),
              ),
            ],
          );
        }

        // Filter contacts based on search
        final filteredContacts = _searchQuery.isEmpty
            ? state.contacts
            : state.contacts.where((contact) {
                return contact.contactUsername
                    .toLowerCase()
                    .contains(_searchQuery);
              }).toList();

        // Empty state
        if (filteredContacts.isEmpty) {
          return Column(
            children: [
              _buildSearchBar(theme, colorScheme, brightness),
              Expanded(
                child: _buildEmptyState(
                  theme,
                  colorScheme,
                  _searchQuery.isEmpty
                      ? 'No contacts yet\nStart connecting!'
                      : 'No contacts found',
                  _searchQuery.isEmpty
                      ? CupertinoIcons.person_2_fill
                      : CupertinoIcons.search,
                ),
              ),
            ],
          );
        }

        return Column(
          spacing: 4,
          children: [
            _buildSearchBar(theme, colorScheme, brightness),
            if (filteredContacts.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${filteredContacts.length} ${filteredContacts.length == 1 ? 'contact' : 'contacts'}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                color: colorScheme.primary,
                backgroundColor: colorScheme.surface,
                child: FadeTransition(
                  opacity: _fadeController,
                  child: CustomScrollView(
                    cacheExtent: 400,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final contact = filteredContacts[index];

                              return TweenAnimationBuilder<double>(
                                duration:
                                    Duration(milliseconds: 200 + (index * 50)),
                                tween: Tween(begin: 0.0, end: 1.0),
                                curve: Curves.easeOut,
                                builder: (context, value, child) {
                                  return Opacity(
                                    opacity: value,
                                    child: Transform.translate(
                                      offset: Offset(0, 20 * (1 - value)),
                                      child: child,
                                    ),
                                  );
                                },
                                child: ContactTile(
                                  contact: contact,
                                  onTap: () {
                                    try {
                                      context.hapticLight();
                                      context.router.push(
                                        ContactChatRoute(
                                          contactId: contact.contactUserId,
                                          contactUsername:
                                              contact.contactUsername,
                                        ),
                                      );
                                    } catch (e) {
                                      _showErrorSnackBar(
                                        'Failed to open chat: ${e.toString()}',
                                      );
                                    }
                                  },
                                  onDeleteTap: () {
                                    context.read<ContactsBloc>().add(
                                        DeleteContact(
                                            contactUserId:
                                                contact.contactUserId));
                                  },
                                ),
                              );
                            },
                            childCount: filteredContacts.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
