####################################################################
#### Luhmann - R für Einsteiger - 5. Auflage                   #####
#### Kapitel 21 - Poweranalysen und Stichprobenumfangsplanung  #####
####################################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Pakete installieren und laden ----

install.packages("pwr") # muss nur einmalig durchgeführt werden
library(pwr)



#### Abschnitt 21.1: Poweranalysen mit dem pwr-Paket ####

## Beispiel für den t-Test
pwr.t.test(d = 0.5, sig.level = 0.05, power = 0.8,
           type = "two.sample", alternative = "two.sided")

## Weitere Beispiele aus Tabelle 21.1
pwr.r.test(r = 0.3, sig.level = 0.05, power = 0.8,
           alternative = "two.sided")
pwr.f2.test(u = 4, f2 = 0.12, sig.level = 0.05, 
           power = 0.8)
pwr.anova.test(k = 3, f = 0.12, sig.level = 0.05, 
               power = 0.8)
pwr.chisq.test(w = 0.20, df = 3, sig.level = 0.05, 
               power = 0.8)



#### Abschnitt 21.2: Simulationsbasierte Poweranalysen ####

# Keine R-Befehle