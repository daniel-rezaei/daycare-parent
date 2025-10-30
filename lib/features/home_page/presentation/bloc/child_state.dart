import '../../domain/entities/child_entity.dart';

abstract class ChildState {}

class ChildInitial extends ChildState {}

class ChildLoading extends ChildState {}

class ChildLoaded extends ChildState {
  final ChildEntity child;
  final String? selectedAvatar; // ✅ عکس انتخاب‌شده

  ChildLoaded(this.child, {this.selectedAvatar});

  // برای بروزرسانی آسان بدون از بین بردن بقیه داده‌ها
  ChildLoaded copyWith({
    ChildEntity? child,
    String? selectedAvatar,
  }) {
    return ChildLoaded(
      child ?? this.child,
      selectedAvatar: selectedAvatar ?? this.selectedAvatar,
    );
  }
}

class ChildError extends ChildState {
  final String message;
  ChildError(this.message);
}
