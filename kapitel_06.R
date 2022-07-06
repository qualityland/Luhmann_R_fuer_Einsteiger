##################################################
#### Luhmann - R für Einsteiger - 5. Auflage  ####
#### Kapitel 6 - Daten importieren            ####
##################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 



#### Abschnitt 6.1: Daten aus Textdateien einlesen ####

## Mit Komma-getrennter csv-Datei
daten1 <- read.csv("Textdaten_komma.csv") # einlesen der csv-Datei

daten1 # Objekt "daten1" betrachten

class(daten1) # zeigt die Klasse unseres neuen Objekts an

## Mit Semikolon-getrennter csv-Datei
daten2 <- read.csv2("Textdaten_semikolon.csv") # einlesen der csv-Datei

daten2 # Objekt "daten2" betrachten

class(daten2) # zeigt die Klasse unseres neuen Objekts an

## Allgemeine Version mit dem Befehl "read.table"
daten3 <- read.table("Textdaten_komma.csv", dec = ".", sep = ",", header = T)

daten3 # Objekt "daten3" betrachten

class(daten3) # zeigt die Klasse unseres neuen Objekts an



#### Abschnitt 6.2: Andere Datenformate einlesen ####

# Keine R-Befehle 



#### Abschnitt 6.3: Daten betrachten ####

dim(daten1) # zeigt Anzahl der Zeilen und Anzahl der Spalten an

ncol(daten1) # zeigt Anzahl der Spalten an

nrow(daten1) # zeigt Anzahl der Zeilen an

head(daten1) # zeigt die ersten 6 Zeilen des Objekts



#### Abschnitt 6.4: Daten speichern ####

# Keine R-Befehle 
