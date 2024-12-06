# ListDemo

In deze demo maken we gebruik van de [`ListView`]() widget om lijsten weer te geven. Veel (bijna alle) apps en websites zijn zogenaamde [*glorified lists*](), dus het is essentieel dat we weten hoe we lijsten bouwen en weergeven.

We beginnen met een eenvoudige lijst (`_staticList`), daarna maken we een *dynamische lijst (wait for it... `_dynamicList`). die feitelijk ook statisch is; het gaat er hier om dat je data ook uit een externe lijst kunt halen. In zo'n geval maak je gebruik van een `itemBuilder` om de items uit de lijst weer te geven.

Vervolgens een lijstje die oneindig door blijft groepen (`_infiniteList`); ok, deze is niet per se oneindig, want je geeft met `itemCount` aan om hoeveel items het in deze lijst gaat, maar soit. Uiteindelijk komen we uit op een oneindige lijst die er nog leuk uitziet ook (`_prettyInfiniteList`) – altans, die gebruik maakt van een `seperatorBuilder` om de scheidingen tussen de items op te bouwen.