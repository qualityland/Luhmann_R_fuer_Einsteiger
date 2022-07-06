##########################################################
#### Luhmann - R für Einsteiger - 5. Auflage          ####
#### Kapitel 4 - Einführung in die Programmiersprache ####
##########################################################



#### Vorbereitung ####

# Pakete installieren und laden ----

install.packages("dplyr") # muss nur einmalig durchgeführt werden
install.packages("psych")



#### Abschnitt 4.1: R als Taschenrechner ####

## Einfache Rechenaufgaben (Beispiele zu verschiedenen Rechenarten)

1+5+7

1*5+3 

(4-2)/2

4^8



#### Abschnitt 4.2: Logische Abfragen ####

3 > 2

3 == 2

3 < 2 & 2 < 3

3 < 2 | 2 < 3

"abcd" == "abcd"

"typ aus statistikkurs" == "grosse liebe"



#### Abschnitt 4.3: Funktionen ####

### 4.3.1	Ein erstes Beispiel -----

c(1,4,7,9) # Werte kombinieren

mean(c(1,4,7,9)) # Mittelwert berechnen

round(mean(c(1,4,7,9))) # Mittelwert runden


### 4.3.2	Funktionen aus zusätzlichen Paketen -----

library(dplyr) # Paket "dplyr" laden

dplyr::filter() # Verwenden der Filter-Funktion aus dem dyplr-Paket


### 4.3.3	Hilfe zu bestimmten Funktionen -----

library(psych) # Paket "psych" laden

help(describe) # Öffnet die Hilfe zur Funktion "describe"
?describe 



#### Abschnitt 4.4: Kommentare ####

# Ein Kommentar kann in einer eigenen Zeile stehen

1+5+7 # oder auch direkt hinter einem Befehl



#### Abschnitt 4.5: Ein paar Stilregeln ####

# Keine R-Befehle
