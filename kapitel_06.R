##################################################
#### Luhmann - R für Einsteiger - 5. Auflage  ####
#### Kapitel 6 - Daten importieren            ####
##################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 



#### Abschnitt 6.1: Daten aus Textdateien einlesen ####

## Mit Komma-getrennter csv-Datei
daten1 <- read.csv("./data/Textdaten_komma.csv") # einlesen der csv-Datei

daten1 # Objekt "daten1" betrachten

class(daten1) # zeigt die Klasse unseres neuen Objekts an

## Mit Semikolon-getrennter csv-Datei
daten2 <- read.csv2("./data/Textdaten_semikolon.csv") # einlesen der csv-Datei

daten2 # Objekt "daten2" betrachten

class(daten2) # zeigt die Klasse unseres neuen Objekts an

## Allgemeine Version mit dem Befehl "read.table"
daten3 <- read.table("./data/Textdaten_komma.csv", dec = ".", sep = ",", header = T)

daten3 # Objekt "daten3" betrachten

class(daten3) # zeigt die Klasse unseres neuen Objekts an



#### Abschnitt 6.2: Andere Datenformate einlesen ####

# Keine R-Befehle 



#### Abschnitt 6.3: Daten betrachten ####

dim(daten1) # zeigt Anzahl der Zeilen und Anzahl der Spalten an

ncol(daten1) # zeigt Anzahl der Spalten an

nrow(daten1) # zeigt Anzahl der Zeilen an

head(daten1) # zeigt die ersten 6 Zeilen des Objekts

names(daten1) # zeigt die Variablennamen an

str(daten1)  # zeigt Variablen, Datentyp und Beispieldaten

summary(daten1) # zeigt Min/Max, Quartile, Mean und NAs


#### Abschnitt 6.4: Daten speichern ####

# Keine R-Befehle 



#### Abschnitt 6.7: Übungen ####

# Im Open Science Framework (https://osf.io/) stellen viele Wissenschaftlerinnen
# und Wissenschaftler ihre Daten zur Verfügung. Gehen Sie auf die Startseite und
# klicken Sie auf »Search«. Dort können Sie nach Projekten zu verschiedenen
# Forschungsthemen suchen (z.B. »life satisfaction«). Suchen Sie ein Projekt zu
# einem Sie interessierenden Forschungsthema, das offene Daten zur Verfügung
# stellt.
# Laden Sie die Daten herunter, lesen Sie sie in R ein und speichern Sie die
# Daten in einer .RData-Datei.

# Schweiz: Todesfälle pro Woche 2010 - 2022 (https://mortality.org)
mort_CH <- read.csv("./data/mort_ch.csv", na.strings = ".")

str(mort_CH)
table(mort_CH$Jahr)
summary(mort_CH)

save(mort_CH, file = "./data/mort_CH.Rda")

load(file = "./data/mort_CH.Rda")
