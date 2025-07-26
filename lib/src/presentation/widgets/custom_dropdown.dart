import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/string_constants.dart';
import '../../core/platform/platform_utils.dart';

class CustomDropdown<T> extends StatelessWidget {
  /// Todo el conjunto de ítems que quieres mostrar.
  final List<T> items;

  /// El valor actualmente seleccionado (puede ser null).
  final T? value;

  /// Se llama cuando el usuario elige otro valor.
  final ValueChanged<T?> onChanged;

  /// Cómo convertir un T en un String legible.
  final String Function(T) itemLabel;

  /// Texto de hint cuando `value == null`.
  final String hint;

  /// Ícono a la izquierda (opcional).
  final IconData? prefixIcon;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemLabel,
    this.hint = '',
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return _buildCupertinoDropdown(context);
    }
    return _buildMaterialDropdown(context);
  }

  Widget _buildCupertinoDropdown(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        onPressed: () => _showCupertinoPicker(context),
        child: Row(
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon, color: Colors.grey, size: 20),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                value != null ? itemLabel(value as T) : hint,
                style: TextStyle(
                  color: value != null ? Colors.black : Colors.grey[500],
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialDropdown(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.grey[500]),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.grey)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF4A6CF7), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        items: items
            .map(
              (T item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  itemLabel(item),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
      ),
    );
  }

  void _showCupertinoPicker(BuildContext context) {
    final List<T?> pickerItems = [null, ...items];

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text(StringConstants.cancelButton),
                    onPressed: () => context.pop(),
                  ),
                  CupertinoButton(
                    child: const Text(StringConstants.acceptButton),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  magnification: 1.2,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: value != null
                        ? items.indexOf(value as T) + 1
                        : 0,
                  ),
                  onSelectedItemChanged: (int selectedIndex) {
                    final selectedValue = selectedIndex == 0
                        ? null
                        : items[selectedIndex - 1];
                    onChanged(selectedValue);
                  },
                  children: [
                    Center(
                      child: Text(
                        hint,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    ...items.map((T item) {
                      return Center(
                        child: Text(
                          itemLabel(item),
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
