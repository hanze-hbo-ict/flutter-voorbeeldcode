# Upload data voorbeeld

Een eenvoudige flutter app om data van de app naar de Automaat Backend te sturen.

## Dependencies

Voeg de volgende dependencies toe aan `pubspec.yml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
  image_picker: ^1.0.7
  mime: ^1.0.4
```

## Aanpassingen voor iOS

Om de imagepicker op iOS te kunnen gebruiken, moet je bij de `info.plist` aangeven dat de app dat mag (dankzij [deze melding op SO](https://stackoverflow.com/a/71064599/10974490)):

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>Allow access to photo library</string>
```

## JWT

Om de request goed te laten verlopen is het noodzakelijk dat er een jwt wordt meegestuurd. Voor deze demo kun je die eenvoudig uit de swagger-documentatie kopiëren.