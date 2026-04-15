# IMPORTANT: `npm run postpublish` to update this file after publishing a new version of the package
class Dirac < Formula
  desc "Autonomous coding agent CLI - capable of creating/editing files, running commands, and more"
  homepage "https://dirac.run"
  url "https://registry.npmjs.org/dirac-cli/-/dirac-cli-0.2.34.tgz" # GET from https://registry.npmjs.org/dirac-cli/latest tarball URL
  sha256 "aedbb165d1f91f57e42a2a29c9dd8372f3f9a54e5d54076eae3ce44b46edc3fb"
  license :cannot_represent

  depends_on "node@20"
  depends_on "ripgrep"

  def install
    system "npm", "install", *std_npm_args(prefix: false)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # Test that the binary exists and is executable
    assert_match version.to_s, shell_output("#{bin}/dirac --version")
  end
end
