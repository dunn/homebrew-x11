class TigerVnc < Formula
  homepage "http://tigervnc.org/"
  url "https://github.com/TigerVNC/tigervnc/archive/v1.4.3.tar.gz"
  sha256 "0b2603db2b32dfd6e48f6f59618bd9819d187bfbb0c16218637d074a69756824"

  head "https://github.com/TigerVNC/tigervnc.git"

  depends_on "cmake" => :build
  depends_on "gnutls" => :recommended
  depends_on "jpeg-turbo"
  depends_on "gettext"
  depends_on "fltk"
  depends_on :x11

  def install
    turbo = Formula["jpeg-turbo"]
    args = std_cmake_args + %W[
      -DJPEG_INCLUDE_DIR=#{turbo.include}
      -DJPEG_LIBRARY=#{turbo.lib}/libjpeg.dylib
      .
    ]
    system "cmake", *args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vncviewer -h 2>&1", 1)
  end
end
