FROM atlassian/confluence-server:8.5.5

ARG APP_VERSION=8.5.16

# Aktualisieren und notwendige Tools installieren
RUN apt update && \
    apt upgrade -y && \
    apt install -y curl nano wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Temporäres Verzeichnis wechseln und ZIP-Datei herunterladen
WORKDIR /tmp
RUN wget https://product-downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-${APP_VERSION}.zip

# Entfernen der alten Confluence-Version und Entpacken des neuen Inhalts direkt in das Zielverzeichnis
RUN rm -rf /opt/atlassian/confluence/* && \
    unzip atlassian-confluence-${APP_VERSION}.zip -d /tmp/confluence-extracted && \
    mv /tmp/confluence-extracted/atlassian-confluence-${APP_VERSION}/* /opt/atlassian/confluence/ && \
    rm -rf atlassian-confluence-${APP_VERSION}.zip /tmp/confluence-extracted

# Setzen der Berechtigungen für alle notwendigen Verzeichnisse und Dateien
RUN chown -R confluence:root /opt/atlassian/confluence && \
    chmod -R 755 /opt/atlassian/confluence && \
    find /opt/atlassian/confluence/bin/ -name "*.sh" -exec chmod +x {} \; && \
    rm -rf /tmp/*

# Setze das Arbeitsverzeichnis auf das Standard-Datenverzeichnis
WORKDIR /var/atlassian/application-data/confluence
