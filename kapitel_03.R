##################################################
#### Luhmann - R für Einsteiger - 5. Auflage  ####
#### Kapitel 3 - Ein erster Überblick         ####
##################################################



#### Abschnitt 3.1: RStudio im Überblick ####

### 3.1.1	Die Konsole -----

# Erläuterung: Keine R-Befehle für das Skript. Die hier in die 
# Konsole eingetragenen Rechnungen können aber auch einfach ins 
# Skript geschrieben werden, dann wird das Ergebnis in der Konsole 
# angezeigt.


### 3.1.2 Das Skript-Fenster -----

(3+7+2)/3 # ohne Umbruch

(3+7+2) / # mit Umbruch
  3

### 3.1.3 Das Environment-Fenster -----

# Keine R-Befehle 


### 3.1.4 Files, Plots, Packages, Help, Viewer -----

# Keine R-Befehle 


### 3.1.5 RStudio anpassen -----

# Keine R-Befehle 


### 3.1.6 RStudio schließen -----

# Keine R-Befehle 



#### Abschnitt 3.2: Zusätzliche Pakete ####

### 3.2.1 Pakete installieren -----

install.packages("psych", dependencies = TRUE)


### 3.2.2 Pakete laden -----

library() # Liste aller installierter Pakete

library(psych) # Paket psych laden

search() # Liste aller gelanderer Pakete anzeigen


### 3.2.3 Pakete aktualisieren -----

update.packages(ask = FALSE)



#### Abschnitt 3.3: Hilfe zu R ####


### 3.3.1 Hilfe in RStudio -----

# Keine R-Befehle 


### 3.3.2 Hilfe zu bestimmten Paketen und Funktionen -----

# Anmerkung: Im Buch sind die folgenden Befehle allgemein gehalten.
# Hier werden sie am Beispiel des Pakets "psych" und der Funktion "alpha"
# aus dem psych-Paket ausgeführt.

library(psych) # Nur erforderlich, wenn Paket noch nicht geladen ist

help(psych) # Hilfe zum psych-Paket laden
?psych

help(alpha) # Hilfe zur Funktion "alpha"
?alpha

help.search("alpha") # Liste aller Pakete, die Begriff "alpha" enthalten
??alpha


### 3.3.3 Hilfe im Internet -----

# Keine R-Befehle 


### 3.3.4 Bücher -----

# Keine R-Befehle 
