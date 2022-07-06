############################################################
#### Luhmann - R für Einsteiger - 5. Auflage           #####
#### Kapitel 15 - Grundlagen der Regressionsanalyse    #####
############################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("erstis.RData")

# Pakete installieren und laden ----

install.packages("tidyverse") # muss nur einmalig durchgeführt werden
install.packages("psych") # muss nur einmalig durchgeführt werden
install.packages("ggplot2") # muss nur einmalig durchgeführt werden
install.packages("car") # muss nur einmalig durchgeführt werden
library(tidyverse)
library(psych)
library(ggplot2)
library(car)



#### Abschnitt 15.1: Einfache lineare Regression ####

### 15.1.1 Graphische Darstellung -----

ggplot(erstis, aes(x = neuro, y = lz.1)) +
  geom_jitter() +
  stat_smooth(method = loess) +
  xlab("Neurotizismus") + ylab("Lebenszufriedenheit")


### 15.1.2 Berechnung der unstandardisierten Regressionskoeffizienten -----

lm(lz.1 ~ neuro, data = erstis)


### 15.1.3 Berechnung der standardisierten Regressionskoeffizienten -----

lm(scale(lz.1) ~ scale(neuro), data = erstis)

# Exakte Vorgehensweise
auswahl <- na.omit(select(erstis, neuro, lz.1))
lm(scale(lz.1) ~ scale(neuro), data = auswahl)


### 15.1.4 Signifikanztests der Regressionskoeffizienten -----

## Regression als Objekt anlegen
einf.reg <- lm(lz.1 ~ neuro, data = erstis)

## Ausgabe anfordern
summary(einf.reg)


### 15.1.5 Konfidenzintervalle für die Regressionskoeffizienten -----

confint(einf.reg)

confint(einf.reg,level = .99)


### 15.1.6 Vorhergesagte Werte und Residuen -----

fitted(einf.reg) # Vorhergesagte Werte

resid(einf.reg) # Residuen

predict(einf.reg, data.frame(neuro = 4)) # Vorhersage für x-Wert von 4 



#### Abschnitt 15.2: Multiple Regression ####

## Regression als Objekt anlegen
mult.reg <- lm(lz.1 ~ neuro + extra, data = erstis)

## Ausgabe anfordern
summary(mult.reg)

## Spezifische Komponenten anfordern
str(mult.reg)
summary(mult.reg)$coefficients # Tabelle der Regressionskoeffizienten
summary(mult.reg)$residuals # Residuen



#### Abschnitt 15.3: Hierarchische Regression ####

## Stichprobe auswählen
data.red <- na.omit(select(erstis, lz.1, neuro, extra,
                           neuro, gewiss, vertraeg, intell))
nrow(data.red)

## Regressionsmodelle anlegen
modell.1 <- lm(lz.1 ~ neuro + extra, data = data.red)
modell.2 <- lm(lz.1 ~ neuro + extra + gewiss + vertraeg +
               intell, data = data.red)

## Modellvergleich durchführen
summary(modell.1)$r.squared
summary(modell.2)$r.squared

summary(modell.2)$r.squared - summary(modell.1)$r.squared

anova(modell.1, modell.2)

## Vergleich über Informationskriterien
AIC(modell.1, modell.2)



#### Abschnitt 15.4: Modellannahmen prüfen ####

### 15.4.1 Diagramme zur Prüfung der Annahmen -----

par(mfrow = c(2,2))
plot(modell.2)


### 15.4.2 Identifizierung von Ausreißern und einflussreichen Werten -----

resid(modell.2) # Residuen
rstandard(modell.2) # Standardisierte Residuen
rstudent(modell.2) # Ausgeschlossene studentisierte Residuen
dfbeta(modell.2) # DfBETA
dfbetas(modell.2) # DfBETAS
dffits(modell.2) # DfFits
cooks.distance(modell.2) # Cook's Distance


### 15.4.3 Kollinearitätsdiagnosen -----

vif(modell.2) # Varianzinflationsfaktor

1/vif(modell.2) # Toleranz


### 15.4.4 Unabhängigkeit der Residuen -----

durbinWatsonTest(modell.2) 
# hier nicht nötig diesen Test durchzuführen, da es sich nicht um längsschnittliche Daten handelt
