cask 'macvim-kaoriya' do
  if MacOS.release <= :lion
    version '7.4:20130911'
    sha256 'd9fc6e38de1852e4ef79e9ea78afa60e606bf45066cff031e349d65748cbfbce'
  else
    version '7.4:20160219'
    sha256 '70d981be091500476ac8385c39d33f8ff5a5a25398c542dd490502db188d6e9b'
  end

  url "https://github.com/splhack/macvim-kaoriya/releases/download/#{version.after_colon}/MacVim-KaoriYa-#{version.after_colon}.dmg"
  appcast 'https://raw.githubusercontent.com/splhack/macvim-kaoriya/master/latest.xml',
          checkpoint: 'b2ed0a8425b4f645be20cf2e08f755943d00b965a1bbc4e746f41e2cad18e592'
  name 'MacVim KaoriYa'
  homepage 'https://github.com/splhack/macvim-kaoriya'
  license :oss

  depends_on macos: '>= :lion'

  app 'MacVim.app'

  mvim = 'MacVim.app/Contents/MacOS/mvim'
  executables = %w[macvim-askpass mvim mvimdiff mview mvimex gvim gvimdiff gview gvimex]
  executables += %w[vi vim vimdiff view vimex] if ARGV.include? '--override-system-vim'
  executables.each { |e| binary mvim, target: e }

  postflight do
    system 'ruby',
           '-i.bak',
           '-pe',
           %q[sub %r[`dirname "\$0"`(?=(?:/\.\.){3})], '$(cd $(dirname $(readlink $0 || echo $0));pwd)'],
           staged_path.join(mvim)
  end

  zap delete: [
                '~/Library/Preferences/org.vim.MacVim.LSSharedFileList.plist',
                '~/Library/Preferences/org.vim.MacVim.plist',
              ]

  caveats do
    files_in_usr_local
    <<-EOS.undent
      Note that homebrew also provides a compiled macvim Formula that links its
      binary to /usr/local/bin/mvim. And the Cask MacVim also does. It's not
      recommended to install both the Cask MacVim KaoriYa and the Cask MacVim
      and the Formula of MacVim.

      This cask installs symlinks in /usr/local/bin that target to the binary
      MacVim.app/Contents/MacOS/mvim. Below is the list.
        macvim-askpass / mvim / mvimdiff / mview / mvimex /
        gvim / gvimdiff / gview / gvimex

      With --override-system-vim option, you can have more symlinks to use
      macvim-kaoriya instead of the system vim.
        vi / vim / vimdiff / view / vimex
    EOS
  end
end
