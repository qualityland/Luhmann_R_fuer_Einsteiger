####################################################
#### Luhmann - R für Einsteiger - 5. Auflage   #####
#### Kapitel 17 - Nonparametrische Verfahren   #####
####################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("erstis.RData")

# Pakete installieren und laden ----

install.packages("psych") # muss nur einmalig durchgeführt werden
library(psych)



#### Abschnitt 17.1: Der Chi-Quadrat-Test ####

### 17.1.1 Der Chi-Quadrat-Anpassungstest -----

## Häufigkeitstabelle als Objekt speichern
tab.1 <- table(erstis$geschl)

## Häufigkeiten anzeigen lassen
tab.1
prop.table(tab.1)

## Chi-Quadrat-Test auf Häufigkeitstabelle anwenden
chisq.test(tab.1)

chisq.test(tab.1, p = c (.7, .3))


### 17.1.2 Der Chi-Quadrat-Test für zwei Variablen -----

## Häufigkeitstabelle als Objekt speichern
tab.2 <- table(erstis$geschl, erstis$gruppe)

## Häufigkeiten mit Randsummen anzeigen lassen
addmargins(tab.2)

## Chi-Quadrat-Test auf Häufigkeitstabelle anwenden
chisq.test(tab.2)

## Residuen und erwartete Werte anzeigen
chisq.test(tab.2)$expected
chisq.test(tab.2)$residuals

chisq.test(tab.2)$observed - chisq.test(tab.2)$expected

## Beispiel für einen 2x2-Chi-Quadrat-Test (mit/ohne Korrektur)
chisq.test(table(erstis$geschl, erstis$berlin))

chisq.test(table(erstis$geschl, erstis$berlin), correct = F)



#### Abschnitt 17.2: Der Wilcoxon-Test ####

### 17.2.1 Eine Stichprobe -----

describe(erstis$stim1)

wilcox.test(erstis$stim1, mu = 3.0)


### 17.2.2 Zwei unabhängige Stichproben -----

describeBy(erstis$stim1, erstis$geschl, mat = TRUE)

wilcox.test(stim1 ~ geschl, data = erstis)


### 17.2.3 Zwei abhängige Stichproben -----

describe(na.omit(data.frame(erstis$stim1, erstis$stim8)))

wilcox.test(erstis$stim1, erstis$stim8, paired = TRUE)

help(wilcox.test)



#### Abschnitt 17.3: Der Kruskal-Wallis-Test ####

describeBy(erstis$stim1, erstis$gruppe, mat = TRUE)

kruskal.test(stim1 ~ gruppe, data = erstis)
