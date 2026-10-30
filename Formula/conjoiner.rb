# typed: false
# frozen_string_literal: true

# Formula for Conjoiner (bonjoski/conjoiner)
# Sovereign Agentic IAM Broker, Token Attenuation, and Policy Gateway
class Conjoiner < Formula
  desc "Sovereign NIST-aligned agentic IAM broker, token attenuation, and policy gateway"
  homepage "https://github.com/bonjoski/conjoiner"
  license "MIT"
  head "https://github.com/bonjoski/conjoiner.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/conjoiner"
  end

  def caveats
    <<~EOS
      🔗 Conjoiner Agentic IAM Broker & Policy Gateway has been installed!

      To issue task-attenuated tokens:
        conjoiner token issue --scope "fs:read:/workspace,tool:exec:git:status"

      To compile natural language mandates into capability scopes:
        conjoiner mandate compile --ai "<natural language policy>"
    EOS
  end

  test do
    assert_match "conjoiner version", shell_output("#{bin}/conjoiner version 2>&1")
  end
end
