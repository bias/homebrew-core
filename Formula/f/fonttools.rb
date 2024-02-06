class Fonttools < Formula
  desc "Library for manipulating fonts"
  homepage "https://github.com/fonttools/fonttools"
  url "https://files.pythonhosted.org/packages/24/d5/c9e4706b3f564d8afe3005ccea1c9727a631efe790f8bb17819d12b192ec/fonttools-4.48.1.tar.gz"
  sha256 "8b8a45254218679c7f1127812761e7854ed5c8e34349aebf581e8c9204e7495a"
  license "MIT"
  head "https://github.com/fonttools/fonttools.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "e24e999ba8d4aa7948aed671e9fda57e9797080b9d0086c3f139a31baddf9002"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c57ecd0c3b154b2829dfdfeaf91fdc44862d4aef45256c15db1d73217584c25d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "28c78f6a329ef732edcc1e59dea982d2803b8b603751f6c3c8f0131cf9155017"
    sha256 cellar: :any_skip_relocation, sonoma:         "0f8954ba4f9d32716423e9e891e3933a20848b21a7a3ca0067d4d845bc83a9d3"
    sha256 cellar: :any_skip_relocation, ventura:        "21e8929e6549ea0399fccbe474d96e1477ef56f1c96616f1a44d61ca5a281f7e"
    sha256 cellar: :any_skip_relocation, monterey:       "c2de541ce7ab53817a77d7d11fa2f1e2957c65c3d87021bbe8344c88ff022018"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fc277608562500b69eecfd5f9340365bd3e4f653961aaf1b7247166ea2a2e544"
  end

  depends_on "python-setuptools" => :build
  depends_on "python-brotli"
  depends_on "python@3.12"

  def python3
    which("python3.12")
  end

  def install
    system python3, "-m", "pip", "install", *std_pip_args, "."
  end

  test do
    if OS.mac?
      cp "/System/Library/Fonts/ZapfDingbats.ttf", testpath

      system bin/"ttx", "ZapfDingbats.ttf"
      assert_predicate testpath/"ZapfDingbats.ttx", :exist?
      system bin/"fonttools", "ttLib.woff2", "compress", "ZapfDingbats.ttf"
      assert_predicate testpath/"ZapfDingbats.woff2", :exist?
    else
      assert_match "usage", shell_output("#{bin}/ttx -h")
    end
  end
end
