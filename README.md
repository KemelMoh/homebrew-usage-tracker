# Usage Tracker · Homebrew Tap

Instala [Usage Tracker](https://github.com/KemelMoh/usage-tracker) con Homebrew:

```bash
brew tap KemelMoh/usage-tracker
brew trust --cask KemelMoh/usage-tracker/usage-tracker
brew install --cask usage-tracker
```

Homebrew 7 exige confiar explícitamente en taps de terceros y ya **no** ofrece `--no-quarantine`.

## Gatekeeper

La app está firmada en modo ad-hoc y no está notarizada por Apple. Si macOS muestra el aviso de desarrollador no verificado, ejecuta:

```bash
xattr -dr com.apple.quarantine "/Applications/Usage Tracker.app"
open "/Applications/Usage Tracker.app"
```

También puedes abrirla con clic derecho → **Abrir**.

## Actualizar

```bash
brew update
brew upgrade --cask usage-tracker
```

El cask se actualiza solo: cada vez que se publica una release en el
[repositorio principal](https://github.com/KemelMoh/usage-tracker), un workflow
de este tap abre un pull request con la versión y el checksum nuevos. El PR se
revisa y se mezcla.

## Desinstalar

```bash
brew uninstall --cask usage-tracker
```

## Requisitos

- macOS 13 o superior.
- Apple Silicon. La release actual es arm64.
