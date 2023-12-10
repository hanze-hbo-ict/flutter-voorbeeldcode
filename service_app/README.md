# service_app

Voorbeeld om te laten zien hoe je met dart en flutter http-requests kunt uitvoeren.

## Opstarten

Om goed te begrijpen hoe één en ander werkt, is het van belang dat je goed weet hoe `Future`s werken. Bestudeer eventueel [deze codelab over asynchroon programmeren in Futter](https://dart.dev/codelabs/async-await). In principe is deze techniek hetzelfde als wat we in web3 met `Promises` hebben gehad.

In dit project maken we gebruik van [de package `http`](https://pub.dev/packages/http). De meeste eenvoudige manier om dit aan het project toe te voegen is via de command line:

```
flutter pub add http
```

Verder moeten we voor Android aangeven dat de app *network requests* mag uitvoeren. Hiervoor is het bestand `android/app/src/main/AndroidManifest.xml` aangepast.

## Twee voorbeelden

we maken gebruik van [typicode json placeholder](https://jsonplaceholder.typicode.com/users/1/todos) om de twintig todo-items van gebruiker 1 op te halen. We tonen deze in een `ListView`. Bestudeer de code in `lib/todo.dart` om te zien hoe dat gedaan is.

Er is ook nog een tweede voorbeeld gegeven, waarbij we [*cat as a service*](https://cataas.com/) gebruiken om plaatjes van katten weer te geven. In dit voorbeeld kun je zien hoe je een `StatefulWidget` kunt gebruiken om telkens nieuwe data op te halen.

