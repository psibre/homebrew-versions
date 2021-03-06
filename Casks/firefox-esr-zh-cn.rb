cask 'firefox-esr-zh-cn' do
  version '38.6.1'
  sha256 '21b4627fa774199453f22ef3877b7cd2926850ed8cdfb8a19498674c7eb45483'

  url "https://download-installer.cdn.mozilla.net/pub/firefox/releases/#{version}esr/mac/zh-CN/Firefox%20#{version}esr.dmg"
  name 'Mozilla Firefox'
  homepage 'https://www.mozilla.org/zh-CN/firefox/organizations/'
  license :mpl

  app 'Firefox.app'

  zap delete: [
                '~/Library/Application Support/Firefox',
                '~/Library/Caches/Firefox',
              ]
end
