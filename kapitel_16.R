#######################################################
#### Luhmann - R für Einsteiger - 5. Auflage      #####
#### Kapitel 16 - Spezielle Regressionsmodelle    #####
#######################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("haustier.RData")
load("Samstag.RData")

# Pakete installieren und laden ----

install.packages("tidyverse") # muss nur einmalig durchgeführt werden
install.packages("car") # muss nur einmalig durchgeführt werden
install.packages("ggplot2") # muss nur einmalig durchgeführt werden
install.packages("emmeans") # muss nur einmalig durchgeführt werden
install.packages("interactions") # muss nur einmalig durchgeführt werden
library(tidyverse)
library(car)
library(ggplot2)
library(emmeans)
library(interactions)



#### Abschnitt 16.1: Kategoriale Prädiktoren ####

### 16.1.1 Kodierung von kategorialen Prädiktoren -----

## Aktuelle Kodierung anzeigen
contrasts(haustier$tierart)

## Referenzkategorie ändern
haustier$tierart.r <- relevel(haustier$tierart, "Pferd")
contrasts(haustier$tierart.r)

## Effektkodierung erstellen 
# Hier auf "tierart.r" angewandt, damit wir wie im Kapitel mit ursprünglicher Kodierung weiterrechnen können
contr.sum(3)

contrasts(haustier$tierart.r) <- contr.sum(3)

contrasts(haustier$tierart.r)


### 16.1.2 Durchführung der Regression mit kategorialen Prädiktoren -----

## Objekt für Regression anlegen
reg.kat <- lm(wohlbefinden ~ tierart, data = haustier)

## Ausgabe anfordern
summary(reg.kat)



#### Abschnitt 16.2: Kovarianzanalyse ####

### 16.2.1 Zentrierung der Kovariaten -----

haustier$geld.c <- scale(haustier$geld, scale = FALSE)


### 16.2.2 Durchführung der Kovarianzanalyse -----

## Objekt für Regression anlegen
kov <- lm(wohlbefinden ~ tierart + geld.c, data = haustier)

## Ausgabe anfordern
summary(kov)


### 16.2.3 Adjustierte Mittelwerte -----

## Ausgabe anzeigen
emmeans(kov, specs = "tierart")

## Speichern als Objekt
kov.m <- emmeans(kov, ~ tierart)

## Paarvergleiche
pairs(kov.m)

## Graphische Darstellung
plot(kov.m)



#### Abschnitt 16.3: Moderierte Regression ####

### 16.3.1 Zentrierung der Prädiktoren -----

haustier$geld.c <- as.numeric(scale(haustier$geld,
                                     scale = FALSE))
haustier$neuro.c <- as.numeric(scale(haustier$neuro,
                                      scale = FALSE))


### 16.3.2 Durchführung der moderierten Regressionsanalyse -----

## Interaktion zwischen einem kategorialen und einem metrischen Prädiktor

# Regression als Objekt speichern
mod.reg.1 <- lm(wohlbefinden ~ tierart * geld.c,
                data = haustier)

# Ausgaben anfordern
Anova(mod.reg.1)
round(summary(mod.reg.1)$coef, 3)

## Interaktion zwischen zwei metrischen Prädiktoren

# Regression als Objekt speichern
mod.reg.2 <- lm(wohlbefinden ~ geld.c * neuro.c,
                data = haustier)

# Ausgaben anfordern
Anova(mod.reg.2)
summary(mod.reg.2)


### 16.3.3 Bedingte Regressionsgleichungen und Interaktionsdiagramm -----

## Bedingte Regressionskoeffizienten für eine kategoriale Moderatorvariable

# Bedingte Regressionskoeffizienten als Objekt speichern
mod.em.1 <- emtrends(mod.reg.1, var = "geld.c",
                     specs = "tierart")

# Ausgabe anfordern
mod.em.1

# Prüfen, ob sich bedingte Regressionskoeffizienten signifikant von einander unterscheiden
pairs(mod.em.1)

# Graphische Darstellung
plot(mod.em.1)

interact_plot(mod.reg.1, pred = geld.c, modx = tierart)

interact_plot(mod.reg.1, pred = geld.c, modx = tierart,
              plot.points = TRUE, point.shape = TRUE, 
              interval = TRUE)

## Bedingte Regressionskoeffizienten für eine metrische Moderatorvariable

# SD der Moderatorvariable bestimmen
describe(haustier$neuro.c)

# Bedingte Regressionskoeffizienten als Objekt speichern
mod.em.2 <- emtrends(mod.reg.2, var = "geld.c",
                     specs = "neuro.c",
                     at = list(neuro.c = c(-1.15, 1.15)))

# Ausgabe anfordern
mod.em.2

# Graphische Darstellung
interact_plot(mod.reg.2, pred = geld.c, modx = neuro.c)

interact_plot(mod.reg.2, pred = geld.c, modx = neuro.c,
              modx.values = "plus-minus", interval = TRUE,
              plot.points = TRUE)

# Johnson-Neyman-Intervall
johnson_neyman(mod.reg.2, pred = geld.c, modx = neuro.c,
               alpha = .05, sig.color = "black",
               insig.color = "grey")



#### Abschnitt 16.4: Nicht-lineare Regression ####

### 16.4.1 Graphische Darstellung -----

## Graphik mit Loess-Anpassungslinie
ggplot(haustier, aes(x = geld, y = wohlbefinden)) +
  geom_point() +
  stat_smooth(method = "loess")

## Graphik mit quadratischem und kubischem Zusammenhang
ggplot(haustier, aes(x = geld, y = wohlbefinden)) +
  geom_point() +
  stat_smooth(method = "lm", formula = y ~ x + I(x^2),
              linetype = 2) +
  stat_smooth(method = "lm", formula = y ~ x + I(x^2)
              + I(x^3))


### 16.4.2 Durchführung der nicht-linearen Regression -----

## Regression als Objekt anlegen
quadr <- lm(wohlbefinden ~ geld.c + I(geld.c^2),
            data = haustier)
kub <- lm(wohlbefinden ~ geld.c + I(geld.c^2) + I(geld.c^3),
          data = haustier)

## Ausgaben anfordern
summary(quadr)
summary(kub)



#### Abschnitt 16.5: Logistische Regression ####

### 16.5.1 Durchführung der logistischen Regression -----

## Regression als Objekt anlegen
log.reg <- glm(ausgehen ~ extra + gestern,
               family = binomial, data = samstag)

## Ausgabe anfordern
summary(log.reg)


### 16.5.2 Berechnung der Odds Ratios -----

coef(log.reg) # Koeffizienten angeben

exp(coef(log.reg)) # Odds Ratio angeben


### 16.5.3 Modellvergleiche mit dem Likelihood-Ratio-Test -----

## Für alle Prädiktoren mit der Anova-Funktion
Anova(log.reg)

## Per Hand
log.reg.1 <- glm(ausgehen ~ extra,
                 family = binomial, data = samstag)
log.reg.2 <- glm(ausgehen ~ extra + gestern,
                 family = binomial, data = samstag)

anova(log.reg.1, log.reg.2, test = "Chisq")
