class Openrtsp < Formula
  desc "Command-line RTSP client"
  homepage "http://www.live555.com/openRTSP"
  url "http://www.live555.com/liveMedia/public/live.2018.02.28.tar.gz"
  sha256 "2db4f05616bdd21a609baf82c836486c44820c16a006315e02abe2b0b53a247e"

  bottle do
    cellar :any_skip_relocation
    sha256 "c042962b4b8261c722c46d904a9e3d8078344448a6b4bfb81fcb56ebe07438e9" => :high_sierra
    sha256 "468b66553ad7f489a2afa6646c90fc58a31c5a657f868ac19248daa75e4aa5c9" => :sierra
    sha256 "c979dfa20332ca316f8df98d679b015a66b0292a9bef005ba52bff2793da3a06" => :el_capitan
  end

  def install
    system "./genMakefiles", "macosx"
    system "make", "PREFIX=#{prefix}", "install"

    # Move the testing executables out of the main PATH
    libexec.install Dir.glob(bin/"test*")
  end

  def caveats; <<~EOS
    Testing executables have been placed in:
      #{libexec}
    EOS
  end

  test do
    assert_match "GNU", shell_output("#{bin}/live555ProxyServer 2>&1", 1)
  end
end
