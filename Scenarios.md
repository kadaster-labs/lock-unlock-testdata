# Scenario's

In dit project hebben we diverse scenario's bedacht om te bedenken en aan te tonen dat 'het' werkt.
Het doel is om (linked) data af te schermen en toegankelijk te maken voor geautoriseerde persona's.

Hieronder volgen de persona's, de scenario's van wat zij willen vragen, de SPARQL queries die zijn dan zouden stellen. In de verschillende implementaties betekenen deze verschillende uitwerkingen:

- **rewrite** implementatie gaat uit van het hetschrijven (rewrite) van de SPARQL query; deze staat per scenario uitgeschreven tbv het kunnen implementeren
- **sub graph** implementatie gaat uit van een sub graph per persona van wat hij/zij mag; volgens kunnen de originele SPARQL queries uitgevoerd worden

## Named sub graphs

### Sub graph 'anoniem'

```sparql
select 
# TODO
```

### Sub graph 'Zeewolde'

```sparql
select 
# TODO
```

## Uitwerking

### Persona Anomieme gebruiker

#### Scenario: Wat is de oudste kerk in Zeewolde?

**Beschrijving**

[TODO]

**Originele SPARQL query**

```sparql
select 
# TODO
```

**Rewriten SPARQL query**

```sparql
select 
# TODO
```

**Named sub graph:** [Sub graph 'anoniem'](#sub-graph-anoniem)

### Persona Woningcorperatie

#### Scenario: Welk eigendom hebben wij in bezit?

**Beschrijving**

[TODO]

**Originele SPARQL query**

```sparql
select 
# TODO
```

**Rewriten SPARQL query**

```sparql
select 
# TODO
```

**Named sub graph:** [TODO]

### Persona Gemeente Zeewolde

#### Scenario: Welke organisaties hebben eigendom in Zeewolde?

**Beschrijving**

[TODO]

**Originele SPARQL query**

```sparql
select 
# TODO
```

**Rewriten SPARQL query**

```sparql
select 
# TODO
```

**Named sub graph:** [Sub graph 'Zeewolde'](#sub-graph-zeewolde)
