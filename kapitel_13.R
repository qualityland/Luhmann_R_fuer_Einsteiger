############################################################
#### Luhmann - R für Einsteiger - 5. Auflage           #####
#### Kapitel 13 - Varianzanalyse ohne Messwiederholung #####
############################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("therapie.RData")
load("haustier.RData")

# Pakete installieren und laden ----

install.packages("tidyverse") # muss nur einmalig durchgeführt werden
install.packages("psych") # muss nur einmalig durchgeführt werden
install.packages("afex") # muss nur einmalig durchgeführt werden
install.packages("emmeans") # muss nur einmalig durchgeführt werden
install.packages("ggbeeswarm") # muss nur einmalig durchgeführt werden
install.packages("jtools") # muss nur einmalig durchgeführt werden
library(tidyverse)
library(psych)
library(afex)
library(emmeans)
library(ggbeeswarm)
library(jtools)



#### Abschnitt 13.1: Einfaktorielle Varianzanalyse ohne Messwiederholung ####

### 13.1.1 Deskriptive Statistiken -----

desk <- describeBy(haustier$wohlbefinden, haustier$tierart, 
                   mat = TRUE)

print(desk, digits = 2)


### 13.1.2 Durchführung der einfaktoriellen Varianzanalyse -----

## ANOVA als Objekt anlegen
anova.1 <- aov_car(wohlbefinden ~ tierart + Error(ID), data = haustier)

## Ausgabe anzeigen
anova.1 # publikationsfertig

summary(anova.1) # mit mehr Nachkommastellen

anova.1$Anova # mit Quadratsummen und mittleren Quadratsummen


### 13.1.3 Posthoc-Tests und Kontraste -----

## Objekt für Paarvergleiche anlegen
ph.1 <- emmeans(anova.1, specs = "tierart")

## Ausgabe anzeigen
ph.1 # zeigt Mittelwerte und Konfidenzintervalle für Mittelwerte

pairs(ph.1) # zeigt Paarvergleiche an


### 13.1.4 Graphische Ergebnisdarstellung -----

## Darstellung der Gruppenmittelwerte mit Konfidenzintervall
afex_plot(anova.1, x = "tierart")

plot(ph.1)

## Violinen-Diagramm im APA-Thema
p1 <- afex_plot(anova.1, x = "tierart",
                data_geom = geom_violin)
p1 + jtools::theme_apa()



#### Abschnitt 13.2: Mehrfaktorielle Varianzanalyse ohne Messwiederholung ####

### 13.2.1 Deskriptive Statistiken -----

desk <- describeBy(therapie$meter, 
                   list(therapie$diagnose, therapie$gruppe), 
                   mat = TRUE)

print(desk, digits = 2)


### 13.2.2 Durchführung der mehrfaktoriellen Varianzanalyse -----

## ANOVA als Objekt anlegen
anova.2 <- aov_car(meter ~ diagnose * gruppe + Error(ID),
                   data = therapie)

## Ausgabe anzeigen
anova.2 # publikationsfertig

summary(anova.2) # mit mehr Nachkommastellen

anova.2$Anova # mit Quadratsummen und mittleren Quadratsummen

## Partielles Eta bestimmen
nice(anova.2, es = "pes")


### 13.2.3 Posthoc-Tests und Kontraste -----

## Alle paarweisen Vergleiche
ph.2 <- emmeans(anova.2, specs = ~ diagnose * gruppe)

pairs(ph.2)

## Testen bedingter Mittelwertsdifferenzen
ph.3 <- emmeans(anova.2, specs = ~gruppe | diagnose)
ph.3 <- emmeans(anova.2, specs = "gruppe", by = "diagnose")

pairs(ph.3)


### 13.2.4 Graphische Ergebnisdarstellung -----

afex_plot(anova.2, x = "gruppe", trace = "diagnose")

plot(ph.3)
