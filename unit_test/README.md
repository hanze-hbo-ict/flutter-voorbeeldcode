# Unit test demo

Voorbeeld om de werking van unit test binnen flutter te laten zien.

We maken gebruik van [dit voorbeeld van flutter persistentie](https://docs.flutter.dev/cookbook/persistence/sqlite); het bestand `database.dart` is een uitwerking hiervan, die we automatisch willen testen. Om dit bestand te laten werken moet je twee dependencies toevoegen: 

```shell
flutter pub add sqflite path
```

De tests zitten in `./tests/datase_test.dart`. In dit script maken we gebruik van [`sqlflite_common_ffi`](https://pub.dev/packages/sqflite_common_ffi), wat een [Foreign Function Interface](https://en.wikipedia.org/wiki/Foreign_function_interface) implementatie is van [sqlflite](https://pub.dev/packages/sqflite). Deze *dependency* moet je wel aan de `dev_dependencies` toevoegen:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  sqflite_common_ffi:
```

Als je het testbestand opent in VSCode, kun je ze individueel of als suite runnen. 