##########################################################
#### Luhmann - R für Einsteiger - 5. Auflage         #####
#### Kapitel 19 - Lineare Strukturgleichungsmodelle  #####
##########################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("erstis.RData")

# Pakete installieren und laden ----

install.packages("lavaan") # muss nur einmalig durchgeführt werden
install.packages("semPlot") # muss nur einmalig durchgeführt werden
library(lavaan)
library(semPlot)



#### Abschnitt 19.1: Multiple Regression mit lavaan ####

# Modellspezifikation
reg.txt <- 'lz.1 ~ neuro + extra'

# Modellschätzung
reg.fit <- sem(reg.txt, data = erstis)

# Ausgabe anfordern
summary(reg.fit)

summary(reg.fit, standardized = TRUE) # standardisierte Regressionskoeffizienten 

summary(reg.fit, rsquare = TRUE) # mit R-Quadrat



#### Abschnitt 19.2: Pfadmodell mit Mediatorvariable ####

# Modellspezifikation
med1.txt <- 'prok ~ gewiss
             lz.1 ~ prok + gewiss'

# Modellschätzung
med1.fit <- sem(med1.txt, data = erstis)

# Ausgabe anfordern
summary(med1.fit)

# Modellspezifikation mit indirektem Effekt
med2.txt <- 'prok ~ a*gewiss
             lz.1 ~ b*prok + c*gewiss
             indirekt := a*b
             total := c + (a*b)'

# Modellschätzung mit Bootstrapping
med2.fit <- sem(med2.txt, data = erstis, se = "bootstrap")

# Ausgabe anfordern
summary(med2.fit)

parameterEstimates (med2.fit, ci = TRUE,
                    boot.ci.type = "bca.simple")



#### Abschnitt 19.3: Konfirmatorische Faktorenanalyse ####

## Einfaktorielles Modell

# Modellspezifikation
cfa.1.txt <- 'f =~ lz13 + lz14 + lz15 + lz16 + lz17'

# Modellschätzung
cfa.1.fit <- cfa(cfa.1.txt, data = erstis)

# Ausgabe anfordern
summary(cfa.1.fit, fit = TRUE)

fitMeasures(cfa.1.fit) # Modellgütemaße

modindices(cfa.1.fit) # Modifikationsindizes

## Modellvergleiche

# Modellspezifikation
cfa.2.txt <- 'f1 =~ lz13 + lz14 + lz15
              f2 =~ lz16 + lz17'

# Modellschätzung
cfa.2.fit <- cfa(cfa.2.txt, data = erstis)

# Modellvergleich
anova(cfa.1.fit, cfa.2.fit)



#### Abschnitt 19.4: Kombination von Mess- und Strukturmodell ####

# Modellspezifikation
sem.txt <- 'zuf =~ zuf.inh.1 + zuf.bed.1 + zuf.bel.1
            lz =~ lz13 + lz14 + lz15
            lz ~ zuf'

# Modellschätzung
sem.fit <- sem(sem.txt, data = erstis)

# Ausgabe anfordern
summary(sem.fit, fit = TRUE)



#### Abschnitt 19.5: Erstellen eines Pfaddiagramms ####

semPaths(sem.fit)

semPaths(sem.fit, whatLabels = "est", layout = "spring",
         layoutSplit = TRUE, rotation = 2)



#### Abschnitt 19.6: Weitere Funktionen und ergänzende Pakete ####

# Keine R-Befehle