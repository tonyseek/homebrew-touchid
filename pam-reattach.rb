class PamReattach < Formula
  desc "PAM that reattaches to the user's GUI (Aqua) session on macOS"
  homepage "https://github.com/fabianishere/pam_reattach"
  url "https://github.com/fabianishere/pam_reattach/archive/3c186404fd3bd80c4edab624e99b316aa0c74fe9.tar.gz"
  version "3c18640"
  sha256 "5d84060a581d830e013c6e99169fd71bdc0544c44bd81381c69bd9f1aca3e95f"
  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end

  def caveats; <<~EOS
    You will need to twist the file mode and owner of this PAM manually for
    protecting it from potential attackers:

      sudo chmod 444 #{HOMEBREW_PREFIX}/pam/pam_reattach.so
      sudo chown root:wheel #{HOMEBREW_PREFIX}/pam/pam_reattach.so

    Then prepend it to /etc/pam.d/sudo that makes it work.

      auth       optional       pam_reattach.so
      auth       sufficient     pam_tid.so
      ...
  EOS
  end

  test do
    system "test", "-f", "#{lib}/pam/pam_reattach.so"
  end
end
