// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_edit_fields_are_valid_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allEditFieldsAreValidControllerHash() =>
    r'647ed17df89373aa8de3ddd69dede935e62ffdcf';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [allEditFieldsAreValidController].
@ProviderFor(allEditFieldsAreValidController)
const allEditFieldsAreValidControllerProvider =
    AllEditFieldsAreValidControllerFamily();

/// See also [allEditFieldsAreValidController].
class AllEditFieldsAreValidControllerFamily extends Family<bool> {
  /// See also [allEditFieldsAreValidController].
  const AllEditFieldsAreValidControllerFamily();

  /// See also [allEditFieldsAreValidController].
  AllEditFieldsAreValidControllerProvider call({
    required String initialTitle,
    required String? initialDescription,
    required String initialUserAssigned,
    required TaskLabelEnum? initialLabel,
  }) {
    return AllEditFieldsAreValidControllerProvider(
      initialTitle: initialTitle,
      initialDescription: initialDescription,
      initialUserAssigned: initialUserAssigned,
      initialLabel: initialLabel,
    );
  }

  @override
  AllEditFieldsAreValidControllerProvider getProviderOverride(
    covariant AllEditFieldsAreValidControllerProvider provider,
  ) {
    return call(
      initialTitle: provider.initialTitle,
      initialDescription: provider.initialDescription,
      initialUserAssigned: provider.initialUserAssigned,
      initialLabel: provider.initialLabel,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'allEditFieldsAreValidControllerProvider';
}

/// See also [allEditFieldsAreValidController].
class AllEditFieldsAreValidControllerProvider
    extends AutoDisposeProvider<bool> {
  /// See also [allEditFieldsAreValidController].
  AllEditFieldsAreValidControllerProvider({
    required String initialTitle,
    required String? initialDescription,
    required String initialUserAssigned,
    required TaskLabelEnum? initialLabel,
  }) : this._internal(
         (ref) => allEditFieldsAreValidController(
           ref as AllEditFieldsAreValidControllerRef,
           initialTitle: initialTitle,
           initialDescription: initialDescription,
           initialUserAssigned: initialUserAssigned,
           initialLabel: initialLabel,
         ),
         from: allEditFieldsAreValidControllerProvider,
         name: r'allEditFieldsAreValidControllerProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$allEditFieldsAreValidControllerHash,
         dependencies: AllEditFieldsAreValidControllerFamily._dependencies,
         allTransitiveDependencies:
             AllEditFieldsAreValidControllerFamily._allTransitiveDependencies,
         initialTitle: initialTitle,
         initialDescription: initialDescription,
         initialUserAssigned: initialUserAssigned,
         initialLabel: initialLabel,
       );

  AllEditFieldsAreValidControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialTitle,
    required this.initialDescription,
    required this.initialUserAssigned,
    required this.initialLabel,
  }) : super.internal();

  final String initialTitle;
  final String? initialDescription;
  final String initialUserAssigned;
  final TaskLabelEnum? initialLabel;

  @override
  Override overrideWith(
    bool Function(AllEditFieldsAreValidControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AllEditFieldsAreValidControllerProvider._internal(
        (ref) => create(ref as AllEditFieldsAreValidControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialTitle: initialTitle,
        initialDescription: initialDescription,
        initialUserAssigned: initialUserAssigned,
        initialLabel: initialLabel,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _AllEditFieldsAreValidControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllEditFieldsAreValidControllerProvider &&
        other.initialTitle == initialTitle &&
        other.initialDescription == initialDescription &&
        other.initialUserAssigned == initialUserAssigned &&
        other.initialLabel == initialLabel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialTitle.hashCode);
    hash = _SystemHash.combine(hash, initialDescription.hashCode);
    hash = _SystemHash.combine(hash, initialUserAssigned.hashCode);
    hash = _SystemHash.combine(hash, initialLabel.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AllEditFieldsAreValidControllerRef on AutoDisposeProviderRef<bool> {
  /// The parameter `initialTitle` of this provider.
  String get initialTitle;

  /// The parameter `initialDescription` of this provider.
  String? get initialDescription;

  /// The parameter `initialUserAssigned` of this provider.
  String get initialUserAssigned;

  /// The parameter `initialLabel` of this provider.
  TaskLabelEnum? get initialLabel;
}

class _AllEditFieldsAreValidControllerProviderElement
    extends AutoDisposeProviderElement<bool>
    with AllEditFieldsAreValidControllerRef {
  _AllEditFieldsAreValidControllerProviderElement(super.provider);

  @override
  String get initialTitle =>
      (origin as AllEditFieldsAreValidControllerProvider).initialTitle;
  @override
  String? get initialDescription =>
      (origin as AllEditFieldsAreValidControllerProvider).initialDescription;
  @override
  String get initialUserAssigned =>
      (origin as AllEditFieldsAreValidControllerProvider).initialUserAssigned;
  @override
  TaskLabelEnum? get initialLabel =>
      (origin as AllEditFieldsAreValidControllerProvider).initialLabel;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
