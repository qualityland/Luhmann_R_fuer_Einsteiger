#######################################################
#### Luhmann - R für Einsteiger - 5. Auflage      #####
#### Kapitel 9 - Bivariate deskriptive Statistik  #####
#######################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("erstis.RData")


# Pakete installieren und laden ----

install.packages("tidyverse") # muss nur einmalig durchgeführt werden
install.packages("psych") # muss nur einmalig durchgeführt werden
install.packages("ppcor") # muss nur einmalig durchgeführt werden
install.packages("oii") # muss nur einmalig durchgeführt werden
library(tidyverse)
library(psych)
library(ppcor)
library(oii)


#### Abschnitt 9.1: Kontingenztabelle ####

### 9.1.1	Absolute Häufigkeiten -----

table(erstis$berlin, erstis$geschl)

addmargins(table(erstis$berlin, erstis$geschl)) # mit Randsummen

rowSums(table(erstis$berlin, erstis$geschl)) # Zeilensummen

colSums(table(erstis$berlin, erstis$geschl)) # Spaltensummen


### 9.1.2	Relative Häufigkeiten und Prozentwerte -----

## Relative Häufigkeiten in Bezug zur Gesamtsumme
prop.table(table(erstis$berlin, erstis$geschl))

addmargins(prop.table(table(erstis$berlin, erstis$geschl)))

## Relative Häufigkeiten in Bezug zur Zeilensumme
prop.table(table(erstis$berlin, erstis$geschl), 1)

## Relative Häufigkeiten in Bezug zur Spaltensumme
prop.table(table(erstis$berlin, erstis$geschl), 2)


### 9.1.3	Mehrdimensionale Kontingenztabellen -----

## Ein Beispiel mit drei kombinierten Variablen
table(erstis$berlin, erstis$geschl, erstis$wohnort.alt) 


#### Abschnitt 9.2: Zusammenhangsmaße für metrische Variablen ####

### 9.2.1	Produkt-Moment-Korrelation -----

auswahl <- erstis %>% dplyr::select(alter, abi, zuf.inh.1)

## cor-Funktion
cor(auswahl) # funktioniert wegen fehlender Werte nicht

cor(auswahl, use = "pairwise") # schließt paarweise aus

cor(auswahl, use = "complete") # berücksichtigt nur Personen mit Werten auf allen Variablen

## corr.test-Funktion
corr.test(auswahl) # gibt Korrelationskoeffizienten, Stichprobengröße und p-Werte an

corr.test(auswahl)$r # gibt nur die Korrelationskoeffizienten an

## Darstellung als Tabelle
d <- describe(auswahl)
k <- corr.test(auswahl)$r
t <- data.frame(M = d$mean, SD = d$sd, k) # legt Tabelle an mit M, SD und Korrelationen

## cor.test-Funktion
cor.test(erstis$abi, erstis$alter) # ungerichtetes Testen

cor.test(erstis$abi, erstis$alter, alternative = "less") # gerichtetes Testen

options(scipen=10) # Befehl um die Nachkommastellen bei p zu erhöhen


### 9.2.2	Kovarianz -----

cov(erstis$alter, erstis$abi, use = "complete")

cov(auswahl, use = "pairwise")

var(erstis$alter, na.rm = TRUE) 
# Kovarianz einer Variablen mit sich selbst entspricht der Varianz



#### Abschnitt 9.3: Zusammenhangsmaße für nicht-metrische Variablen ####

## Einige Beispiele

# Zusammenhang zwischen zwei dichotomen Variablen: Phi-Koeffizient
association.measures(erstis$berlin, erstis$geschl) 

# Zusammenhang zwischen einer dichotomen und einer polytomen Variablen: Cramers V
association.measures(erstis$wohnort.alt, erstis$geschl) 

