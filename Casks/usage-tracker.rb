cask "usage-tracker" do
  version "0.2.3"
  sha256 "4404c41ef8e98a6cf8c0bf45a62d53a70a0adcf719cad2b5dd70ed5867700385"

  url "https://github.com/KemelMoh/usage-tracker/releases/download/v0.2.3/UsageTracker-0.2.3.dmg"
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
