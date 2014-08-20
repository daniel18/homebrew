require 'formula'

class Mpdscribble < Formula
  homepage 'http://mpd.wikia.com/wiki/Client:Mpdscribble'
  url 'http://www.musicpd.org/download/mpdscribble/0.22/mpdscribble-0.22.tar.gz'
  sha1 '3b4a1a71130deea1720bbfeb104fdcae298f52de'

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'libmpdclient'

  def install
    system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{etc}"
    system "make install"
  end

  def caveats; <<-EOS.undent
    The configuration file was placed in #{etc}/mpdscribble.conf
    EOS
  end

  plist_options :manual => "mpdscribble"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
        <key>ProgramArguments</key>
        <array>
            <string>#{opt_bin}/mpdscribble</string>
            <string>--no-daemon</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>StandardErrorPath</key>
        <string>#{var}/log/mpdscribble_err.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/mpdscribble.log</string>
    </dict>
    </plist>
    EOS
  end
end
