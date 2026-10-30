#!/bin/bash
set -euo pipefail

# Actualiza el cask a una version nueva.
#
#   ./scripts/update-cask.sh 0.2.3
#
# Reescribe la version, el checksum y la URL del cask. Se hace a mano en vez
# de con `brew bump-cask-pr` porque en Homebrew 7 ese comando falla al
# tapear `homebrew/cask`, que ya no se puede tapear sin --force.
#
# La URL lleva la version escrita y no interpolada con `#{version}` porque
# `brew bump-cask-pr` necesita encontrar el texto literal de la version
# dentro de la URL para poder sustituirlo.

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CASK="$ROOT/Casks/usage-tracker.rb"

VERSION="${1:-}"
if [[ -z "$VERSION" ]]; then
    echo "Uso: $0 <version-sin-v>" >&2
    exit 1
fi

URL="https://github.com/KemelMoh/usage-tracker/releases/download/v${VERSION}/UsageTracker-${VERSION}.dmg"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "→ Descargando $URL"
if ! curl -fsSL --retry 3 -o "$TMP/app.dmg" "$URL"; then
    echo "No se pudo descargar el DMG de la $VERSION." >&2
    exit 1
fi

SHA="$(shasum -a 256 "$TMP/app.dmg" | awk '{print $1}')"
echo "→ SHA-256: $SHA"

# Se comprueba que el DMG es una imagen de disco valida antes de tocar el
# cask, para no dejar un checksum de un archivo corrupto.
if ! hdiutil imageinfo "$TMP/app.dmg" >/dev/null 2>&1; then
    echo "El archivo descargado no es una imagen de disco valida." >&2
    exit 1
fi

python3 - "$CASK" "$VERSION" "$SHA" "$URL" <<'PY'
import re
import sys

path, version, sha, url = sys.argv[1:5]
with open(path) as handle:
    contents = handle.read()

contents = re.sub(r'version "[^"]+"', f'version "{version}"', contents, count=1)
contents = re.sub(r'sha256 "[^"]+"', f'sha256 "{sha}"', contents, count=1)
contents = re.sub(r'url "[^"]+"', f'url "{url}"', contents, count=1)

with open(path, "w") as handle:
    handle.write(contents)
PY

echo "→ Cask actualizado a $VERSION"
