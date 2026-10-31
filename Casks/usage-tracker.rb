cask "usage-tracker" do
  version "0.3.2"
  sha256 "30a5fb590f7f9764aa2a1baba512c6115ddd4778ad8ad7be0efe5a0d8f1ddab0"

  url "https://github.com/KemelMoh/usage-tracker/releases/download/v0.3.2/UsageTracker-0.3.2.dmg"
  name "Usage Tracker"
  desc "Menu bar usage tracker for OpenCode Go, GitHub Copilot and Claude"
  homepage "https://github.com/KemelMoh/usage-tracker"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Usage Tracker.app"

  # Older install receipts may not contain the `uninstall quit` stanza.
  # Stop those running processes before Homebrew opens the new app bundle.
  preflight_steps do
    run "/usr/bin/osascript",
        args:         [
          "-l",
          "JavaScript",
          "-e",
          <<~JAVASCRIPT,
            ObjC.import("AppKit");
            ObjC.import("Foundation");

            function matchingApps(bundleID) {
              var running = $.NSWorkspace.sharedWorkspace.runningApplications;
              var matches = [];

              for (var index = 0; index < running.count; index++) {
                var app = running.objectAtIndex(index);
                if (!app.bundleIdentifier.isNil() && ObjC.unwrap(app.bundleIdentifier) === bundleID) {
                  matches.push(app);
                }
              }

              return matches;
            }

            function run(argv) {
              matchingApps(argv[0]).forEach(function (app) { app.terminate(); });

              var deadline = Date.now() + 10000;
              while (Date.now() < deadline) {
                if (matchingApps(argv[0]).length === 0) return;
                $.NSThread.sleepForTimeInterval(0.1);
              }

              $.exit(1);
            }
          JAVASCRIPT
          "dev.kemel.usagetracker",
        ],
        must_succeed: true,
        print_stderr: false
  end

  postflight_steps do
    run "/usr/bin/open",
        args:         ["-a", "{{appdir}}/Usage Tracker.app"],
        must_succeed: false
  end

  uninstall quit: "dev.kemel.usagetracker"

  caveats <<~EOS
    Usage Tracker está firmada en modo ad-hoc y no está notarizada por Apple.
    Si macOS la bloquea al abrirla, ejecuta:

      xattr -dr com.apple.quarantine "#{appdir}/Usage Tracker.app"

    o abre la app con clic derecho > Abrir.
  EOS
end
