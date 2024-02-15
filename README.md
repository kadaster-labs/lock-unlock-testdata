# Lock-Unlock Project - Testdata

> **English**
> 
> This open source project contains the testdata of the [Lock-Unlock
> Project](https://labs.kadaster.nl/cases/lockunlock). In this project we researching and testing to
> '_lock the data and unlock the potential_'; make closed data available to enable research and
> analysis on this data _with_ valid authorization rules in place.

Other relevant repositories of the [Lock-Unlock Project](https://labs.kadaster.nl/cases/lockunlock) are:

- [Lock-Unlock Docs](https://github.com/kadaster-labs/lock-unlock-docs) including onthologies
  - Authorization Onthology (in research)
  - Logging Onthology (in research)
- (this repo) [Lock-Unlock Testdata](https://github.com/kadaster-labs/lock-unlock-testdata)
- [Secured SPARQL Endpoint Sub Graph](https://github.com/kadaster-labs/secured-sparql-endpoint-subgraph)
  (based on Apache Jena & SpringBoot)
- [Secured SPARQL Endpoint Rewrite (SPARQL
  Query)](https://github.com/kadaster-labs/secured-sparql-endpoint-rewrite) (based on Fuseki)
- [Lock-Unlock Helm Charts](https://github.com/kadaster-labs/lock-unlock-helm-charts)

---

Dit open source project bevat de testdata van het [Lock-Unlock
Project](https://labs.kadaster.nl/cases/lockunlock). In dit project onderzoeken en beproeven wij:
'_lock de data, unlock het pontentieel_'; hoe kunnen we gesloten data beschikbaar maken _met_ behoud
van valide autorisatie regels.

De **testopstelling** is die van de BasisRegistratie Kadaster, BRK. Dat betreft percelen die
gekoppeld zijn aan een geografische locatie (gebied), waar de (zakelijke) rechten uitgegeven zijn
aan mensen of bedrijven, waarbij de bedrijven uiteraard weer te relateren zijn aan mensen en ook
eventueel een ANBI instelling kunnen betreffen.

De testdata worden gegenereerd volgens een zelf gedefinieerd informatiemodel. Dit informatiemodel
wordt [hier](https://data.labs.kadaster.nl/lock-unlock/gesloten-knowledge-graph/schema)
gevisualiseerd en is
[hier](https://data.labs.kadaster.nl/lock-unlock/gesloten-knowledge-graph/download.trig.gz?graph=https%3A%2F%2Fdata.labs.kadaster.nl%2Flock-unlock%2Fgesloten-knowledge-graph%2Fgraphs%2Finformatie-model)
te downloaden.

De **testdata** volgt de testopstelling. Het is synthetische (gegenereerde) testdata die gekoppeld
is aan bestaande geografische percelen om deze in een kaartje te kunnen weergeven. Voor het
genereren is gebruik gemaakt van een intern software project, gebaseerd op Java, welke gebruik maakt
van diverse libraries voor het genereren van synthetische data. De uitkomsten hiervan zijn in deze
repo toegevoegd. Vanuit deze repository wordt de testdata (gescript) in de testomgeving geladen.

Per 'silo' bestaat de (te verwachten) testdata uit:

- instantie data -> 'de' testdata (in `.ttl` of `.trig` format)
- authorization configuration -> de configuratie / instantie data voor de autorisaties voor
  betreffende testdata set (in `.ttl` format)

De **testomgeving** is een verspreide omgeving om een federatieve bevraging te beproeven en ook de
autorisatie op een federatieve wijze te kunnen aantonen. Het Kadaster is verantwoordelijk voor de
bijhouding van de BRK en is daarom een logische partij om de BRK testdata te hosten. Voor de andere
data is dat juist niet logisch en daarom wordt deze in de Digilab omgeving gehost.

![Lock-Unlock Testdata Deployment](images/lock-unlock-testdata-deployment.jpg)

Voor het afdwingen van de autorisaties wordt gebruik gemaakt van een eigen implementatie van een
[Secured SPARQL Endpoint](https://github.com/kadaster-labs/secured-sparql-endpoint). Dit is een
implementatie van de [Authorization Ontology](#todo), een voorbeeld van de [Authorization
Configuration](#todo) en gebaseerd op de [Apache Jena
Core](https://github.com/apache/jena/tree/main/jena-core) (ook gebruikt in
[Fuseki](https://github.com/apache/jena/tree/main/jena-fuseki2)).

## License

Om hergebruik en doorontwikkeling maximaal mogelijk te maken, is dit project gelicenseerd onder
[CC0](LICENSE.md).

> **English**
> 
> To promote reuse and development of this project, this project is licensed under [CC0](LICENSE.md)
