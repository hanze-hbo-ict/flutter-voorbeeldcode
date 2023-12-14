# infinite scroll

Dit voorbeeld bouwt verder op het [todo-voorbeeld, waarbij todo-items van een webserver worden opgehaald](../todo_app/). In het huidige voorbeeld kan de gebruiker de lijst blijven scrollen: telkens wanneer het einde van de huidige lijst is bereikt, wordt er een nieuwe call naar die webserver gedaan om nieuwe todo-items op te halen (in totaal zijn er iets van honderd, dus het houdt wel een keer op).

## Architectuur

Zoals je kunt zien zijn er drie verschillende directories in `lib`:

-  `model`, waarin het model van de Todo-items zit (inclusief die eenvoudige factory om een zooi van die dingen te maken op basis van een json-bestand); 
- `service`, waarin een classe zit die de calls naar de backend doet (momenteel is dat er maar één: `get`, maar je kunt je natuurlijk voorstellen dat er meerdere call in zitten, of meerdere services);
- `view`, met de uiteindelijke widget die je te zien krijgt.

Zoals te doen gebruikelijk wordt de hele boel bij elkaar geraapt in `main.dart`. Bekijk overigens ook [de documentatie in de flutter-docs](https://docs.flutter.dev/ui/layout/scrolling#infinite-scrolling) om verschillende andere (*infinite*) *scrolling widgets* te bestuderen.

## Dependency Injection

We hebben een heel eenvoudige vorm van dependency injection toegepast: in `main` wordt een instantie van de `TodoProvider` aangemaakt en die wordt aan de constructor van de `view` meegegeven. Op zich werk dit prima, maar voor meer complexe applicaties zou je eens kunnen kijken naar een DI-provider speciaal voor flutter. Er zijn er verschillende, maar een veel gebruikte is [fetit](https://pub.dev/packages/get_it) (zie bijvoorbeeld [deze blogpost](https://blog.logrocket.com/dependency-injection-flutter-using-getit-injectable/)).
