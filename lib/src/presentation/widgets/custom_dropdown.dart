import 'package:flutter/material.dart';

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
}
