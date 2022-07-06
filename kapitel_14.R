############################################################
#### Luhmann - R für Einsteiger - 5. Auflage           #####
#### Kapitel 14 - Varianzanalyse mit Messwiederholung  #####
############################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("pruefung.RData")


# Pakete installieren und laden ----

install.packages("psych") # muss nur einmalig durchgeführt werden
install.packages("afex") # muss nur einmalig durchgeführt werden
install.packages("emmeans") # muss nur einmalig durchgeführt werden
install.packages("ggbeeswarm") # muss nur einmalig durchgeführt werden
library(psych)
library(afex)
library(emmeans)
library(ggbeeswarm)



#### Abschnitt 14.1: Datenstruktur ####

head(pruefung)



#### Abschnitt 14.2: Einfaktorielle Varianzanalyse mit Messwiederholung ####

### 14.2.1 Deskriptive Statistiken -----

desk <- describeBy(pruefung$gs, pruefung$mzp, mat = TRUE)

print(desk[,1:6], digits = 2) # Ausgabe der ersten 6 Spalten


### 14.2.2 Durchführung der messwiederholten Varianzanalyse -----

## ANOVA als Objekt anlegen
anova.1 <- aov_car(gs ~ Error(nr/mzp), data = pruefung)

## Ausgabe anzeigen
anova.1 # publikationsfertig

nice(anova.1, correction = "HF") # Ausgabe mit Korrektur nach Huynh-Feldt

summary(anova.1) # umfassende Ausgabe

anova.1$Anova # Ausgabe als multivariate Varianzanalyse


### 14.2.3 Posthoc-Tests und Kontraste -----

## Objekt für Paarvergleiche anlegen
ph.1 <- emmeans(anova.1, specs = "mzp") 
ph.1 <- emmeans(anova.1, specs = ~ mzp)

## Ausgabe anzeigen
ph.1 # zeigt Mittelwerte und Konfidenzintervalle für Mittelwerte

pairs(ph.1) # zeigt Paarvergleiche an


### 14.2.4 Graphische Ergebnisdarstellung -----

afex_plot(anova.1, x = "mzp", error = "within",
             factor_levels = list(
                 mzp = c("Vor der Klausur",
                         "Während der Klausur",
                         "Nach der Klausur")))

plot(ph.1)



#### Abschnitt 14.3: Mehrfaktorielle gemischte Versuchspläne ####

### 14.3.1 Deskriptive Statistiken -----

desk <- describeBy(pruefung$gs, 
                   list(pruefung$mzp, pruefung$sex),
                   mat = TRUE)

print(desk[,1:7], digits = 2)


### 14.3.2 Durchführung der Varianzanalyse -----

## Objekt für Varianzanalyse anlegen
anova.2 <- aov_car(gs ~ sex + Error(nr/mzp),
                   data = pruefung)

## Ausgabe anzeigen
anova.2 # publikationsfertig

nice(anova.2, correction = "HF") # Ausgabe mit Korrektur nach Huynh-Feldt

summary(anova.2) # umfassende Ausgabe


### 14.3.3 Posthoc-Tests und Kontraste -----

## Paarweise Mittelwertsvergleiche für einen Faktor 
ph.2a <- emmeans(anova.2, specs = "mzp")
ph.2a <- emmeans(anova.2, ~ mzp) 

ph.2a # Mittelwerte mit jeweiligen KI anzeigen

pairs(ph.2a) # Paarvergleiche berechnen

## Paarweise Mittelwertsvergleiche für beide Faktoren 
ph.2b <- emmeans(anova.2, ~ mzp * sex) # Objekt für Paarvergleiche anlegen

ph.2b # Mittelwerte mit jeweiligen KI anzeigen

pairs(ph.2b) # Paarvergleiche berechnen

## Bedingte Mittelwertsdifferenzen (unter der Bedingung des Messzeitpunkts)
ph.2c <- emmeans(anova.2, specs = "sex", by = "mzp")
ph.2c <- emmeans(anova.2, ~ sex | mzp) 

ph.2c # Mittelwerte mit jeweiligen KI anzeigen

pairs(ph.2c) # Paarvergleiche berechnen

## Bedingte Mittelwertsdifferenzen (unter der Bedingung des Geschlechts)
ph.2d <- emmeans(anova.2, ~ mzp | sex) # Unterschiede zwischen den MZPs getrennt für die beiden Geschlechter

ph.2d # Mittelwerte mit jeweiligen KI anzeigen

pairs(ph.2d) # Paarvergleiche berechnen


### 14.3.4 Graphische Ergebnisdarstellung -----

afex_plot(anova.2, x = "mzp", trace = "sex",
          error = "between")
