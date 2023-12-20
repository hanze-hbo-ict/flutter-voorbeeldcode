# maps_app

Voorbeeld van hoe te werken met [OpenStreetMap](https://www.openstreetmap.org/). We maken hierbij gebruik van [Flutter Map](https://docs.fleaflet.dev/). Je kunt ook Google Maps gebruiken, maar da's duur en ingewikkeld. Zie daarvoor [deze blog](https://medium.com/@samra.sajjad0001/a-comprehensive-guide-to-using-google-maps-in-flutter-3fbc0f7d469e).

Installeren van de dependencies doe je via de command line (of je past `pubspec.yaml` met de hand aan):

```shell
flutter pub add flutter_map 
flutter pub add latlong2
```

Als het goed is, worden nu de dependencies vanzelf binnengehaald. Als dat niet zo is, moet je even `flutter pub get` typen.

## 1. een kaart met icons

De klasse `SimpleMarkers` (in `view/simple_markers.dart`) laat zien hoe je *icons* op een kaart kunt plotten. Een overzicht van alle Icons vind je [hier](https://api.flutter.dev/flutter/material/Icons-class.html).

## 2. icons met *gestures*

Uit [de docs](https://docs.fleaflet.dev/layers/marker-layer#handling-gestures):

> There is no built-in support to handle gestures on `Markers`, such as taps. However, this is easy to implement using a standard `GestureDetector`.

De klasse `InteractiveMarkers` (in `view/interactive_markers.dart`) laat dit zien. **Let op:** deze beperking van `Markers` is relatief recent geïntroduceerd. Op internet zie je nog heel veel voorbeelden met het gebruik van een `builder` in `Marker`, maar die is er dus onlangs uitgehaald.

Let op dat je de `GestureDetector` als *child-property* van de `Marker` gebruikt, en niet andersom.

## 3. Location

Dependency toegevoegd in `location: ^4.2.0`
Settings aanpassen voor Android en voor iOS:

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


