###################################################
#### Luhmann - R für Einsteiger - 5. Auflage  #####
#### Kapitel 20 - Mehrebenenanalyse           #####
###################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("kultur.RData")

# Pakete installieren und laden ----

install.packages("lme4") # muss nur einmalig durchgeführt werden
install.packages("performance") # muss nur einmalig durchgeführt werden
install.packages("tidyverse") # muss nur einmalig durchgeführt werden
install.packages("lmerTest") # muss nur einmalig durchgeführt werden
install.packages("lattice") # muss nur einmalig durchgeführt werden
install.packages("emmeans") # muss nur einmalig durchgeführt werden
install.packages("interactions") # muss nur einmalig durchgeführt werden
library(lme4)
library(performance)
library(tidyverse)
library(lmerTest)
library(lattice)
library(emmeans)
library(interactions)



#### Abschnitt 20.1: Das Nullmodell ####

# Ojekt anlegen
modell.1 <- lme4::lmer(lezu ~ 1 + (1 | nation), data = kultur)

# Ausgabe anfordern
summary(modell.1)

# Intraklassenkorrelation
performance::icc(modell.1)



#### Abschnitt 20.2: Das Random-Intercept-Modell ####

# Objekt anlegen
modell.2 <- lme4::lmer(lezu ~ pa + (1 | nation), data = kultur)

# Ausgabe anfordern
summary(modell.2)


### 20.2.1 Signifikanztests für die festen Effekte -----

## Modellvergleich mit Devianzentest

anova(modell.1, modell.2)

## Approximative Freiheitsgrade

# Modell erneut schätzen
modell.2 <- lmerTest::lmer(lezu ~ pa + (1 | nation), data = kultur)

# Ausgabe anfordern
summary(modell.2)


### 20.2.2 Zentrierung von Ebene-1-Prädiktoren -----

## Zentrierung am Gesamtmittelwert
kultur$pa.zen.ges <- scale(kultur$pa, scale = FALSE)

## Zentrierung am Gruppenmittelwert
kultur <- kultur %>%
  group_by(nation) %>%
  mutate(pa.zen.gm = pa - mean(pa, na.rm = TRUE))



#### Abschnitt 20.3: Das Random-Slopes-Modell ####

# Objekt anlegen
modell.3 <- lmerTest::lmer(lezu ~ pa.zen.gm + (pa.zen.gm | nation),
                           data = kultur)

# Ausgabe anfordern
summary(modell.3)

## Signifikanztests für Zufallseffekte

# Random-Intercept Modell mit zentrierter Variable
modell.2a <- lmerTest::lmer(lezu ~ pa.zen.gm + (1 | nation),
                            data = kultur)

# Modellvergleich
anova(modell.2a, modell.3)

## Graphische Darstellung
dotplot(ranef(modell.3, condVar = TRUE))



#### Abschnitt 20.4: Modelle mit Ebene-2-Prädiktoren ####

## Zentrierung von Ebene-2-Prädiktoren
kultur$gdp.zen <- scale(kultur$gdp, scale = FALSE)

## Modell mit Prädiktoren auf Ebene 2 ohne Interaktionen

# Objekt anlegen
modell.4 <- lmerTest::lmer(lezu ~ pa.zen.gm + gdp.zen +
                          (pa.zen.gm | nation), data = kultur)

# Ausgabe anfordern
summary(modell.4)

## Modell mit Prädiktoren auf Ebene 2 mit Cross-Level-Interaktion

# Objekt anlegen
modell.5 <- lmerTest::lmer(lezu ~ pa.zen.gm * gdp.zen +
                          (pa.zen.gm | nation), data = kultur)

# Ausgabe anfordern
summary(modell.5)


## Bedingte Regressionsgleichungen und Interaktionsdiagramm
emtrends(modell.5, var = "pa.zen.gm", specs = "gdp.zen",
         at = list(gdp.zen = c(-.16, .16)))

interact_plot(modell.5, pred = pa.zen.gm, modx = gdp.zen,
              interval = TRUE , modx.values = "plus-minus")
