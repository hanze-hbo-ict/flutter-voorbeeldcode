# Demo Firebase

Deze demo heeft als doel om duidelijk te maken hoe je data via een app kunt opslaan in een [firebase-storage](https://firebase.google.com/). 

## Opzetten van de backend

Om de firebase backend op te zetten, moet je eerst een nieuw project maken. Ga naar [Google Firebase](https://firebase.google.com/), log in met je google account (dat moet je daar wel voor hebben, natuurlijk – als je dat niet hebt en niet wilt, dan zul je een ander storage provider moeten vinden) en klik op `Data Connect` (of klik op [deze link](https://firebase.google.com/products/data-connect)). Klik op `Create a new Firebase Project` en volg de stappen om het project daadwerkelijk aan te maken.

Aan het eind van deze stappen krijg je een url die je in de app kunt gebruiken.


## Het voorbeeld

Met deze demo-app kunnen gebruikers de hoeveelheid water die ze drinken bijhouden. Er is een eenvoudig watermodel die correspondeert met de data die naar firebase gestuurd wordt. Alle data wordt bijgehouden via [`lib/data/water_data.dart`](lib/data/water_data.dart), die op zijn beurt weer gebruik maakt van het provider package voor state management.

## Dependencies

Naast de standaard afhankelijkheden maakt dit voorbeeld gebruik van http, provider en intl:

```dart
flutter pub add http provider intl flutter_dotenv
```

## Gebruik van `dotenv`

Omdat je nog wel eens dingen hebt die je wel in je runtime wilt hebben maar niet (of niet per se) onder (publiekelijk) versiebeheer, maken we gebruik van [`dotenv`](https://pub.dev/packages/flutter_dotenv). Op deze manier kunnen we een bestand gebruiken voor bijvoorbeeld de opslag van de url naar onze firebase-database, zonder dat we deze online beschikbaar stellen. Let op dat we hiervoor óók de `pubspec.yaml` hebben aangepast:

```dart
flutter:
  assets:
    - assets/.env
```

Gebruik deze methode om de URL van je firebase-database op te slaan. Deze wordt in `water_data` gebruikt. Let op: als je de `pubspec` hebt aangepast, moet je dit even opnieuw laden (`flutter pub get`). 
