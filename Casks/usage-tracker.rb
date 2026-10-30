cask "usage-tracker" do
  version "0.2.4"
  sha256 "60f5b9eb9aca52b0fb9ddc0efd8e650a371de0ef12349b3f092b94275aad9304"

  url "https://github.com/KemelMoh/usage-tracker/releases/download/v0.2.4/UsageTracker-0.2.4.dmg"
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
