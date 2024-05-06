class Nudoku < Formula
  desc "Ncurses based sudoku game"
  homepage "https://jubalh.github.io/nudoku/"
  url "https://github.com/jubalh/nudoku/archive/refs/tags/4.0.1.tar.gz"
  sha256 "070dc06d9dad2a436fd44ff52a24f51c2522b13cc68e3d97765f4357f4dfc3d8"
  license "GPL-3.0-or-later"
  head "https://github.com/jubalh/nudoku.git", branch: "master"

  bottle do
    sha256 arm64_sonoma:   "0bb879946ff04df64aa3397abc3cbb8f3a824be827e347d9bdf15d09e535a91b"
    sha256 arm64_ventura:  "c198f6bc3efc45b4dea740cd7e24902cdca7959b3991c7ad7bf4e3dee09e2fd3"
    sha256 arm64_monterey: "23a5711b6e6737de0aa63f63b3e2198beb92c4dea60495f129da86622a44d000"
    sha256 sonoma:         "ff119b0ef03b51582b10b794f983ef175d77f328f410e978f0e14789a505b2ed"
    sha256 ventura:        "5a180a9dacfb0f815b3525445a05b44528d7ef3702facf6790b2a3357d6f041c"
    sha256 monterey:       "a6f4e2c0d5fc485ac3ff87f21a1fc91a4492719f87a542d75d05f7fcf9c74683"
    sha256 x86_64_linux:   "24f584f6e44fb15c7dd7ea529a679826ff0ee180cdd1b502d58ee5e704847056"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "gettext"

  uses_from_macos "ncurses"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-cairo",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "nudoku version #{version}", shell_output("#{bin}/nudoku -v")
  end
end
