# Voorbeeld van lijsten met een database

In dit voorbeeld gebruik ik de database-engine drift: zie [de documentatie online](https://pub.dev/packages/drift), of [deze documentatie](https://drift.simonbinder.eu/docs/upgrading/#name) en ook nog [deze getting started](https://drift.simonbinder.eu/docs/getting-started/).

Ik had zelf wat moeite met de dependencies omdat er een nieuwe versie van dart is uitgekomen;
de dependencies die je nu vindt in `pubspec.yaml` werken in ieder geval op mijn machine. 

```shell
dart pub add drift drift_flutter dev:drift_dev dev:build_runner
```

Een goed en uitgebreid voorbeeld kun je vinden op https://fluttertalk.com/flutter-crud-tutorial-using-drift-package/

## Twee versies

Er zitten twee todo-listen in dit package: één zonder database en eentje met database. Om één van beide te runnen, maak je in `main.dart` een instantie van de corresponderende klasse aan (het kan handig zijn om beide even met elkaar te vergelijken):

De code hieronder maakt een app aan *zonder* database:

```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'To-Do List', home: TodoList());
  }
}
```

De code hieronder maakt een app aan *met* database:

```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'To-Do List', home: TodoListPersistent());
  }
}
```

**Let op:** Hoewel het bestand `database.g.dart` in git zit, is dit een gegenereerd bestand; het kan zijn dat je deze even opnieuw moet genereren voordat de boel werkt:

```shell
dart run build_runner build
```
