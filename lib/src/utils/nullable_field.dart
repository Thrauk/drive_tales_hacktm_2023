class Nullable<T> {
  const Nullable.value(this.value);

  final T? value;
}

extension IsNullableValid on Nullable<dynamic>? {
  bool isValid() {
    return this != null && this!.value != null;
  }
}
