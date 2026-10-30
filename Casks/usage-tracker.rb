cask "usage-tracker" do
  version "0.2.2"
  sha256 "ed6fd743b8042619647699b4188d4803b130575cb2e77120f633261a6ce73bd0"

  url "https://github.com/KemelMoh/usage-tracker/releases/download/v0.2.2/UsageTracker-0.2.2.dmg"
  name "Usage Tracker"
  desc "Menu bar usage tracker for OpenCode Go, GitHub Copilot and Claude"
  homepage "https://github.com/KemelMoh/usage-tracker"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Usage Tracker.app"

  caveats <<~EOS
    Usage Tracker está firmada en modo ad-hoc y no está notarizada por Apple.
    Si macOS la bloquea al abrirla, ejecuta:

      xattr -dr com.apple.quarantine "#{appdir}/Usage Tracker.app"

    o abre la app con clic derecho > Abrir.
  EOS
end
