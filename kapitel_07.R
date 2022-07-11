##################################################
#### Luhmann - R für Einsteiger - 5. Auflage #####
#### Kapitel 7 - Datenaufbereitung            ####
##################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("./data/Minidaten_1.RData")
load("./data/Minidaten_2.RData")
load("./data/Minidaten_3.RData")


# Pakete installieren und laden ----

#install.packages("tidyverse") # muss nur einmalig durchgeführt werden
library(tidyverse)


# Sicherheitskopie der Daten speichern ----

d1 <- daten1
d2 <- daten2 
d3 <- daten3

# Erläuterung: Die im Buch abgedruckten Beispiel-Befehle basieren immer 
# auf der Annahme, dass wir den ursprünglichen Data Frame verwenden.
# Wir speichern daher für jeden Data Frame eine Sicherheitskopie, damit
# wir den unberührten Zustand jederzeit wiederherstellen können.

# Die in diesem Skript enthaltenen Befehle beginnen meistens mit einem Befehl 
# dieser Art: 

# daten1 <- d1

# Damit wird der ursprüngliche Data Frame wiederhergestellt.
# BEI DER NORMALEN DATENAUFBEREITUNG IST DAS NICHT NOTWENDIG.



#### Abschnitt 7.1: Klassische und moderne Datenaufbereitung ####

# Keine R-Befehle 



#### Abschnitt 7.2: Variablen erstellen und bearbeiten ####

### 7.2.1	Neue Variablen zum Data Frame hinzufügen: R-Basispakete -----

## R-Basisfunktionen

daten1 <- d1 # Ursprüngliche Version des Data Frames wird wiederhergestellt

daten1$gebjahr <- 2020 - daten1$alter


### 7.2.1	Neue Variablen zum Data Frame hinzufügen: tidyverse -----

daten1 <- d1 # Ursprüngliche Version des Data Frames wird wiederhergestellt

daten1 <- daten1 %>% mutate(gebjahr = 2020 - alter)


### 7.2.2	Variablen umbenennen: R-Basispakete -----

## Alle Variablen werden umbenannt

daten1 <- d1 # ursprüngliche Version des Data Frames wird wiederhergestellt

names(daten1) # ursprüngliche Dateinamen anzeigen

names(daten1) <- c("id", "age", "extra", "sex")

names(daten1) # neue Variablennamen ausgeben


## Ausgewählte Variablen werden umbenannt (hier: 2. und 4. Variable)

daten1 <- d1 # ursprüngliche Version des Data Frames wird wiederhergestellt

names(daten1) # ursprüngliche Dateinamen anzeigen

names(daten1)[c(2,4)] <- c("age", "sex")

names(daten1) # neue Variablennamen ausgeben


### 7.2.2	Variablen umbenennen: tidyverse -----

daten1 <- d1 # ursprüngliche Version des Data Frames wird wiederhergestellt

daten1 <- daten1 %>% dplyr::rename(
  age = alter,
  sex = geschl)

names(daten1)


### 7.2.3	Variablentyp ändern: R-Basispakete -----

## Aktuelle Variablentypen abrufen
str(daten1)

## Vektor wird in Faktor umgewandelt: ohne Wertelabels

daten1 <- d1

daten1$geschl.f <- factor(daten1$geschl) # erstellt einen Faktor 

class(daten1$geschl.f) # Prüfen, ob unsere Umwandlung erfolgreich war
levels(daten1$geschl.f)

# CAVE: wenn wir jetzt den Faktor in eine Zahl umwandeln, werden als Basis
#       die Labels verwendet und einfach durchnumeriert:
#       "0" -> 1
#       "1" -> 2
daten1$geschl.num <- as.numeric(daten1$geschl.f)
head(daten1)

## Vektor wird in Faktor umgewandelt: mit Wertelabels

daten1 <- d1

daten1$geschl.f <- factor(daten1$geschl,
                          levels = c(0, 1),
                          labels = c("m", "w"))

levels(daten1$geschl.f) # Prüfen, ob unsere Umwandlung erfolgreich war
head(daten1)

# Faktor wird in numerischen Vektor umgewandelt

levels(daten1$geschl.f)

# umwandeln des Faktors in eine numerische Variable
daten1$geschl.num <- as.numeric(daten1$geschl.f) 
class(daten1$geschl.num)

head(daten1) # zeigt die ersten 6 Zeilen unseres Datensatzes


### 7.2.3	Variablentyp ändern: tidyverse -----

## Vektor wird in Faktor umgewandelt: ohne Wertelabels

daten1 <- d1

daten1 <- daten1 %>% mutate(
  geschl.f = factor(geschl))

daten1 

# Vektor wird in Faktor umgewandelt: mit Wertelabels

daten1 <- d1

daten1 <- daten1 %>% mutate(
  geschl.f = factor(geschl, 
                    levels = c(0,1),
                    labels = c("m", "w")))

daten1 


# Faktor wird in numerischen Vektor umgewandelt

daten1 <- daten1 %>% mutate(
  geschl.num = as.numeric(geschl.f))

daten1


### 7.2.4	Variablen zentrieren und standardisieren: R-Basispakete -----

daten1 <- d1

## Standardisieren
daten1$alter.z <- scale(daten1$alter)
str(daten1)

## Am Mittelwert zentrieren
daten1$alter.cen <- scale(daten1$alter, scale = FALSE)
str(daten1)


### 7.2.4	Variablen zentrieren und standardisieren: tidyverse -----

daten1 <- d1

## Standardisieren und am Mittelwert zentrieren
daten1 <- daten1 %>% mutate(
  alter.z = scale(alter),
  alter.cen = scale(alter, scale = FALSE))

daten1


### 7.2.5	Variablen umpolen: R-Basispakete ----- 

daten2 <- d2

daten2$neuro_2r <- 6 - daten2$neuro_2 

table(daten2$neuro_2, daten2$neuro_2r) # prüfen, ob Umkodieren erfolgreich war


### 7.2.5	Variablen umpolen: tidyverse -----  

daten2 <- d2

daten2 <- daten2 %>% mutate(neuro_2r = 6 - neuro_2)


### 7.2.6	Variablen umkodieren: R-Basispakete -----  

## Beispiel 1: Fasse die Kategorien 4 und 5 zusammen (aus 5 mach 4),
#  alle anderen Werte bleiben intakt
daten2 <- d2

which(daten2$neuro_1 >= 4) # gibt die Fälle aus, bei denen "neuro_1" >= 4 ist

# gibt die Werte der Fälle aus, bei denen "neuro_1" >= 4 ist
daten2$neuro_1[which(daten2$neuro_1 >= 4)]

# setzt 4 als neuen Wert fest für alle Fälle bei denen "neuro_1" >= 4 ist
daten2$neuro_1[which(daten2$neuro_1 >= 4)] <- 4 

## Beispiel 2: Komplexe Umkodierungen (ohne ifelse-Funktion)
daten2 <- d2

daten2$neuro_1r[which(daten2$neuro_1 <= 2)] <- 1 # Werte <= 2 durch 1 ersetzten
daten2$neuro_1r[which(daten2$neuro_1 >= 3)] <- 2 # Werte >= 3 durch 2 ersetzten

daten2$neuro_1r # zeigt neue Variable an

## Variablen umkodieren mit der ifelse-Funktion
daten2 <- d2
daten2$neuro_1r <- ifelse(daten2$neuro_1 <= 2, 1, 2)

daten2$neuro_1r # zeigt neue Variable an

daten2 <- d2
daten2$neuro_1r <- ifelse(daten2$neuro_1 <= 2, 1, 
                          ifelse(daten2$neuro_1 == 3, 2, 3))

daten2$neuro_1r # zeigt neue Variable an
daten2$neuro_1 # alte Variable


### 7.2.6	Variablen umkodieren: tidyverse -----  

daten2 <- d2

daten2 <- daten2 %>% mutate(
  neuro_1_rec = recode(daten2$neuro_1,
                                      '1' = 1,
                                      '2' = 1,
                                      '3' = 2,
                                      '4' = 2,
                                      '5' = 2))

daten2$neuro_1_rec # neue Variable anzeigen

daten2 <- daten2 %>% mutate(
  neuro_1r = recode(neuro_1,
                       '1' = 1,
                       '2' = 1,
                       .default = 2))

daten2$neuro_1r # neue Variable anzeigen


## Umkodierung prüfen

table(daten2$neuro_1, daten2$neuro_1r)


## Fehlende Werte umkodieren 

daten2 <- d2

is.na(daten2$neuro_1) # gibt uns an, ob ein fehlender Wert vorliegt


### 7.2.7 Skalenwerte berechnen: R-Basispakete -----  

## Vorab: Item neuro_2 umpolen
daten2 <- d2
daten2$neuro_2r <- 6 - daten2$neuro_2 

## über Formel
daten2$neuro <- (daten2$neuro_1 + daten2$neuro_2r + 
                 daten2$neuro_3) / 3

# rowMeans-Funktion

daten2$neuro <- rowMeans(data.frame(daten2$neuro_1, 
                         daten2$neuro_2r, daten2$neuro_3))

daten2$neuro <- rowMeans(data.frame(daten2$neuro_1, 
                         daten2$neuro_2r, daten2$neuro_3),
                         na.rm = TRUE)


### 7.2.7 Skalenwerte berechnen: tidyverse -----  

daten2 <- daten2 %>% mutate(
  neuro.mean = (neuro_1 + neuro_2r + neuro_3) / 3, 
  neuro.sum = rowSums(data.frame(neuro_1, neuro_2r, neuro_3)))



#### Abschnitt 7.3: Data Frames anpassen ####

### 7.3.1 Variablen auswählen: R-Basispakete -----  

## Auswahl mit dem Dollarzeichen
daten2 <- d2 

auswahl <- data.frame(daten2$extra_1, daten2$extra_2, 
                      daten2$extra_3)
str(auswahl) # Variablenname verändert sich

auswahl <- data.frame(extra_1 = daten2$extra_1, 
                      extra_2 = daten2$extra_2, 
                      extra_3 = daten2$extra_3)
str(auswahl) # Variablenname bleibt unverändert


## Auswahl über die Index-Funktion 
daten2 <- d2

names(daten2)

auswahl <- daten2[, 5:7]
str(auswahl)

auswahl <- daten2[, c("extra_1", "extra_2", "extra_3")]
str(auswahl)


### 7.3.1 Variablen auswählen: tidyverse -----  

## Variablen auswählen über dplyr:select

auswahl <- daten2 %>% select(extra_1, extra_2, extra_3)
str(auswahl)

## Variablen auswählen ohne Eingabe aller Variablennamen

auswahl <- daten2 %>% select(contains("extra"))
str(auswahl)

## Variablen ausschließen

auswahl <- daten1 %>% select(-id, -extra)


### 7.3.2 Fälle auswählen: R-Basispakete -----  

## Fälle auswählen mit der subset-Funktion

sub <- subset(daten1, subset = alter >= 20)

sub <- subset(daten1, subset = !alter < 20)

## Fälle auswählen mit der which-Funktion 

which(daten1$alter >= 20)

sub <- daten1[which(daten1$alter >= 20), ]
sub <- daten1[-which(daten1$alter < 20), ] # Fehlende Werte bleiben drin


### 7.3.2 Fälle auswählen: tidyverse -----   

sub <- daten1 %>% dplyr::filter(alter >= 20)


### 7.3.3 Zeilen mit fehlenden Werten entfernen: R-Basispakete -----   

daten1 <- d1

daten1_ohna <- na.omit(daten1)

nrow(daten1) # Anzahl der Zeilen im ursprünglichen Datensatz
nrow(daten1_ohna) # Anzahl der Zeilen im neuen Datensatz


### 7.3.3 Zeilen mit fehlenden Werten entfernen: tidyverse -----   

daten1 <- d1

# Alle Zeilen mit fehlenden Werten auf irgendwelchen Variablen werden entfernt
daten1_ohna <- drop_na(daten1) 

# Zeilen mit fehlenden Werten auf "extra" werden entfernt
nrow(daten1_ohna.2)
daten1_ohna.2 <- daten1 %>% drop_na(extra) 


#### Abschnitt 7.4: Data Frames sortieren #### 

### 7.4. Data Frames sortieren: R-Basispakete -----   

daten1 <- d1

order(daten1$alter) # gibt die Reihenfolge an

daten1[order(daten1$alter), ]

daten1[order(daten1$alter, decreasing = TRUE), ] #sortiert absteigend nach Alter

## Nach mehreren Variablen sortieren
order(daten1$alter, daten1$extra)

daten1[order(daten1$alter, daten1$extra), ]


### 7.4. Data Frames sortieren: tidyverse -----   

daten1 <- d1

daten1 %>% arrange(alter)

daten1 %>% arrange(desc(alter))

## Nach mehreren Variablen sortieren
daten1 %>% arrange(alter, desc(extra))



#### Abschnitt 7.5: Data Frames zusammenfügen ####

### 7.5.1 Fälle zusammenfügen: R-Basisfunktionen -----

# Data Frames sind identisch aufgebaut
alle_vpn <- rbind(daten1, daten3)

nrow(alle_vpn)


### 7.5.1 Fälle zusammenfügen: tidyverse -----

# Data Frames sind identisch
alle_vpn <- bind_rows(daten1, daten3)

# Data Frames sind nicht identisch aufgebaut
bind_rows(daten1[,-2], daten3[,-3])


### 7.5.2 Variablen zusammenfügen: R-Basisfunktionen -----

daten1$id # IDs in beiden Datensätzen anzeigen
daten2$id

beide.min <- merge(daten1, daten2, by = "id")
beide.min$id # nur Fälle, die in beiden Datensätzen vorhanden sind

beide.max <- merge(daten1, daten2, by = "id", all = TRUE)
beide.max$id # Fälle aus beiden Datensätzen

beide.x <- merge(daten1, daten2, by = "id", all.x = TRUE)
beide.x$id # alle Fälle aus daten1 bleiben erhalten

beide.y <- merge(daten1, daten2, by = "id", all.y = TRUE)
beide.y$id # alle Fälle aus daten2 bleiben erhalten


### 7.4.2 Variablen zusammenfügen: tidyverse -----

beide.min <- inner_join(daten1, daten2, by = "id")
beide.min$id # nur Fälle, die in beiden Datensätzen vorhanden sind

beide.max <- full_join(daten1, daten2, by = "id")
beide.max$id # Fälle aus beiden Datensätzen

beide.x <- left_join(daten1, daten2, by = "id")
beide.x$id # alle Fälle aus daten1 bleiben erhalten

beide.y <- right_join(daten1, daten2, by = "id")
beide.y$id # alle Fälle aus daten2 bleiben erhalten



#### Abschnitt 7.6: Data Frames umstrukturieren ####

### 7.6.1 Von Wide zu Long ----- 

daten2

## Schritt 1: Umstrukturierung ins Ultralong-Format

ultralang <- daten2 %>% pivot_longer(
  cols = -c(id, wohnort),
  names_to = "varname",
  values_to = "wert")
ultralang

# bei diesem Befehl wird zusätzlich der Variablenname aufgeteilt
# in den Teil, der die Variable bezeichnete und den Teil, der den 
# Messzeitpunkt angibt
ultralang <- daten2 %>% pivot_longer(
    cols = -c(id, wohnort),
    names_to = c("varname", "mzp"),
    names_sep = "_",
    values_to = "wert")
ultralang 

## Schritt 2: Umstrukturierung ins Long-Format

lang <- ultralang %>% pivot_wider(
  names_from = varname,
  values_from = wert)
lang


### 7.6.2 Von Long zu Wide ----- 

breit <- lang %>% pivot_wider(
  names_from = mzp, 
  values_from = -c(id, wohnort, mzp),
  names_sep = ".")
breit



#### Abschnitt 7.7: Fortgeschrittene Datenaufbereitung ####

## Beispiel für die Pipe

lang <- daten2 %>% 
  pivot_longer(
    cols = -c(id, wohnort),
    names_to = c("varname", "mzp"),
    names_sep = "_",
    values_to = "wert") %>% 
  pivot_wider(
    names_from = varname,
    values_from = wert)


