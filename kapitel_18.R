###########################################################
#### Luhmann - R für Einsteiger - 5. Auflage          #####
#### Kapitel 18 - Verfahren für die Testkonstruktion  #####
###########################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("bigfive.items.RData")

# Pakete installieren und laden ----

install.packages("psych") # muss nur einmalig durchgeführt werden
install.packages("GPArotation") # muss nur einmalig durchgeführt werden
install.packages("tidyverse") # muss nur einmalig durchgeführt werden
library(psych)
library(GPArotation)
library(tidyverse)



#### Abschnitt 18.1: Exploratorische Faktorenanalyse ####

### 18.1.1 Deskriptive Analysen und Bartlett-Test -----

cor.plot(bigfive.items)

cortest.bartlett(bigfive.items)


### 18.1.2 Bestimmung der Anzahl der Faktoren -----

fa.parallel(bigfive.items) # Parallelanalyse

VSS(bigfive.items)


### 18.1.3 Durchführung der Faktorenanalyse -----

## Objekt anlegen
fa.ml <- fa(bigfive.items, nfactors = 5, fm = "ml",
            rotate = "promax")

## Ausgabe anfordern
print(fa.ml, digits = 2, cut = .3, sort = TRUE)


### 18.1.4 Alternativen zur exploratorischen Faktorenanalyse -----

# Keine R-Befehle



#### Abschnitt 18.2: Itemanalyse und interne Konsistenz ####

## Items auswählen
gewiss <- select(bigfive.items, bf03, bf07, bf11, bf20)

## Itemanalyse
psych::alpha(gewiss)
psych::omega(gewiss)