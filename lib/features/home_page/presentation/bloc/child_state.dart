import '../../domain/entities/child_entity.dart';

abstract class ChildState {}

// وضعیت اولیه قبل از هر کاری
class ChildInitial extends ChildState {}

// هنگام لود شدن داده‌ها
class ChildLoading extends ChildState {}

// وقتی لیست کودکان بارگذاری شد
class ChildListLoaded extends ChildState {
  final List<ChildEntity> children;
  final int selectedIndex;

  ChildListLoaded(this.children, {this.selectedIndex = 0});

  // کودک انتخاب‌شده
  ChildEntity get selectedChild => children[selectedIndex];

  // کپی با امکان بروزرسانی بدون از بین بردن داده‌های دیگر
  ChildListLoaded copyWith({
    List<ChildEntity>? children,
    int? selectedIndex,
  }) {
    return ChildListLoaded(
      children ?? this.children,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  // ✅ mapping بین UUID کودک و numericId (برای DB)
  Map<String, int> get uuidToNumericId {
    // فرض می‌کنیم numericId همان index + 1 است؛ اگر DB عدد دیگری دارد، جایگزین کنید
    return {for (var i = 0; i < children.length; i++) children[i].id: i + 1};
  }
}

// وقتی یک کودک انتخاب شد
class ChildSelected extends ChildState {
  final ChildEntity child;
  ChildSelected(this.child);
}

// در صورت خطا
class ChildError extends ChildState {
  final String message;
  ChildError(this.message);
}
