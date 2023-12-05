# Flutter voorbeelden

Elke directory in deze repo bevat eigenlijk alleen de `dart`-bestanden van de voorbeeldcode. Om de voorbeelden te laten runnen maak je een nieuw flutter project aan en kopieer je de relevante `dart`-bestanden in de gegenereerde `lib`-directory:

```
flutter create demo_app
rm demo_app/lib/*
mv <REPO/VOORBEELD/lib/>* demo_app/lib/
flutter run
```

## Volgorde

De volgorde waarin de voorbeelden langskomen is als volgt:

1. splash_screen
2. transition_app
3. list_app
4. todo_app
