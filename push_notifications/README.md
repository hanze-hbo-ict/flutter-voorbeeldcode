# push_notifications

Het maken van push-notificaties is een stukje complexer dan je alledaagse code. Dat komt doordat het de GAFA's zijn die de meldingen naar de devices sturen en daarvoor moet de app geregistreerd zijn bij Apple (iOS) of bij Google (Android). Het versturen van de berichten zelf doen we met behulp van [Firebasse Cloud Messaging](https://firebase.google.com/); een alternatief is [OneSignal](https://onesignal.com/).

Dit voorbeeld vertelt hoe je de boel moet opzetten om push-notificaties op iOS aan de praat te krijgen. Voor Android zijn de stappen anders, maar vergelijkbaar. We gaan er wel van uit dat je werkt vanuit dit flutter-project (`push_notifications`).

Als het goed is zijn alle dependencies in `pubspec.yaml` meegekomen, maar voor de zekerheid staan ze hieronder ook nog even:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

  overlay_support:
  firebase_core:
  firebase_messaging:
```

## Registreren van de app bij Firebase en bij Apple

**stap 1: aanvragen van een certificaat**

Allereerst moeten we een certificaat van Apple krijgen. Open KeyChain op je mac, selecteer `Keychain access -> Certificate assistant -> Request certificate from Certificate Authority`. Vul in het scherm dat je krijgt je emailadres in en selecteer *request is saved to disk*. Bewaar dit bestand op een logische plek op je computer.

![imgs/step1-1.png](Aanmaken van certificate request)

**stap 2. aanmaken van een certificaat**

Log met je apple-id in op [Apple Developer](https://developer.apple.com/). Klik op `certificates, ID's & profiles`. Selecteer `XCode development` en klik op *continue* rechtsboven. Upload in dit formulier de aanvraag die je in stap 1 hebt gemaakt. Hiermee vragen we dus een certificaat aan (Apple is in dit geval de *Certificate Authority*).

Klik weer op *continue* rechtsboven. Nu kun je een `.cert`-bestand downloaden. Bewaar dit bestand op een logisceh plek op je computer. Als je nu in je browser terugkeer naar `Certificates`, zie je als het goed is je net aangemaakte certificaat daar ook terug.

![imgs/step2-1.png](Aangemaakte certificaat staat ook in het overzicht)

**stap 3: aanmaken van de idenficatie**

Nog steeds ingelogd op [Apple Developer](https://developer.apple.com/) gaan we nu de *Identifier* voor onze app aanmaken en ophalen. Ga terug naar de homepage en selecteer `Identifiers`. Klik op het plus-teken rechtsboven om een nieuwe *identifier* aan te maken. In het scherm dat nu verschijnt vul je de beschrijving en de bundle-identifier van je app in. In principe kun je hier alles intypen wat je wilt, maar het is van belang dat de bundle-identifier later ook in XCode wordt ingevuld: bedenk hiervoor dus een logische naam (iets als `nl.hanze.mad` of zoiets).

Selecteer in de grote lijst hieronder de *capability* `Push Notification`. Klik nu op *continue* rechtsboven. Als alles goed is gegaan komt je app nu in het overzicht op de homepage te staan.

![imgs/step3-1.png](Invullen van de gegevens van je app)

![imgs/step3-2.png](De app komt nu ook in het overzicht terug)

**Stap 4: ophalen van de APNS key**

Om *push notifications* naar de app te sturen, moet je de *Apple Push Notification Server Key* (APNS Key) hebben. Ga naar de homepage op Apple Developer en klik op `Keys`. Klik op het plus-teken om een nieuwe *Key* aan te maken. Geef in het scherm waar je nu komt je sleutel een beschrijvende naam en selecteer *Enable push notifications*.

Klik op *continue*. In het scherm waar je nu komt kun je de sleutel downloaden. Sla deze op een logische plek op. Op deze pagina zie je ook je TeamID en KeyID. Die heb je later in het proces nodig, dus kopieer deze alvast ergens dat je er makkelijk bij kunt (je kun deze pagina altijd opnieuw openen, maar je kunt je Key niet nog een keer downloaden).

![imgs/step4-1.png](Nieuwe sleutel registeren)

![imgs/step4-2.png](Download je sleutel en sla de andere gegevens ook alvast op)

**step 5. Firebase opzetten**

Maak een account aan [op Firebase](https://firebase.google.com/codelabs/firebase-fcm-flutter#2) (je kunt gewoon inloggen met je Google-account, als je dat hebt). Klik op *Add Firebase to your project* en vul de gegevens in waar nu om gevraagd wordt. 

Uiteindelijk kun je ergens op *Register app* klikken. Als je dat doet, kun je een `GoogleService-Info.plist`-bestand downloaden. Sla dit op op een logische plek op je computer, want die hebben we later in het proces nodig. 

![imgs/step5-1.png](Toevoegen van Firebase aan je project)

![imgs/step5-2.png](Downloaden van het `plist`-bestand)

Klik nu op *Project Settings* (tandwiel linksboven) en selecteer de tab *cloud messaging*. Scroll iets naar beneden totdat je de sectie *Apple apps* vind. Je ziet daar *No APNS Auth Key* staan, met een knop om een bestand te uploaden. Gebruik deze knop om je key-bestand dat je in stap 4 hebt gedownload te uploaden. Voer hier ook je KeyID en TeamID uit stap 4 in. Als het goed is gegaan zie je nu deze gegevens in die sectie staan.

![imgs/step5-1.png](Project settings)

![imgs/step5-2.png](Aanmaken van een APNS key)

## Gereedmaken van de app in XCode

**stap 1: toevoegen van het `plist`-bestand**

Open Xcode en open de directory `ios`. Selecteer nu `File -> Add files to "Runner"` en navigeer naar het bestand `GoogleService-Info.plist` dat je hierboven in stap 5 hebt gedownload. **Let op:** het werkt niet als je dit bestand met de hand aan deze directory toevoegt, omdat het dan niet wordt meegenomen in de build. 

![imgs/step6-1.png](toevoegen van het `plist`-bestand via Xcode)

**stap 2: Signing and capabilities**

Klik op *Runner* in je projectscherm links om de *settings* te openen. Ga naar `Signing and Capabilites` en selecteer daar *push notifications*.

![imgs/step7-1.png](Push notifications als Capability van de app)

**stap 3: aanpassen van de `AppDelegate`**

Om de boel aan de praat te krijgen, moeten we het *entry-point* van de app aanpassen zodat deze gebruik kan maken van FireBase. Open `AppDelegate.swift` en vervang de gegeneerde code door de onderstaande code. Je krijgt een foutmelding dat de module `Flutter` niet kan worden gevonden; dat is logisch maar niet erg, omdat we de app niet runnen vanuit XCode zelf, maar met behulp van Flutter.

```swift
import UIKit
import Flutter

import Firebase
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
  override func application(_ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

     Messaging.messaging().apnsToken = deviceToken
     print("Token: \(deviceToken)")
     super.application(application,
     didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
   }
}
```
## Runnen maar

Als het goed is, kun je de boel nu runnen via `flutter run`. Als de app start kun je via je account op FireBase berichten versturen (*Messaging -> New Campaign -> Notifications*). **Let op:** push notifications werken alleen met een echt (fysiek) *device*. Je kunt het niet testen met de simulator.