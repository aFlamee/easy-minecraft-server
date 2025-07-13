#!/usr/bin/env bash
# whitelist.sh – Verwalte die Minecraft-Whitelist im laufenden Docker-Container
#
# Usage-Beispiele:
#   ./whitelist.sh add Spieler
#   ./whitelist.sh remove Spieler
#   ./whitelist.sh list
#   ./whitelist.sh reload
#   ./whitelist.sh --help

# Funktion zur Anzeige der Hilfe
print_help() {
  cat <<EOF
Verfügbare Befehle:
  add <Spieler_name>      – Spieler zur Whitelist hinzufügen
  remove <Spieler_name>   – Spieler von der Whitelist entfernen (wird sofort gekickt, falls online)
  list               – Aktuelle Whitelist anzeigen
  reload             – Whitelist aus Datei neu laden
  help | -h | --help – Diese Hilfe anzeigen
EOF
}

# Hilfe anzeigen, falls gewünscht oder keine Argumente vorhanden
if [[ -z "$1" || "$1" == "help" || "$1" == "-h" || "$1" == "--help" ]]; then
  print_help
  exit 0
fi

CMD="$1"
shift # Restliche Parameter

# Whitelist-Befehl ausführen
# shellcheck disable=SC2068 # Wir wollen bewusst word-splitting
docker compose exec mc rcon-cli whitelist "$CMD" $@

# Falls Spieler entfernt wurde → sofort kicken
if [[ "$CMD" == "remove" && -n "$1" ]]; then
  docker compose exec mc rcon-cli "kick $1 Du bist nicht mehr auf der Whitelist"
fi
