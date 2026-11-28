# typed: false
# frozen_string_literal: true

class Locksmith < Formula
  desc "Secure keychain-backed secrets manager with biometric authentication"
  homepage "https://github.com/bonjoski/locksmith"
  version "3.4.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/locksmith-darwin-arm64"
      sha256 "ae0cefa49e8702c162c95fb3900a5b68918a6fdcafd1bc7b18826386feb863d0"

      resource "summon-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/summon-locksmith-darwin-arm64"
        sha256 "097432a14940deac3810c53d2165de1732cfdeae2cc103d99acf7638a9a6f2db"
      end

      resource "git-credential-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/git-credential-locksmith-darwin-arm64"
        sha256 "326783d50459c034370879343447c6f9ff0b9278b9d5e9578716abc3e9b01d92"
      end

      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/locksmith-cockpit-darwin-arm64"
        sha256 "de8c283a9daef9d3bc8e6717bd0406c17b93512ba380c0cf732eb0da0edcaf5a"
      end

      def install
        bin.install "locksmith-darwin-arm64" => "locksmith"
        bin.install_symlink "locksmith" => "docker-credential-locksmith"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/locksmith-darwin-amd64"
      sha256 "cf8a84b23cbd4e1b254a677789726e395698190d70cffc406c69c970079d0e1e"

      resource "summon-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/summon-locksmith-darwin-amd64"
        sha256 "c66b5b0836363040d09a7e7a79b7856852379f63eff24bb519d8a7fcc7190b2f"
      end

      resource "git-credential-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/git-credential-locksmith-darwin-amd64"
        sha256 "c2128e0417661c79b291cd6c0874ae7fc6645b7448d1520f99ad2bac0693616f"
      end

      resource "cockpit-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/locksmith-cockpit-darwin-amd64"
        sha256 "b8f0d4d7ddda2e5185ad8b0ec171c219007f22e80930628f600ac67a21392a18"
      end

      def install
        bin.install "locksmith-darwin-amd64" => "locksmith"
        bin.install_symlink "locksmith" => "docker-credential-locksmith"
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
      url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/locksmith-linux-arm64"
      sha256 "99272139d941291e44353078df8016096b1b9f849cd977fdadac628f914defa4"

      resource "git-credential-linux-arm64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/git-credential-locksmith-linux-arm64"
        sha256 "128e38d6a3261b4f219036b4f48f75eb1cbac2fdc8948bd4037763450fcc3171"
      end

      def install
        bin.install "locksmith-linux-arm64" => "locksmith"
        bin.install_symlink "locksmith" => "docker-credential-locksmith"
        resource("git-credential-linux-arm64").stage do
          bin.install "git-credential-locksmith-linux-arm64" => "git-credential-locksmith"
        end
      end
    else
      url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/locksmith-linux-amd64"
      sha256 "ba88eddddbac40222705184245918f5a3334e1e4a366ea5287e372a7f3540ea9"

      resource "git-credential-linux-amd64" do
        url "https://github.com/bonjoski/locksmith/releases/download/v3.4.3/git-credential-locksmith-linux-amd64"
        sha256 "37b23bbd67dd88ab801dab601b284375d964c5a5d13c76aadbb9037237c97b16"
      end

      def install
        bin.install "locksmith-linux-amd64" => "locksmith"
        bin.install_symlink "locksmith" => "docker-credential-locksmith"
        resource("git-credential-linux-amd64").stage do
          bin.install "git-credential-locksmith-linux-amd64" => "git-credential-locksmith"
        end
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/locksmith --version 2>&1")
    assert_predicate bin/"git-credential-locksmith", :exist?
    assert_predicate bin/"docker-credential-locksmith", :exist?
    assert_predicate bin/"locksmith-cockpit", :exist? if OS.mac?
  end
end
