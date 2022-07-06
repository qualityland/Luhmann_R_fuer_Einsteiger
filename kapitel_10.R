####################################################
#### Luhmann - R für Einsteiger - 5. Auflage   #####
#### Kapitel 10 - Datenvisualisierung          #####
####################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("erstis.RData")
load("vpn.RData")

# Pakete installieren und laden ----

install.packages("tidyverse") # muss nur einmalig durchgeführt werden
install.packages("psych") # muss nur einmalig durchgeführt werden
install.packages("ggplot2") # muss nur einmalig durchgeführt werden
install.packages("patchwork") # muss nur einmalig durchgeführt werden
library(tidyverse)
library(psych)
library(ggplot2)
library(patchwork)


#### Abschnitt 10.1: Einführung in die klassischen Graphik-Funktionen ####

### 10.1.1	Wie wird die Art des Diagramms festgelegt? -----

## Beispiele zur Tabelle 10.1 der "plot"-Funktion
plot(erstis$extra) # Index-Diagramm
plot(erstis$berlin) # Säulendiagramm
plot(erstis$extra, erstis$gewiss) # Streudiagramm
plot(erstis$berlin, erstis$gewiss) # Boxplots
plot(erstis$berlin, erstis$geschl) # Mosaik-Diagramm
plot(data.frame(erstis$gewiss, erstis$extra, erstis$neuro)) # Streudiagramm-Matrix

## Arten von Streudiagrammen
plot(vpn$tag, vpn$n, type = "l")
plot(vpn$tag, vpn$n, type = "b")
plot(vpn$tag, vpn$n, type = "s")
plot(vpn$tag, vpn$n, type = "h")


### 10.1.2	Wie verändert man das Aussehen des Diagramms? -----

## Hilfe bei der Anpassung von Diagrammen
help(par)

## Form und Größe der Datenpunkte
plot(vpn$tag, vpn$n,
     type = "b", 
     pch = 17, # passt die Form der Punkte an
     cex = 3) # passt die Größe der Punkte an

## Typ und Stärke von Linien
plot(vpn$tag, vpn$n,
     type = "b",
     lty = 3, # passt den typ der Linie an
     lwd = 2) # passt die Stärke der Linien an

## Farben
plot(vpn$tag, vpn$n,
     type = "b",
     col = 2) # passt die Farbe der Linien und Punkte an

plot(vpn$tag, vpn$n,
     type = "l",
     col = 2) # passt die Farbe der Linien an
points(vpn$tag, vpn$n,col = 1) # ergänzt Punkte in einer anderen Farbe in das Diagramm

## Darstellung der Daten in Abhängigkeit von weiteren Variablen
plot(vpn$tag, vpn$n,
     type = "b",
     pch = as.numeric(vpn$werbung)) # Anpassung der Datenpunkte in Abhängigkeit von der Ausprägung auf der Variablen "Werbung"

## Achsenskalierung und Achsenbeschriftung
plot(vpn$tag, vpn$n,
     type = "b",
     xlim = c(.8, 5.2), ylim = c(0, 100), # Wertebereich für x- und y-Achse
     las = 1, # Ausrichtung der Achsenbeschriftungen
     xlab = "Tag", # Bezeichnung für x-Achse
     ylab = "Anzahl Versuchspersonen") # Bezeichnung für y-Achse

plot(vpn$tag, vpn$n,
     type = "b",
     cex.axis = 2, # Größe der Achsenbeschriftung
     font.axis = 3, # Schriftschnitt der Achsen
     col.axis = 2) # Farbe der Achsen


### 10.1.3	Wie fügt man Elemente zu dem Diagramm hinzu? -----

## Legende hinzufügen
plot(vpn$tag, vpn$n,
     type = "b",
     pch = as.numeric(vpn$werbung))

levels(vpn$werbung)

table(vpn$werbung, as.numeric(vpn$werbung)) # Prüfen, wie die Variable "Werbung" kodiert wurde

legend("topleft", # Position der Legende
       c("Keine Werbung", "Werbung"), # Bezeichnung der Gruppen
       pch = c(1,2)) # Graphische Darstellung der Gruppen

## Beispiele für weitere Graphik-Elemente
plot(vpn$tag, vpn$n,
     type = "b",
     pch = as.numeric(vpn$werbung))

title("Mein Diagramm") # fügt einen Diagrammtitel hinzu

abline(a = 20, b = 1) # zeichnet eine Gerade ins Diagramm


### 10.1.4	Wie kann ich mehrere Diagramme anordnen? -----

par(mfrow = c(1, 1)) # stellt ein Diagramm alleine dar

par(mfrow = c(2, 2)) # stellt Diagramme in zwei Zeilen und zwei Spalten dar



#### Abschnitt 10.2: Einführung in ggplot2 ####

### 10.2.1	Wie wird die Art des Diagramms festgelegt? -----

ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point()

ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point() +
  geom_line() # Kombination von Linien und Punkten

## Einige weitere Beispiele aus Tabelle 10.5
ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 30) # zeichnet Gerade ins Diagramm

ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point() + 
  geom_smooth() # mit Anpassungskurve


### 10.2.2	Wie verändert man das Aussehen des Diagramms? -----
  
## Form und größe der Datenpunkte
ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point(shape = 17, size = 3) +
  geom_line()

## Typ und Stärke der Linien
ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point() +
  geom_line(linetype = 3, size = 2)

## Farben
ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point(col = "red") +
  geom_line(col = "blue")

## Darstellung der Daten in Abhängigkeit von weiteren Variablen
ggplot(data = vpn, aes(x = tag, y = n, shape = werbung)) +
  geom_point(size = 3)

ggplot(data = vpn, aes(x = tag, y = n, col = werbung, 
                       shape = werbung)) +
  geom_point(size = 3) +
  scale_shape_manual(values = c(16, 18)) + # Form der Objekte selbst bestimmen
  scale_color_manual(values = c("red", "blue")) # Farbe selbst bestimmen

## Achsenskalierung und Achsenbeschriftung
ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point() +
  geom_line() +
  scale_x_continuous(limits = c(.8, 5.2), name = "Tag") +
  scale_y_continuous(limits = c(0,100), 
                     name = "Anzahl Versuchspersonen")

## Themen
ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point() +
  geom_line() +
  theme_bw()

# Beispiel für ein eigenes Thema
help(theme)

ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point() +
  geom_line() +
  theme(plot.background = element_rect(fill = "gray"),
        axis.line = element_line(size = 3, colour = "grey80"), 
        panel.grid.major = element_line(colour = "grey50"))


### 10.2.3	Wie fügt man Elemente zu dem Diagramm hinzu? -----

## Beispiel: Hinzufügen eines Titels
ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point() +
  geom_line() +
  theme_bw() +
  ggtitle("Mein Diagramm", subtitle = "mit ggplot")


### 10.2.4	Wie kann man mehrere Diagramme anordnen? -----

# Diagramme
p1 <- ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_point()
p2 <- ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_line()
p3 <- ggplot(data = vpn, aes(x = tag, y = n)) +
  geom_area()

# Diagramme zusammen darstellen 
p1 / p2 / p3 # Diagramme untereinander
(p1 + p2) / p3 # ersten beiden Diagramme in einer Zeile



#### Abschnitt 10.3: Ausgewählte Diagramme ####

### 10.3.1 Säulendiagramme für Häufigkeiten -----

## Einfaches Säulendiagramm mit barplot-Funktion
barplot(erstis$wohnort.alt) # funktioniert nicht mit Ausgangsvariable

tab <- table(erstis$wohnort.alt) # Tabelle als Objekt anlegen

barplot(tab)

barplot(tab, ylim = c(0,100), ylab = "Häufigkeit",
        col = 1, las = 1)

barplot(tab, xlab = "Häufigkeit",
        col = 1, las = 1, horiz = T) # Diagramm als horizontale Balken darstellen

## Gestapelte und gruppierte Säulendiagramme mit der barplot-Funktion
tab2 <- table(erstis$geschl, erstis$wohnort.alt) # Kontingenztabelle erstellen

barplot(tab2, legend = TRUE) # Säulen über einander

barplot(tab2, legend = TRUE, beside = TRUE) # Säulen neben einander

## Einfaches Säulendiagramm mit ggplot2
ggplot(erstis, aes(x = wohnort.alt)) +
  geom_bar()

erstis %>% 
  filter(!is.na(wohnort.alt)) %>% 
  ggplot(aes(x = wohnort.alt)) + 
    geom_bar()

## Gestapelte und gruppierte Säulendiagramme mit ggplot2
ggplot(erstis, aes(x = wohnort.alt, fill = geschl)) +
  geom_bar()

erstis %>%
  filter(!is.na(wohnort.alt) & !is.na(geschl)) %>% 
  ggplot(aes(x = wohnort.alt, fill = geschl)) +
    geom_bar(position = "dodge") # Säulen neben einander darstellen


### 10.3.2 Histogramme und Kerndichte-Diagramme -----

## Histogramm und Kerndichte-Diagramm mit klassischen R-Funktionen
hist(erstis$alter)

hist(erstis$alter, 
     breaks = 15, # Anzahl der Säulen anpassen
     col = 4, # Farbe anpassen
     ylab = "Häufigkeiten", # Bezeichnung der y-Achse
     xlab = "Alter", # Bezeichnung der x-Achse
     xlim = c(10, 60), # Wertebereich der x-Achse anpassen
     main = "Mein Histogramm") # Bearbeiten des Diagrammtitels#

plot(density(erstis$alter, na.rm = TRUE))

plot(density(erstis$alter, na.rm = TRUE), 
     lty = 3, # Linientyp anpassen
     lwd = 2, # Linienstärke anpassen
     col = 2, # Farbe anpassen
     ylab = "Dichte", # Bezeichnung der y-Achse
     xlab = "Alter", # Bezeichnung der x-Achse
     xlim = c(10, 60), # Wertebereich der x-Achse anpassen
     main = "Meine Kerndichtekurve")

hist(erstis$alter, freq = FALSE,
     ylim = c(0, .1), col = 8,
     main = "Alter", xlab = "")
lines(density(erstis$alter, na.rm = TRUE),
      lwd = 2)

## Histogramm und Kerndichte-Diagramm mit ggplot2
ggplot(erstis, aes(x = alter)) +
  geom_histogram()

ggplot(erstis, aes(x = alter)) +
  geom_histogram(binwidth = 3) 

ggplot(erstis, aes(x = alter)) +
  geom_density()

ggplot(erstis, aes(x = alter)) +
  geom_line(stat = "density")

ggplot(erstis, aes(x = alter, y = ..density..)) + # Kombination in einem Diagramm
  geom_histogram(binwidth = 3, col = "grey80",
                 fill = "grey50") +
  geom_line(stat = "density", size = 1.5) +
  ylab("Dichte")

## Gruppierte Histogramme und Kerndichtekurve
erstis %>%
  filter(!is.na(geschl)) %>% # Missings entfernen
  ggplot(aes(x = alter, fill = geschl)) +
  geom_density(alpha = .5, col = NA)

erstis %>%
  filter(!is.na(geschl)) %>% # Missings entfernen
  ggplot(aes(x = alter, fill = geschl)) +
  geom_density(alpha = .5, col = NA) +
  scale_fill_manual(values = c("orange", "black")) # Farben manuell anpassen

erstis %>%
  filter(!is.na(geschl)) %>% # Missings entfernen
  ggplot(aes(x = alter, y = ..density..)) +
  geom_histogram(binwidth = 5, fill = "white",
                 col = "grey") +
  geom_line(stat = "density", size = 1) +
  facet_grid(geschl ~ .) # ordnet Panels untereinander an


### 10.3.3 Boxplots -----

## Boxplots mit der boxplot-Funktion
boxplot(erstis$alter)

boxplot(erstis$alter ~ erstis$geschl, 
        xlab = "", ylab = "Alter")

## Boxplots mit ggplot2
ggplot(erstis, aes(y = alter)) +
  geom_boxplot()

erstis %>%
  filter(!is.na(geschl)) %>% # Missing für das Geschlecht entfernen
  ggplot(aes(y = alter, x = geschl)) + # Getrennte Boxplots für die Geschlechter darstellen
  geom_boxplot(notch = TRUE) + # Darstellung mit Kerben
  xlab("") + ylab("Alter")


### 10.3.4 Mittelwerts-Diagramme -----

## Beispiel für manuelles Erzeugen von Fehlerbalken
alter.geschl <-describeBy(erstis$alter, erstis$geschl, mat = T)$group1
alter.mean <- describeBy(erstis$alter, erstis$geschl, mat = T)$mean
alter.se <- describeBy(erstis$alter, erstis$geschl, mat = T)$se

alter <- as.data.frame(cbind(as.character(alter.geschl), # Erstellen eines neuen Objekts
                             as.numeric(alter.mean), 
                             as.numeric(alter.se)))

ggplot(alter, aes(y = alter.mean, x =  alter.geschl)) +
  geom_point() + # Darstellung der Mittelwerte 
  geom_errorbar(aes (ymin = alter.mean - alter.se, ymax = alter.mean + alter.se), width = 0.2) + # Standardfehler hinzufügen
  scale_x_discrete(name = "") + # x-Achse anpassen
  scale_y_continuous(limits = c(20,30), name = "Alter") # y-Achse anpassen
  


### 10.3.5 Einfaches Streudiagramm -----

## Streudiagramme mit der plot-Funktion
plot(erstis$neuro, erstis$lz.1)

plot(erstis$lz.1 ~ erstis$neuro)

lm(lz.1 ~ neuro, data = erstis)

abline(lm(lz.1 ~ neuro, data = erstis), lty = 2) # Einfügen einer Regressionsgerade

auswahl <- na.omit(select(erstis, lz.1, neuro)) # Fälle mit fehlenden Werten entfernen

lines(lowess(auswahl$lz.1 ~ auswahl$neuro)) # Einfügen einer Lowess-Anpassungslinie

## Streudiagramme mit ggplot2
ggplot(erstis, aes(x = neuro, y = lz.1)) +
  geom_point()

ggplot(erstis, aes(x = neuro, y = lz.1)) +
  geom_point() +
  stat_smooth(method = lm, linetype = 2) + # mit Regressionsgerade
  stat_smooth(method = loess) # mit Lowess-Kurve

ggplot(erstis, aes(x = neuro, y = lz.1)) + # Darstellung ohne Datenpunkte
  geom_smooth(method = lm, linetype = 2) + # mit Regressionsgerade
  stat_smooth(method = loess) # mit Lowess-Kurve


### 10.3.6 Streudiagramm-Matrix -----

pers <- erstis %>% select(extra, neuro, gewiss)

pairs.panels(pers)