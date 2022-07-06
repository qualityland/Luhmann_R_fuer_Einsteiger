########################################################
#### Luhmann - R für Einsteiger - 5. Auflage       #####
#### Kapitel 11 - Wahrscheinlichkeitsverteilungen  #####
########################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("erstis.RData")

# Pakete installieren und laden ----

install.packages("ggplot2") # muss nur einmalig durchgeführt werden
install.packages("nortest") # muss nur einmalig durchgeführt werden
library(ggplot2)
library(nortest)



#### Abschnitt 11.1: Graphische Darstellung der Wahrscheinlichkeitsverteilung ####

## Dichtefunktion der t-Verteilung mit R-Basisfunktionen
curve(dt(x, 100), -3, 3) # 100 Freiheitsgrade

curve(dt(x, 1), lty = 2, add = TRUE) # 1 Freiheitsgrad

curve(dt(x, 10), lty = 3, add = TRUE) # 10 Freiheitsgrad

legend("topright", 
       c("df = 1", "df = 10", "df = 100"), 
       lty = c(2,3,1))

## Dichtefunktion der t-Verteilung mit ggplot2
ggplot(data.frame(x = c(-3,3)), aes(x = x)) +
  stat_function(fun = dt, args = list(df = 1),
                linetype = 2) +
  stat_function(fun = dt, args = list(df = 10),
                linetype = 3) +
  stat_function(fun = dt, args = list(df = 100),
                linetype = 1)



#### Abschnitt 11.2: Berechnung von Quantilen ####

qt(p = 0.025, df = 128) # 2,5%-Quantil der t-Verteilung mit 128 Freiheitsgraden

qt(p = 0.975, df = 128) # 97,5%-Quantil der t-Verteilung mit 128 Freiheitsgraden



#### Abschnitt 11.3: Berechnung von Flächenanteilen bzw. p-Werten ####

pt(q = -1.8, df = 128) # Wahrscheinlichkeit einen t-Wert kleiner/gleich -1,8 zu erhalten bei 128 df

1 - pt(q = -1.8, df = 128) # Bestimmen der Gegenwahrscheinlichkeit



#### Abschnitt 11.4: Tests für die Prüfung der Normalverteilungsannahme ####

lillie.test(erstis$neuro) # Testen einer Variablen

lillie.test(resid(lm(neuro ~ alter, data = erstis))) # Testen der Residuen eines Regressionsmodells
