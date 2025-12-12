# maps_app

Voorbeeld van hoe te werken met [OpenStreetMap](https://www.openstreetmap.org/). We maken hierbij gebruik van [Flutter Map](https://docs.fleaflet.dev/). Je kunt ook Google Maps gebruiken, maar da's duur en ingewikkeld. Zie daarvoor [deze blog](https://medium.com/@samra.sajjad0001/a-comprehensive-guide-to-using-google-maps-in-flutter-3fbc0f7d469e).

Installeren van de dependencies doe je via de command line (of je past `pubspec.yaml` met de hand aan):

```shell
flutter pub add flutter_map latlong2 location provider

```

Als het goed is, worden nu de dependencies vanzelf binnengehaald. Als dat niet zo is, moet je even `flutter pub get` typen.

Let op: om gebruik te maken van OpenStreatMaps moet je een `userAgentPackageName` meesturen. De meeste voorbeelden die je online vindt gebruiken hiervoor `com.example.app`, maar die doet het sinds begin 2025 niet meer. Volgens [deze discussie op github](https://github.com/fleaflet/flutter_map/issues/2123) komt dat doordat er te veel traffic met die *User-Agents* gegenereerd werd. Zorg er dus voor dat je een andere *User-Agent* meestuurt,

```dart
TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'nl.hanze.mad', //bijvoorbeeld:w
),
```

In `home_screen.dart` vindt je de root-widget. Hierin staan vier voorbeelden die je sequentieel kunt uitproberen.

## Voorbeeld 1: een kaart met een input

Klasse `MapScreen` in `views/map_screen.dart`.

Dit voorbeeld geeft een kaart met rechtsonderin een invoerveld waar een gebruiker een locatie (als String, gescheiden door komma's) kan invoeren: *lengtegraad,breedtegraad*. Deze String wordt in `_scrollToLocation` gesplitst en gebruikt om een locatie (`LatLng`) van te maken. Er zit geen check op de invoer, dus als iemand iets invoert dat niet als `double` kan worden geïnterpreteerd krijg je een foutmelding (in de console: de app zelf blijft gewoon draaien).

```dart
List<String> location = _locationController.text.split(',');
double lat = double.parse(location[0]);
double lng = double.parse(location[1]);
```

## 2. een kaart met icons

De klasse `SimpleMarkers` (in `views/simple_markers.dart`) laat zien hoe je *icons* op een kaart kunt plotten. Een overzicht van alle Icons vind je [hier](https://api.flutter.dev/flutter/material/Icons-class.html). We gebruiken hier een lijstje van alle vliegvelden in de buurt van Groningen (lijstje is te vinden in `models/allfields.dart`, inclusief plaatjes en ICAO-callsign).

Het meest interessante van dit voorbeeld is de manier waarop de markers op de kaart worden geplot. In de `children` van de `FlutterMap` maken we een `MarkerLayer` aan, die gevuld wordt in de methode `_getMarkers`, die je onderin het bestand kun vinden. Hier *mappen* we alle instanties van `AirField` naar een `Marker`, die we uiteindelijk als `List` teruggeven.

## Voorbeeld 3. icons met *gestures*

Uit [de docs](https://docs.fleaflet.dev/layers/marker-layer#handling-gestures):

> There is no built-in support to handle gestures on `Markers`, such as taps. However, this is easy to implement using a standard `GestureDetector`.


De klasse `InteractiveMarkers` (in `view/interactive_markers.dart`) laat dit zien. We hebben dezelfde lijst met vliegvelden, alleen nu willen we dat je op het icoon kan klikken (of *tabben* eigenlijk, want we zitten op mobiel) en dat je dan een plaatje van het vliegveld in kwestie krijgt te zien. Dit gebeurt opnieuw in de methode `_getMarkers`, waarin nu het icoon gewrapped is in een `GestureDetector`. Je kunt op het plaatje klikken om het weer weg te halen.

 **Let op:** deze beperking van `Markers` is relatief recent geïntroduceerd. Op internet zie je nog heel veel voorbeelden met het gebruik van een `builder` in `Marker`, maar die is er dus onlangs uitgehaald.

Let op dat je de `GestureDetector` als *child-property* van de `Marker` gebruikt, en niet andersom. Het is het *icoon* dat de *tab* opvangt, niet de `Marker`.

## VOorbeeld 4.  de locatie van het device gebruiken

Natuurlijk wil je de locatie (en de richting) van je device kunnen gebruiken. Hiervoor kun je gebruik maken van [de `location` library](https://pub.dev/packages/location). De klasse `DeviceLocation` (in `views/device_location`) laat zien hoe dit werkt.

Dit is best een ingewikkelde klasse, omdat -ie ook de mogelijkheid biedt om de kaart continu te updaten; dat houdt in dat wanneer je met de telefoon aan het rondlopen bent, de locatie hiervan steeds wordt doorgegeven aan de app, die vervolgens de kaart aanpast.

Omdat we hier gebruik maken van specifieke eigenschappen van het device, en nog wel iets waar de gebruiker toestemming voor moet geven, moeten we dit voor de verschillende besturingssystemen instellen. Dit houdt in dat we (voor het eerst in deze voorbeeldenreeks) dingen moeten aanpassen *buiten* de `lib` om.


Android: `./android/app/src/main/AndroidManifest.xml`: 

```xml
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

Als je dit ook op de achtergrond wilt kunnen doen, moet je ook nog de volgende regel toevoegen:

```xml
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
```

iOS: `./ios/Runner/Info.plist`

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs to access your location</string>
```


