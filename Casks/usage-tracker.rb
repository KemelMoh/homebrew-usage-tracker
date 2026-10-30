cask "usage-tracker" do
  version "0.3.0"
  sha256 "15c55dc317aa5e508a0635061126073aa478821e7f1a77088238d5f775bc6663"

  url "https://github.com/KemelMoh/usage-tracker/releases/download/v0.3.0/UsageTracker-0.3.0.dmg"
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
