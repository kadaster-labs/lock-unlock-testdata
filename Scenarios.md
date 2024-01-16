# Scenario's

In dit project hebben we verschillende scenario's bedacht om te bedenken en aan te tonen dat 'het' werkt.
Het doel is om (gekoppelde) gegevens af te schermen en toegankelijk te maken voor geautoriseerde persona’s.

Hieronder staan de persona's, de scenario's van wat ze willen vragen binnen een bepaalde context en de SPARQL-query's die zijn geschreven om deze vragen te beantwoorden. Omdat de gegevens die worden opgevraagd niet allemaal open data zijn, is een autorisatie-implementatie vereist. Momenteel benaderen wij deze machtiging op twee manieren:

1. Bij de **SPARQL Rewrite** implementatie wordt ervan uitgegaan dat een herschrijving van de SPARQL-query vereist is om gegevens te beveiligen. Deze herschreven vraag wordt hieronder voor elk scenario gedefinieerd om de implementatie van deze aanpak te ondersteunen.

2. Bij de implementatie van **Subset** veronderstelt de creatie van een subset van de gegevens op basis van specifieke geautoriseerde grenzen die voor elke persona zijn gedefinieerd. Op deze subset wordt vervolgens de oorspronkelijke door de gebruiker gedefinieerde SPARQL-query uitgevoerd.

Om de implementatie van beide benaderingen te ondersteunen, moeten er per scenario drie SPARQL-query's worden geschreven: 1) de query die de subset voor elke persona definieert. 2) de vraag die bij elk gebruikersscenario hoort. 3) de herschreven SPARQL-query die gegevens beschermt waartoe een gebruiker geen toegang heeft. De volgende afbeelding illustreert de interactie tussen deze SPARQL-query's en de twee implementaties.

*Figuur 1.* Vereiste SPARQL-query's voor de implementatie van SPARQL-eindpuntautorisatie.
[TODO]

Let op: de query die de subset van de gegevens creëert, wordt geïmplementeerd op het niveau van de persona voordat er scenario's/gebruikersquery's worden gedefinieerd en is onafhankelijk van deze door de gebruiker gedefinieerde query's. In tegenstelling, per scenario wordt een nieuwe herschreven SPARQL-query gegenereerd op basis van de inhoud van de door de gebruiker gedefinieerde query.

### Persona Anomieme gebruiker

**Beschrijving**

[TODO]

#### Subset
Hier opgeslagen: https://data.labs.kadaster.nl/lock-unlock/-/queries/subset-anonieme-gebruiker

```sparql
PREFIX geo: <http://www.opengis.net/ont/geosparql#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX imxgeo: <http://modellen.geostandaarden.nl/def/imx-geo#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix nen3610: <http://modellen.geostandaarden.nl/def/nen3610-2022#>
CONSTRUCT {
  ?adres
    a imxgeo:Adres ; 
    imxgeo:huisnummer ?huisnummer ;
    imxgeo:omschrijving ?omschrijving ;
    imxgeo:postcode ?postcode ;
    imxgeo:straatnaam ?straatnaam ;
    nen3610:domein ?domeinAdres ;
    nen3610:identificatie ?identificatieAdres ;
    imxgeo:isAdresVanGebouw ?gebouw ;
    imxgeo:huisletter ?huisletter ;
    imxgeo:huisnummertoevoeging ?huisnummertoevoeging .

    ?gebouw
      a imxgeo:Gebouw ;
        imxgeo:heeftAlsAdres ?adres ;
        imxgeo:bouwjaar ?bouwjaar ;
        imxgeo:bevindZichOpPerceel ?perceel ;
        nen3610:domein ?domein ;
        nen3610:identificatie ?identificatie ;
        imxgeo:status ?status ;
        imxgeo:typeGebouw ?typeGebouw .
  	?typeGebouw owl:hasValue ?typeGebouwLabel .
    
    ?perceel
      a imxgeo:Perceel ;
        imxgeo:bevatBouwwerk ?gebouw ;
        imxgeo:ligtInRegistratieveRuimte ?registratieveRuimtePerceel ;
        nen3610:domein ?domeinPerceel ;
        nen3610:identificatie ?identificatiePerceel ;
        imxgeo:hasMetricArea ?oppervlakteGebouw ;
        imxgeo:year ?year ;
        geo:hasGeometry ?geometryPerceel0.
    ?geometryPerceel0 
      a geo:Geometry ;
        geo:asWKT ?perceelGeoGebouw . 
    
    ?registratieveRuimtePerceel 
      a ?typeRegistratieveRuimte ;
        imxgeo:bevatPerceel ?perceel ;
        nen3610:domein ?domeinRegistratieveRuimtePerceel ;
        nen3610:identificatie ?identificatieRegistratieveRuimtePerceel ;
        rdfs:label ?rrNaamPerceel ;
        geo:hasGeometry ?rrGeoPerceel ;
    	imxgeo:wordtBestuurdDoorGemeente ?gemeente ;
        imxgeo:wijkcode ?wijkcode ;
        imxgeo:buurtcode ?buurtcode . 
    ?rrGeoPerceel
      a geo:Geometry ;
        geo:asWKT ?rrGeoGeometryPerceel .
    ?gemeente
      a imxgeo:Gemeente ;
      imxgeo:bestuurdGebied ?registratieveRuimtePerceel ;
      nen3610:domein ?domeinGemeenteGebied ;
      nen3610:identificatie ?identificatieGemeenteGebied .
} 
WHERE {
  {
    ?adres
      a imxgeo:Adres ; 
  		imxgeo:huisnummer ?huisnummer ;
  		imxgeo:omschrijving ?omschrijving ;
 		imxgeo:postcode ?postcode ;
  		imxgeo:straatnaam ?straatnaam ;
  		nen3610:domein ?domeinAdres ;
  		nen3610:identificatie ?identificatieAdres ;
  		imxgeo:isAdresVanGebouw ?gebouw . 
    optional { ?adres imxgeo:huisletter ?huisletter }
    optional { ?adres imxgeo:huisnummertoevoeging ?huisnummertoevoeging }

    ?gebouw
      a imxgeo:Gebouw ;
        imxgeo:heeftAlsAdres ?adres ;
        imxgeo:bouwjaar ?bouwjaar ;
        imxgeo:bevindZichOpPerceel ?perceel ;
        nen3610:domein ?domeinGebouw ;
        nen3610:identificatie ?identificatie .

    optional { ?gebouw imxgeo:status ?status }
    optional { ?gebouw imxgeo:typeGebouw ?typeGebouw .
      		   ?typeGebouw owl:hasValue ?typeGebouwLabel }
    
    ?perceel
      a imxgeo:Perceel ;
        imxgeo:bevatBouwwerk ?gebouw ;
        imxgeo:ligtInRegistratieveRuimte ?registratieveRuimtePerceel ;
        nen3610:domein ?domeinPerceel ;
        nen3610:identificatie ?identificatiePerceel ;
        imxgeo:hasMetricArea ?oppervlakte ;
        imxgeo:year ?year ;
        geo:hasGeometry ?geometryPerceel0.
    ?geometryPerceel0 
      a geo:Geometry ;
        geo:asWKT ?perceelGeo . 
    
    ?registratieveRuimtePerceel 
      a ?typeRegistratieveRuimte ;
        imxgeo:bevatPerceel ?perceel ;
        nen3610:domein ?domeinRegistratieveRuimtePerceel ;
        nen3610:identificatie ?identificatieRegistratieveRuimtePerceel ;
        rdfs:label ?rrNaamPerceel ;
        geo:hasGeometry ?rrGeoPerceel . 
    ?rrGeoPerceel
      a geo:Geometry ;
        geo:asWKT ?rrGeoGeometryPerceel .
    
    optional { ?registratieveRuimtePerceel imxgeo:wordtBestuurdDoorGemeente ?gemeente.
      ?gemeente
        imxgeo:bestuurdGebied ?registratieveRuimtePerceel ;
        nen3610:domein ?domeinGemeenteGebied ;
        nen3610:identificatie ?identificatieGemeenteGebied .
    }
    optional { ?registratieveRuimtePerceel imxgeo:wijkcode ?wijkcode }
    optional { ?registratieveRuimtePerceel imxgeo:buurtcode ?buurtcode }
  }
}
```

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

### Persona Woningcorperatie

**Beschrijving**

[TODO]

#### Subset
Hier opgeslagen: https://data.labs.kadaster.nl/lock-unlock/-/queries/subset-woningcorporatie/

```sparql
PREFIX brk: <https://data.labs.kadaster.nl/lock-unlock/brk/def/>
PREFIX geo: <http://www.opengis.net/ont/geosparql#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX imxgeo: <http://modellen.geostandaarden.nl/def/imx-geo#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix nen3610: <http://modellen.geostandaarden.nl/def/nen3610-2022#>
CONSTRUCT {
  ?adres
    a imxgeo:Adres ; 
    imxgeo:huisnummer ?huisnummer ;
    imxgeo:omschrijving ?omschrijving ;
    imxgeo:postcode ?postcode ;
    imxgeo:straatnaam ?straatnaam ;
    nen3610:domein ?domeinAdres ;
    nen3610:identificatie ?identificatieAdres ;
    imxgeo:isAdresVanGebouw ?gebouw ;
    imxgeo:huisletter ?huisletter ;
    imxgeo:huisnummertoevoeging ?huisnummertoevoeging .

    ?gebouw
      a imxgeo:Gebouw ;
        imxgeo:heeftAlsAdres ?adres ;
        imxgeo:bouwjaar ?bouwjaar ;
        imxgeo:bevindZichOpPerceel ?perceel ;
        nen3610:domein ?domein ;
        nen3610:identificatie ?identificatie ;
        imxgeo:status ?status ;
        imxgeo:typeGebouw ?typeGebouw .
  	?typeGebouw owl:hasValue ?typeGebouwLabel .
    
    ?perceel
      a imxgeo:Perceel ;
        imxgeo:bevatBouwwerk ?gebouw ;
        imxgeo:ligtInRegistratieveRuimte ?registratieveRuimtePerceel ;
        nen3610:domein ?domeinPerceel ;
        nen3610:identificatie ?identificatiePerceel ;
        imxgeo:hasMetricArea ?oppervlakteGebouw ;
        imxgeo:year ?year ;
    	imxgeo:laatsteKoopsom ?bedrag ;
        geo:hasGeometry ?geometryPerceel0.
    ?geometryPerceel0 
      a geo:Geometry ;
        geo:asWKT ?perceelGeoGebouw . 
    
    ?registratieveRuimtePerceel 
      a ?typeRegistratievRuimte ;
        imxgeo:bevatPerceel ?perceel ;
        nen3610:domein ?domeinRegistratieveRuimtePerceel ;
        nen3610:identificatie ?identificatieRegistratieveRuimtePerceel ;
        rdfs:label ?rrNaamPerceel ;
        geo:hasGeometry ?rrGeoPerceel ;
    	imxgeo:wordtBestuurdDoorGemeente ?gemeente ;
        imxgeo:wijkcode ?wijkcode ;
        imxgeo:buurtcode ?buurtcode . 
    ?rrGeoPerceel
      a geo:Geometry ;
        geo:asWKT ?rrGeoGeometryPerceel .
    ?gemeente
      a imxgeo:Gemeente ;
      imxgeo:bestuurdGebied ?registratieveRuimtePerceel ;
      nen3610:domein ?domeinGemeenteGebied ;
      nen3610:identificatie ?identificatieGemeenteGebied .
  
  ?zakelijkRecht 
    a brk:ZakelijkRecht ;
    brk:rustOp ?perceel ;
    nen3610:identificatie ?identificatieZakelijkRecht ;
    nen3610:domein ?domeinZakelijkRecht . 
  ?tenaamstelling 
    a brk:Tenaamstelling ;
    brk:van ?zakelijkRecht ;
    nen3610:identificatie ?identificatieTenaamstelling ;
    nen3610:domein ?domeinTenaamstelling ;
    brk:aandeelNoemer ?noemer ;
    brk:aandeelTeller ?teller ;
    brk:omschrijving ?omschrijving ;
    brk:tenNameVan ?persoon . 
  ?persoon
    a ?persoonType ;
    nen3610:identificatie ?identificatiePersoon ;
    nen3610:domein ?domeinPersoon .   
  ?bedrag 
    a imxgeo:Bedrag ;
    nen3610:identificatie ?identificatieBedrag ;
    nen3610:domein ?domeinBedrag ;
    imxgeo:valuta ?value . 
} 
WHERE {
  {
    ?adres
      a imxgeo:Adres ; 
      imxgeo:huisnummer ?huisnummer ;
      imxgeo:omschrijving ?omschrijving ;
      imxgeo:postcode ?postcode ;
      imxgeo:straatnaam ?straatnaam ;
      nen3610:domein ?domeinAdres ;
      nen3610:identificatie ?identificatieAdres ;
      imxgeo:isAdresVanGebouw ?gebouw . 
    optional { ?adres imxgeo:huisletter ?huisletter }
    optional { ?adres imxgeo:huisnummertoevoeging ?huisnummertoevoeging }

    ?gebouw
      a imxgeo:Gebouw ;
      imxgeo:heeftAlsAdres ?adres ;
      imxgeo:bouwjaar ?bouwjaar ;
      imxgeo:bevindZichOpPerceel ?perceel ;
      nen3610:domein ?domeinGebouw ;
      nen3610:identificatie ?identificatie .

    optional { ?gebouw imxgeo:status ?status }
    optional { ?gebouw imxgeo:typeGebouw ?typeGebouw .
      ?typeGebouw owl:hasValue ?typeGebouwLabel }

    ?perceel
      a imxgeo:Perceel ;
      imxgeo:bevatBouwwerk ?gebouw ;
      imxgeo:ligtInRegistratieveRuimte ?registratieveRuimtePerceel ;
      nen3610:domein ?domeinPerceel ;
      nen3610:identificatie ?identificatiePerceel ;
      imxgeo:hasMetricArea ?oppervlakte ;
      imxgeo:year ?year ;
      geo:hasGeometry ?geometryPerceel0.
    ?geometryPerceel0 
      a geo:Geometry ;
      geo:asWKT ?perceelGeo . 

    ?registratieveRuimtePerceel 
      a ?typeRegistratievRuimte ;
      imxgeo:bevatPerceel ?perceel ;
      nen3610:domein ?domeinRegistratieveRuimtePerceel ;
      nen3610:identificatie ?identificatieRegistratieveRuimtePerceel ;
      rdfs:label ?rrNaamPerceel ;
      geo:hasGeometry ?rrGeoPerceel . 
    ?rrGeoPerceel
      a geo:Geometry ;
      geo:asWKT ?rrGeoGeometryPerceel .

    optional { ?registratieveRuimtePerceel imxgeo:wordtBestuurdDoorGemeente ?gemeente.
      ?gemeente
        imxgeo:bestuurdGebied ?registratieveRuimtePerceel ;
        nen3610:domein ?domeinGemeenteGebied ;
        nen3610:identificatie ?identificatieGemeenteGebied .
    }
    optional { ?registratieveRuimtePerceel imxgeo:wijkcode ?wijkcode }
    optional { ?registratieveRuimtePerceel imxgeo:buurtcode ?buurtcode }
  }
  union
  { service <insert_gesloten_brk_endpoint> {
      {
        ?persoon
          a ?persoonType ;
          nen3610:identificatie ?identificatiePersoon ;
          nen3610:domein ?domeinPersoon . 
        filter ( ?persoonType = brk:NietNatuurlijkPersoon )
        filter ( ?persoon = <bedrijf:woningCorporatieX> )
      }
      ?tenaamstelling 
        a brk:Tenaamstelling ;
        brk:tenNameVan ?persoon ;
        brk:van ?zakelijkRecht ;
        nen3610:identificatie ?identificatieTenaamstelling ;
        nen3610:domein ?domeinTenaamstelling ;
        brk:aandeelNoemer ?noemer ;
        brk:aandeelTeller ?teller ;
        brk:omschrijving ?omschrijving .
      ?zakelijkRecht 
        a brk:ZakelijkRecht ;
        brk:rustOp ?perceel ;
        nen3610:identificatie ?identificatieZakelijkRecht ;
        nen3610:domein ?domeinZakelijkRecht . 
      ?perceel 
        imxgeo:laatsteKoopsom ?bedrag .
      ?bedrag 
        a imxgeo:Bedrag ;
        nen3610:identificatie ?identificatieBedrag ;
        nen3610:domein ?domeinBedrag ;
        imxgeo:valuta ?value . 
    }
  }
}
```

#### Scenario: Welk eigendom hebben wij in bezit?

**User Gedefineerde Query**

```sparql
select 
# TODO
```

**Rewritten SPARQL query**

```sparql
select 
# TODO
```


### Persona Gemeente Zeewolde

**Beschrijving**

[TODO]

#### Subset
Hier opgeslagen: https://data.labs.kadaster.nl/lock-unlock/-/queries/subset-gemeente-zeewolde/

```sparql
PREFIX ik: <https://data.federatief.datastelsel.nl/lock-unlock/informatiekundigekern/def/>
PREFIX anbi: <https://data.federatief.datastelsel.nl/lock-unlock/anbi/def/>
PREFIX brp: <https://data.federatief.datastelsel.nl/lock-unlock/brp/def/>
PREFIX nhr: <https://data.federatief.datastelsel.nl/lock-unlock/nhr/def/>
PREFIX brk: <https://data.labs.kadaster.nl/lock-unlock/brk/def/>
PREFIX geo: <http://www.opengis.net/ont/geosparql#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX imxgeo: <http://modellen.geostandaarden.nl/def/imx-geo#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix nen3610: <http://modellen.geostandaarden.nl/def/nen3610-2022#>
CONSTRUCT {
  ?adres
    a imxgeo:Adres ; 
    imxgeo:huisnummer ?huisnummer ;
    imxgeo:omschrijving ?omschrijving ;
    imxgeo:postcode ?postcode ;
    imxgeo:straatnaam ?straatnaam ;
    nen3610:domein ?domeinAdres ;
    nen3610:identificatie ?identificatieAdres ;
    imxgeo:isAdresVanGebouw ?gebouw ;
    imxgeo:huisletter ?huisletter ;
    imxgeo:huisnummertoevoeging ?huisnummertoevoeging .

  ?gebouw
    a imxgeo:Gebouw ;
    imxgeo:heeftAlsAdres ?adres ;
    imxgeo:bouwjaar ?bouwjaar ;
    imxgeo:bevindZichOpPerceel ?perceel ;
    nen3610:domein ?domein ;
    nen3610:identificatie ?identificatie ;
    imxgeo:status ?status ;
    imxgeo:typeGebouw ?typeGebouw .
  ?typeGebouw owl:hasValue ?typeGebouwLabel .

  ?perceel
    a imxgeo:Perceel ;
    imxgeo:bevatBouwwerk ?gebouw ;
    imxgeo:ligtInRegistratieveRuimte ?registratieveRuimtePerceel ;
    nen3610:domein ?domeinPerceel ;
    nen3610:identificatie ?identificatiePerceel ;
    imxgeo:hasMetricArea ?oppervlakteGebouw ;
    imxgeo:year ?year ;
    imxgeo:laatsteKoopsom ?bedrag ;
    geo:hasGeometry ?geometryPerceel0.
  ?geometryPerceel0 
    a geo:Geometry ;
    geo:asWKT ?perceelGeoGebouw . 

  ?registratieveRuimtePerceel 
    a ?typeRegistratievRuimte ;
    imxgeo:bevatPerceel ?perceel ;
    nen3610:domein ?domeinRegistratieveRuimtePerceel ;
    nen3610:identificatie ?identificatieRegistratieveRuimtePerceel ;
    rdfs:label ?rrNaamPerceel ;
    geo:hasGeometry ?rrGeoPerceel ;
    imxgeo:wordtBestuurdDoorGemeente ?gemeente ;
    imxgeo:wijkcode ?wijkcode ;
    imxgeo:buurtcode ?buurtcode . 
  ?rrGeoPerceel
    a geo:Geometry ;
    geo:asWKT ?rrGeoGeometryPerceel .
  ?gemeente
    a imxgeo:Gemeente ;
    imxgeo:bestuurdGebied ?registratieveRuimtePerceel ;
    nen3610:domein ?domeinGemeenteGebied ;
    nen3610:identificatie ?identificatieGemeenteGebied .

  ?zakelijkRecht 
    a brk:ZakelijkRecht ;
    brk:rustOp ?perceel ;
    nen3610:identificatie ?identificatieZakelijkRecht ;
    nen3610:domein ?domeinZakelijkRecht . 
  ?tenaamstelling 
    a brk:Tenaamstelling ;
    brk:van ?zakelijkRecht ;
    nen3610:identificatie ?identificatieTenaamstelling ;
    nen3610:domein ?domeinTenaamstelling ;
    brk:aandeelNoemer ?noemer ;
    brk:aandeelTeller ?teller ;
    brk:omschrijving ?omschrijving ;
    brk:tenNameVan ?persoon . 
  ?persoon
    a ?persoonType ;
    nen3610:identificatie ?identificatiePersoon ;
    nen3610:domein ?domeinPersoon .   
  ?bedrag 
    a imxgeo:Bedrag ;
    nen3610:identificatie ?identificatieBedrag ;
    nen3610:domein ?domeinBedrag ;
    imxgeo:valuta ?value . 
  ?rechtspersoon
    a nhr:Rechtspersoon ;
    nen3610:identificatie ?identificatieRechtspersoon ;
    nen3610:domein ?domeinRechtspersoon ;
    nhr:kvkNummer ?kvkNummer ;
    nhr:naam ?naam ;
    nhr:rechtsvorm ?rechtsvorm ;
    nhr:sbiNummer ?sbiNummer ;
    owl:sameAs ?instelling ;
    ik:heeftUBO ?geregistreerdPersoon .
  ?geregistreerdPersoon
    a brp:GeregistreerdPersoon ;
    nen3610:identificatie ?identificatieGeregistreerdPersoon ;
    nen3610:domein ?domeinGeregistreerdPersoon ;
    brp:achternaam ?achternaam ;
    brp:bsn ?bsn ;
    brp:geboortedatum ?geboortedatum ;
    brp:geslacht ?geslacht ;
    brp:voornamen ?voornamen .
  ?instelling
    a anbi:Instelling ;
    nen3610:identificatie ?identificatieInstelling ;
    nen3610:domein ?domeinInstelling ;
    anbi:naam ?naam ;
    anbi:vestigingsPlaats ?registratieveRuimtePerceel .
} 
WHERE {
  {
    ?adres
      a imxgeo:Adres ; 
    imxgeo:huisnummer ?huisnummer ;
    imxgeo:omschrijving ?omschrijving ;
    imxgeo:postcode ?postcode ;
    imxgeo:straatnaam ?straatnaam ;
    nen3610:domein ?domeinAdres ;
    nen3610:identificatie ?identificatieAdres ;
    imxgeo:isAdresVanGebouw ?gebouw . 
    optional { ?adres imxgeo:huisletter ?huisletter }
    optional { ?adres imxgeo:huisnummertoevoeging ?huisnummertoevoeging }

    ?gebouw
      a imxgeo:Gebouw ;
      imxgeo:heeftAlsAdres ?adres ;
      imxgeo:bouwjaar ?bouwjaar ;
      imxgeo:bevindZichOpPerceel ?perceel ;
      nen3610:domein ?domeinGebouw ;
      nen3610:identificatie ?identificatie .

    optional { ?gebouw imxgeo:status ?status }
    optional { ?gebouw imxgeo:typeGebouw ?typeGebouw .
      ?typeGebouw owl:hasValue ?typeGebouwLabel }

    ?perceel
      a imxgeo:Perceel ;
      imxgeo:bevatBouwwerk ?gebouw ;
      imxgeo:ligtInRegistratieveRuimte ?registratieveRuimtePerceel ;
      nen3610:domein ?domeinPerceel ;
      nen3610:identificatie ?identificatiePerceel ;
      imxgeo:hasMetricArea ?oppervlakte ;
      imxgeo:year ?year ;
      geo:hasGeometry ?geometryPerceel0.
    ?geometryPerceel0 
      a geo:Geometry ;
      geo:asWKT ?perceelGeo . 

    ?registratieveRuimtePerceel 
      a ?typeRegistratievRuimte ;
      imxgeo:bevatPerceel ?perceel ;
      nen3610:domein ?domeinRegistratieveRuimtePerceel ;
      nen3610:identificatie ?identificatieRegistratieveRuimtePerceel ;
      rdfs:label ?rrNaamPerceel ;
      geo:hasGeometry ?rrGeoPerceel . 
    ?rrGeoPerceel
      a geo:Geometry ;
      geo:asWKT ?rrGeoGeometryPerceel .

    optional { ?registratieveRuimtePerceel imxgeo:wordtBestuurdDoorGemeente ?gemeente.
      ?gemeente
        imxgeo:bestuurdGebied ?registratieveRuimtePerceel ;
        nen3610:domein ?domeinGemeenteGebied ;
        nen3610:identificatie ?identificatieGemeenteGebied .
    }
    optional { ?registratieveRuimtePerceel imxgeo:wijkcode ?wijkcode }
    optional { ?registratieveRuimtePerceel imxgeo:buurtcode ?buurtcode }
  }
  union
  { select * {
      { select * {
          { service <insert_gesloten_brk_endpoint> {
              ?persoon
                a ?persoonType ;
                nen3610:identificatie ?identificatiePersoon ;
                nen3610:domein ?domeinPersoon . 
              ?tenaamstelling 
                a brk:Tenaamstelling ;
                brk:tenNameVan ?persoon ;
                brk:van ?zakelijkRecht ;
                nen3610:identificatie ?identificatieTenaamstelling ;
                nen3610:domein ?domeinTenaamstelling ;
                brk:aandeelNoemer ?noemer ;
                brk:aandeelTeller ?teller ;
                brk:omschrijving ?omschrijving .
              ?zakelijkRecht 
                a brk:ZakelijkRecht ;
                brk:rustOp ?perceel ;
                nen3610:identificatie ?identificatieZakelijkRecht ;
                nen3610:domein ?domeinZakelijkRecht . 
              ?perceel 
                imxgeo:laatsteKoopsom ?bedrag .
              ?bedrag 
                a imxgeo:Bedrag ;
                nen3610:identificatie ?identificatieBedrag ;
                nen3610:domein ?domeinBedrag ;
                imxgeo:valuta ?value . 
            }
          }
          ?perceel imxgeo:ligtInRegistratieveRuimte ?registratieveRuimtePerceel .
          filter ( ?registratieveRuimtePerceel = <gemeente:zeewolde>)
        }
      }
      { select distinct * {
          { select * {
              { service <insert_gesloten_nhr> {
                  ?rechtspersoon
                    a nhr:Rechtspersoon ;
                   nen3610:identificatie ?identificatieRechtspersoon ;
                   nen3610:domein ?domeinRechtspersoon ;
                   nhr:kvkNummer ?kvkNummer ;
                   nhr:naam ?naam ;
                   nhr:rechtsvorm ?rechtsvorm ;
                   nhr:sbiNummer ?sbiNummer ;
                   owl:sameAs ?instelling ;
                   ik:heeftUBO ?geregistreerdPersoon . 
                }
              }
              ?rechtspersoon owl:sameAs ?persoon .
            }
          }
          union 
          {  select distinct * {
              { service <insert_gesloten_brp> {
                  ?geregistreerdPersoon
                    a brp:GeregistreerdPersoon ;
                    nen3610:identificatie ?identificatieGeregistreerdPersoon ;
                    nen3610:domein ?domeinGeregistreerdPersoon ;
                    brp:achternaam ?achternaam ;
                    brp:bsn ?bsn ;
                    brp:geboortedatum ?geboortedatum ;
                    brp:geslacht ?geslacht ;
                    brp:voornamen ?voornamen . 
                }
              }
              ?geregistreerdPersoon owl:sameAs ?persoon .
            }
          }
        }
      }
      union {
        { select distinct * {
            { service <insert_anbi> {
                ?instelling
                  a anbi:Instelling ;
                  nen3610:identificatie ?identificatieInstelling ;
                  nen3610:domein ?domeinInstelling ;
                  anbi:naam ?naam ;
                  anbi:vestigingsPlaats ?registratieveRuimtePerceel . 
              }
            }
          }
        }
      }
    }
  }
}
```

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

