cask 'torbrowser-alpha' do
  version '6.0a2'
  sha256 'cdf8559a5ac4d7ceb738d4f52775549ccdfa14876f083cdf0c08e3d4eee79046'

  url "https://dist.torproject.org/torbrowser/#{version}/TorBrowser-#{version}-osx64_en-US.dmg"
  name 'Tor Browser'
  homepage 'https://www.torproject.org/projects/torbrowser.html'
  license :oss
  gpg "#{url}.asc",
      key_id: 'ef6e286dda85ea2a4ba7de684e2c6e8793298290'

  app 'TorBrowser.app'

  caveats <<-EOS.undent
    If you already have a version of TorBrowser installed this will overwrite your local settings.
    It is recommended to use TorBrowser's built-in update mechanism after the first install to keep your settings.
  EOS
end
