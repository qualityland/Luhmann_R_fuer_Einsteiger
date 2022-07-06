##################################################
#### Luhmann - R für Einsteiger - 5. Auflage #####
#### Kapitel 22 - Ausgaben exportieren       #####
##################################################



#### Vorbereitung ####

# Entweder hier aktuelles Arbeitsverzeichnis festlegen (Kap. 5) 
# oder R-Projekt anlegen (Kap. 23) 


# Daten laden ----

load("erstis.RData")



#### Abschnitt 22.1: Daten exportieren ####

# Keine R-Befehle



#### Abschnitt 22.2: Tabellen exportieren ####

# Tabelle erstellen
tabelle <- table(erstis$job, erstis$geschl)

# Exportieren
write.csv2(tabelle, file = "Meine Tabelle.csv")



#### Abschnitt 22.3: Diagramme exportieren ####

pdf("Boxplot.pdf")
boxplot(erstis$lz.1)
dev.off()



#### Abschnitt 22.4: Kommentierte Ausgaben mit R Markdown erstellen ####

# Keine R-Befehle
# Siehe R Markdown-Datei