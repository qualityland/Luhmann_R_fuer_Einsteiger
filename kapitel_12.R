##########################################################
#### Luhmann - R für Einsteiger - 5. Auflage         #####
#### Kapitel 12 - Mittelwertsvergleiche mit t-Tests  #####
##########################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("erstis.RData")

# Pakete installieren und laden ----

install.packages("tidyverse") # muss nur einmalig durchgeführt werden
install.packages("psych") # muss nur einmalig durchgeführt werden
install.packages("effsize") # muss nur einmalig durchgeführt werden
install.packages("car") # muss nur einmalig durchgeführt werden
library(tidyverse)
library(psych)
library(effsize)
library(car)


#### Abschnitt 12.1: Einstichproben t-Test ####

### 12.1.1 Stichprobengröße und deskriptive Statistiken -----

describe(erstis$neuro)


### 12.1.2 Durchführung des Einstichproben t-Tests -----

## Ungerichtete Hypothese: Zweiseitiger Test
t.test(erstis$neuro, mu = 3.3)

## Gerichtete Hypothese: Einseitiger Test
t.test(erstis$neuro, mu = 3.3, alternative = "greater") # Alternativhypothese mit Zeichen >

t.test(erstis$neuro, mu = 3.3, alternative = "less") # Alternativhypothese mit Zeichen <

## Konfidenzintervall anpassen
t.test(erstis$neuro, mu = 3.3, conf.level = 0.99) # 99%-Konfidenzintervall


### 12.1.3 Effektgröße -----

effsize::cohen.d(d = erstis$neuro, f = NA, mu = 3.3, 
                 na.rm = TRUE)



#### Abschnitt 12.2: t-Test für unabhängige Stichproben ####

### 12.2.1 Stichprobengröße und deskriptive Statistiken -----

describeBy(erstis$neuro, erstis$geschl, mat = TRUE)

describeBy(erstis$gewiss, erstis$geschl, mat = TRUE)$n # Stichprobengröße für die Variable Gewissenhaftigkeit


### 12.2.2 Überprüfung der Varianzhomogenität -----

leveneTest(erstis$neuro, erstis$geschl) # Varianzhomogenität liegt vor

leveneTest(erstis$gewiss, erstis$geschl) # Varianzhomogenität liegt nicht vor


### 12.2.3 t-Test für unabhängige Stichproben bei Varianzgleichheit -----

t.test(neuro ~ geschl, data = erstis , var.equal = TRUE)


### 12.2.4 Welch-Test für unabhängige Stichproben bei Varianzungleichheit -----

t.test(gewiss ~ geschl, data = erstis)


### 12.2.5 Weitere Einstellungen -----

## Einseitiger vs. zweiseitiger Test
levels(erstis$geschl) # Reihenfolge der Ausprägungen anzeigen lassen

t.test(neuro ~ geschl, data = erstis , var.equal = TRUE, alternative = "less") # Prüfen, ob Männer höhere Werte als Frauen haben

## Konfidenzintervall anpassen
t.test(gewiss ~ geschl, data = erstis, conf.level = 0.99)


### 12.2.6 Effektgröße -----

effsize::cohen.d(neuro ~ geschl, data = erstis)



#### Abschnitt 12.3: t-Test für abhängige Stichproben ####

### 12.3.1 Stichprobengröße und deskriptive Statistiken -----

# Datensatz erstellen ohne fehlende Werte, der nur interessierende Variablen enthält
auswahl <- na.omit(select(erstis, zuf.inh.1, zuf.inh.2))

describe(auswahl)

cor(auswahl) # Korrelation der beiden Messzeitpunkte


### 12.3.2 Durchführung des t-Tests für abhängige Stichproben -----

# Hier: einseitiger Test
t.test(erstis$zuf.inh.1, erstis$zuf.inh.2, 
       paired = TRUE, alternative = "greater") 


### 12.3.3 Effektgröße -----

effsize::cohen.d(d = erstis$zuf.inh.1, f = erstis$zuf.inh.2, 
                 paired = TRUE, na.rm = TRUE)
