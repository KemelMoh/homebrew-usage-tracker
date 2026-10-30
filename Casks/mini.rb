cask "mini" do
  version "1.0.0"
  sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

  url "https://example.com/mini-#{version}.dmg"
  name "Mini"
  desc "Mini"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Mini.app"
end
