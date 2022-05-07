

# Note: that is needed in order to build gui version
# apt build-dep vim-gtk

#!/bin/bash
INSTALL_DIR=~/.local

cd ~/installs/vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-cscope \
			--enable-gui \
            --prefix=${INSTALL_DIR}

make

make install
echo vim installed in ${INSTALL_DIR}
cd -

# will install in ~/.local/bin/vim
