# raspisanie

A new Flutter project.

## Генерация кода
Пакеты **freezed** и **auto_route** генерируют код для API моделей данных и навигации.
Используйте флаг [watch], чтобы следить за изменениями в файловой системе и перестраивать код при необходимости.
```
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

Tсли вы хотите, чтобы генератор запустился один раз и завершил работу, используйте
```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
