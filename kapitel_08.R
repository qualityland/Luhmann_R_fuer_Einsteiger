#######################################################
#### Luhmann - R für Einsteiger - 5. Auflage      #####
#### Kapitel 8 - Univariate deskriptive Statistik #####
#######################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("erstis.RData")


# Pakete installieren und laden ----

install.packages("tidyverse") # muss nur einmalig durchgeführt werden
install.packages("psych") # muss nur einmalig durchgeführt werden
library(tidyverse)
library(psych)


#### Abschnitt 8.1: Häufigkeitstabellen ####

### 8.1.1	Absolute Häufigkeiten -----

table(erstis$wohnort.alt)

sort(table(erstis$wohnort.alt))


### 8.1.2	Relative Häufigkeiten -----

prop.table(table(erstis$wohnort.alt))

100*prop.table(table(erstis$wohnort.alt))

round(100*prop.table(table(erstis$wohnort.alt))) # runden ohne Nachkommastelle

round(100*prop.table(table(erstis$wohnort.alt)), 
      digits = 1) # runden mit Nachkommastelle


### 8.1.3	Integration der Häufigkeiten in einer Tabelle -----

absolut <- table(erstis$wohnort.alt) # absolute Häufigkeiten speichern

relativ <- prop.table(absolut) # relative Häufigkeiten speichern

prozent <- 100 * relativ # prozentuale Häufigkeiten speichern

haeufigkeiten <- cbind(absolut, relativ, prozent) # Objekte zusammenfassen

round(haeufigkeiten, digits = 2)



#### Abschnitt 8.2: Deskriptivstatistische Kennwerte ####

### 8.2.1	Die summary-Funktion -----

summary(erstis$wohnort.alt)

summary(erstis$extra)


### 8.2.2	Die describe-Funktion -----

auswahl <- erstis %>% dplyr::select(gewiss, extra) # reduzierten Datensatz erstellen

describe(auswahl)


### 8.2.3	Funktionen für einzelne Kennwerte -----

median(erstis$extra, na.rm = T)
mean(erstis$extra, na.rm = T)
min(erstis$extra, na.rm = T)
max(erstis$extra, na.rm = T)
range(erstis$extra, na.rm = T)
IQR(erstis$extra, na.rm = T)
sd(erstis$extra, na.rm = T)
var(erstis$extra, na.rm = T)
skew(erstis$extra) # Argument "na.rm = T" nicht nötig
kurtosi(erstis$extra) # Argument "na.rm = T" nicht nötig

## Modalwert bestimmen
table(erstis$wohnort.alt)

which.max(table(erstis$wohnort.alt)) # gibt Modalwert an

max(table(erstis$wohnort.alt)) # gibt Anzahl der Fälle in der häufigsten Kategorie an; ist nicht der Modalwert


### 8.2.4	Quantile -----

quantile(erstis$stim1, na.rm = TRUE)

quantile(erstis$stim1, na.rm = TRUE, probs = .4) # Wert unter dem 40% der Daten liegen

quantile(erstis$stim1, na.rm = TRUE, probs = c(.4, .6, .8)) # Werte unter denen 40%, 60% und 80% der Daten liegen



#### Abschnitt 8.3: Gruppenvergleiche ####

describeBy(erstis$extra, erstis$geschl)

describeBy(erstis$extra, erstis$geschl, mat = TRUE) # stellt Ergebnisse als Tabelle dar

describeBy(erstis$extra, list(erstis$geschl, erstis$berlin), 
           mat = TRUE)
