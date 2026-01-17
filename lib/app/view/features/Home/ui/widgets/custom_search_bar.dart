import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.searchController,
    this.onChanged,
  });

  final TextEditingController searchController;
  final ValueChanged<String>? onChanged;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SearchBar(
      controller: widget.searchController,
      focusNode: _focusNode,
    
      /// Elevation animation on focus
      elevation: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.focused) ? 6 : 1,
      ),
    
      backgroundColor: WidgetStateProperty.all(
        theme.colorScheme.surface,
      ),
    
      hintText: 'Search chats, contacts...',
      hintStyle: WidgetStateProperty.all(
        theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
    
      leading: Icon(
        Icons.search,
        color: theme.colorScheme.onSurface.withOpacity(0.6),
      ),
    
      trailing: [
        if (widget.searchController.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              widget.searchController.clear();
              widget.onChanged?.call('');
              setState(() {});
            },
          ),
      ],
    
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16),
      ),
    
      onChanged: (value) {
        widget.onChanged?.call(value);
        setState(() {});
      },
    );
  }
}
