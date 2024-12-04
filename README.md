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

### Week 1

1. [splash_screen](splash_screen/README.md)
2. [transition_app](transition_app/README.md)
3. [list_app](list_app/README.md)
4. [todo_app](todo_app/README.md)

### Week 2
5. [dismiss_app](dismiss_app/README.md)
6. [service_app](service_app/README.md)

### Week 3

7. [service_app](service_app/README.md)
8. [infinite_scroll](infinite_scroll/README.md)
