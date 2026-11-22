# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/locksmith-darwin-arm64"
      sha256 "a609a3439d778c85ea4381175b3e9344e021e2d85608b3d22a538d724938743a"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/summon-locksmith-darwin-arm64"
        sha256 "2db976994146d14e4ea1d8207ece491bca278fb0d8e130375203d65981e49850"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/git-credential-locksmith-darwin-arm64"
        sha256 "6daccccd8c36541c6a48b296dc606860446d6ce78ce81342288e47599abebb89"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/locksmith-cockpit-darwin-arm64"
        sha256 "4474960c41d1b2422353ef388d703938ddf26d8bb84b1912e5ecde547ba1d100"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        resource("summon-arm64").stage do
          bin.install "summon-locksmith-darwin-arm64" => "summon-locksmith"
        end
        resource("git-credential-arm64").stage do
          bin.install "git-credential-locksmith-darwin-arm64" => "git-credential-locksmith"
        end
        resource("cockpit-arm64").stage do
          bin.install "locksmith-cockpit-darwin-arm64" => "locksmith-cockpit"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/locksmith-darwin-amd64"
      sha256 "e72a71a7f06ca5392328c50206a4b56872d5df94d83e80db2211250a05a642c1"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/summon-locksmith-darwin-amd64"
        sha256 "60b1130d54225c460dd544674c8a21ee57f7c131cfa576b49d3b73a1532eaeea"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/git-credential-locksmith-darwin-amd64"
        sha256 "dd512c4d01423006a88dde8e22c63fb85e9fe2782b94f3121b8c266d1425c801"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/locksmith-cockpit-darwin-amd64"
        sha256 "8574d86b9c9276d0133348a4d486f36122e8486e373d53fbf2c3ccea555a52da"
      end

      def install
        bin.install "locksmith-darwin-amd64" => "locksmith"
        resource("summon-amd64").stage do
          bin.install "summon-locksmith-darwin-amd64" => "summon-locksmith"
        end
        resource("git-credential-amd64").stage do
          bin.install "git-credential-locksmith-darwin-amd64" => "git-credential-locksmith"
        end
        resource("cockpit-amd64").stage do
          bin.install "locksmith-cockpit-darwin-amd64" => "locksmith-cockpit"
        end
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/locksmith-linux-arm64"
      sha256 "e65f9e7ce3d94f5853486e5f87cfaaf41dfa2a4dbb8ab99f5c9a91b3be427708"

      resource "git-credential-linux-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/git-credential-locksmith-linux-arm64"
        sha256 "6ddc3bc4d1f01833011a3adeebbbe061af08bd1add706f2cae74d8667e9772cb"
      end

      def install
        bin.install "locksmith-linux-arm64" => "locksmith"
        resource("git-credential-linux-arm64").stage do
          bin.install "git-credential-locksmith-linux-arm64" => "git-credential-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/locksmith-linux-amd64"
      sha256 "6e7b1d9c7a42efc1ab9ab0fcb8bfdd7612e302400c4a4bf2e51c406a1487b406"

      resource "git-credential-linux-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.0/git-credential-locksmith-linux-amd64"
        sha256 "645a035213858c9dd2097a2b49ecbb18165a2683757f7f9da01293b366426311"
      end

      def install
        bin.install "locksmith-linux-amd64" => "locksmith"
        resource("git-credential-linux-amd64").stage do
          bin.install "git-credential-locksmith-linux-amd64" => "git-credential-locksmith"
        end
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
    assert_predicate bin/"git-credential-locksmith", :exist?
    assert_predicate bin/"locksmith-cockpit", :exist? if OS.mac?
  end
end
