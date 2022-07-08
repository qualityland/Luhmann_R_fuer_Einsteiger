##################################################
#### Luhmann - R für Einsteiger - 5. Auflage  ####
#### Kapitel 5 - Objekte                      ####
##################################################



#### Abschnitt 5.1: Neue Objekte anlegen ####

round(mean(c(1,4,7,9)))

vektor <- c(1,4,7,9) # Vektor als Objekt anlegen

vektor # Objekt "vektor" anschauen

mittelwert <- mean(vektor) # Mittelwert berechnen und als Objekt speichern

mittelwert #  Mittelwert anzeigen

gerundeter.mittelwert <- round(mittelwert) # Mittelwert runden und als Objekt speichern

gerundeter.mittelwert # Gerundeten Mittelwert anzeigen


gerundeter.mittelwert <-  # mit dem nativen Pipe Operator (R >= 4.1)
  c(1,4,7,9) |>
  mean() |>
  round()

gerundeter.mittelwert # Gerundeten Mittelwert anzeigen



#### Abschnitt 5.2: Objekttypen ####

### 5.2.1	Vektoren -----

alter<- c(19,23,22,25,21,20,19) # Vektor "alter" anlegen

alter # Vektor "alter" anzeigen

length(alter) # Anzahl der Elemente des Vektors "alter" ausgeben


### 5.2.2	Faktoren -----

bez <- c(1,2,2,2,1,1,2) # Vektor "bez" anlegen

bez # Vektor "bez" ausgeben

bez.faktor <- factor(bez) # Faktor aus unserem Vektor erstellen

bez.faktor # Faktor "bez.faktor" ausgeben


### 5.2.3	Data Frames -----

beispiel.data.frame <- data.frame(alter, bez.faktor)
# erstellt aus dem Vektor "alter" und dem Faktor "bez.faktor" einen Data Frame

beispiel.data.frame # Data Frame ausgeben

names(beispiel.data.frame) # alle Variablennamen im Data Frame ausgeben

str(beispiel.data.frame) # detaillierte Informationen über unseren Data Frame

View(beispiel.data.frame) # Rohdaten in neuem Fenster betrachten


### 5.2.4 Weitere Objekte -----

class(beispiel.data.frame) # Klasse unseres Data Frames anzeigen

class(geschl.faktor) # Klasse unseres Faktors anzeigen

## Beispiele zu den Funktionen in Tabelle 5.1

x <- c(3,2,4) # Beispielvektor x anlegen
y <- c(5,3,6) # Beispielvektor y anlegen

c(x, y) # Vektoren zu einem Vektor der Länge 6 zusammenfügen

factor(x) # Vektor x in Faktor umwandeln

daten <- data.frame(x, y) # einen Datensatz aus den Vektoren x und y erstellen

cbind(x, y) 
# x und y als Spalten zu einer Matrix zusammenfügen
# es resultiert eine Matrix mit 3 Zeilen und 2 Spalten
rbind(x, y) 
# x und y als Zeilen zu einer Matrix zusammenfügen
# es resultiert eine Matrix mit 2 Zeilen und 3 Spalten

as_tibble(daten) # für diese Funktion ist es nötig das Paket dplyr zu laden

list(daten, x, y)



#### Abschnitt 5.3: Elemente aus Objekten auswählen ####

### 5.3.1	Das Dollarzeichen -----

beispiel.data.frame$alter # wählt die Spalte "alter" unseres Beispieldatensatzes aus


### 5.3.2	Die Index-Funktion -----

beispiel.data.frame$alter[2] # wählt den zweiten Wert der Spalte "alter" aus

beispiel.data.frame$alter[c(1, 3, 5)] # wählt die Werte 1, 3 und 5 der Spalte "alter" aus

beispiel.data.frame[3, 2] # wählt den Wert der dritten Zeile in der zweiten Spalte aus

names(beispiel.data.frame) # zeigt die Namen und Reihenfolge unserer Variablen im Datensatz an

beispiel.data.frame[, 1] # wählt alle Daten der ersten Spalte (also der Variable "alter") aus

beispiel.data.frame[-2, 1] # wählt alle Daten der ersten Spalte außer den Wert der zweiten Zeile aus



#### Abschnitt 5.4: Der Workspace ####

objects() # gibt alle Objekte im Workspace an

remove(alter) # löscht das Objekt "alter" aus dem Workspace

remove(list=ls()) # löscht alle Objekte aus dem Workspace



#### Abschnitt 5.5: Objekte Speichern und öffnen ####

### 5.5.1	Arbeitsverzeichnis festlegen -----

getwd() # zeigt aktuelles Arbeitsverzeichnis an

setwd("C:/Ordner1/Ordner2/R für Einsteiger") # legt ein neues Arbeitsverzeichnis fest
# Anmerkung: Hier muss das Arbeitsverzeichnis individuell angepasst werden 

dir() # zeigt alle Dateien das aktuellen Arbeitsverzeichnis an


### 5.5.2	Objekte als .RData-Datei speichern -----

# Da ja oben mit remove alle Objekte aus dem Workspace gelöscht wurden
# legen wir für die folgenden Befehle zunächst ein neues Beispielobjekt an
neues.objekt <- c(5, 4, 3, 1)

save(neues.objekt, file = "beispieldatei.RData") # speichert das Objekt im aktuellen Arbeitsverzeichnis

save(neues.objekt, file = "C:/Ordner1/dateiname.RData") # speichert Objekt im angegeben Ordner
# Anmerkung: Hier individuell sinnvollen Ordner festlegen

save.image(file = "workspace.RData") # speichert gesamten Workspace


### 5.5.3	.RData-Datei öffnen -----

# Damit wir prüfen können, ob öffnen funktioniert entfernen wir zunächst
# das "neue.objekt" aus unserem Workspace
remove(neues.objekt)

load("beispieldatei.RData") # die Datei "beispieldatei" wird aus unserem aktuellen Arbeitsverzeichnis geladen

load("C:/Ordner1/Ordner2/R für Einsteiger/dateiname.RData") # öffnet die Datei unter dem angegebenen Dateipfad
# Anmerkung: Hier individuell sinnvollen Dateipfad festlegen



### 5.7	Übungen -----


# (1) Geben Sie die Daten in Tabelle 5.2 in drei Vektoren ein.
# Nennen Sie diese Vektoren methode, woche1 und woche2.
methode <- c(1, 3, 2, 2, 3,  1,  3,  2,  1, 1)
woche1 <- c(4, 5, 9, 3, 3, 13, 11, 10, 12, 5)
woche2 <- c(6, 8, 12, 5, 6, 16, 14, 12, 13, 9)



# (2) Konvertieren Sie den Vektor methode in einen Faktor.
methode <- factor(methode)


# (3) Fassen Sie die drei Variablen in einem Data Frame zusammen.
# Geben Sie dem Data Frame den Namen basketball.
basketball <- data.frame(methode, woche1, woche2)
basketball


# (4) Lassen Sie sich die Werte der zweiten Variablen im Data Frame basketball auf
# zwei Arten ausgeben: (a) mit der Dollarzeichen-Funktion, (b) mit der Index-
#   Funktion.
basketball$woche1
basketball[, 2]

# (5) Speichern Sie den Data Frame unter dem Namen basketball.RData.
save(basketball, file = "basketball.RData")


# (6) Speichern Sie das Skript.
