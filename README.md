# notez

This code improved the previous "Note app created using Hive & GetX" 
which can be found here: [Notez Repository](https://github.com/MAI-BEBI-POWDER-TEAM/CR-YOUTH-MOBILE-5TH)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Why HiveFlutter?
1. Of course, because it's lightweight, especially for the simple note app
2. Fast & easy to develop
3. This note app doesn't required image CRUD

## Why GetX?
1. Personally, it's our best choice for small to mid-level project
2. Efficient for MVC approach, our style indeed
3. Well, GetX includes widget supports, live & observable data transaction, which simplifies coding process

## Clean Architecture Tree
```
lib/
-- app/
    views/
        home/
            home_views.dart
        note/
            add_note_views.dart
            detail_note_views.dart
-- data/
    controller/
        note_controller.dart
    local/
        note_db.dart
-- domain/
    entities/
        note.dart
        note.g.dart
    repositories/
        note_repository.dart
    usecase/
        note_usecase.dart
-- utils/
    app_theme.dart
    extension/
        app_theme_ext.dart
-- main.dart
```