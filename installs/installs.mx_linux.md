# Installs Log for MX Linux

### llvm and clang
* Compiled from source according to [jdhao-neovim_cpp_dev_setup](https://jdhao.github.io/2020/11/29/neovim_cpp_dev_setup/)
*
```
git clone --depth=1 https://github.com/llvm/llvm-project.git
cd llvm-project/build/
cmake -G 'Unix Makefiles' -DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra' -DCMAKE_INSTALL_PREFIX=~/installs/llvm -DCMAKE_BUILD_TYPE=Release ../llvm
make -j 4
cmake --build . --target install
```

### qtreator
* installed offline version 4.12. (Worked without problems. no dependencies were needed)

### bat

## ripgrep
* build from sources 2022/02/09 (from here: [ripgrep](https://github.com/BurntSushi/ripgrep))

## 2021/11/14 java + javafx (--ww--)
1. install openjdk8
2. copy openjfx.tar.gz to /usr/share/java and untar it there (will install java fx)

## 2021/10/12 universal-ctags
```
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=/home/rdev/.local/
make
make install
```

## 2021/10/11 Python tools (--ww--)
* pip3 install bandit
* pip3 install mypy
* pip3 install isort
* pip3 install flake8
* pip3 install black
* pip3 install prospector (maybe not needed?)

## Alacritty
I have installed it from source.
Steps:
1. install cargo compiler (rust) with rust.up script
2. Note: `.cargo/bin` dir is added to path. Inside are cargo and other rust binaries
3. git clone the alacritty
4. build
5. install to /usr/local/bin
6. you can delete the current alacritty dir, unless you want to upgrade it

## The nerd fonts (--ww--)
1. First I installed Hack fonts (from here https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack)
2. download them and unpack in /usr/share/fonts/
3. Update ~/.alacritty.yml file to use the Hack fonts
4. And in addition installed the Fira Mono fonts from here : https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/complete/Fira%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.otf
5. I put this file in ~/.local/share/fonts/
6. run fc-cache -fv
7. Restarted the terminal (Important)
8. Seems like Fira Mono is used as secondary font

## tmux
0. install libeven-dev `sudo apt install libevent-dev`
1. download a new tmux `wget https://github.com/tmux/tmux/releases/download/3.2a/tmux-3.2a.tar.gz`
2. `tar -xzf tmux-*.tar.gz` and `cd tmux-*/`
3. `./configure --prefix=/usr/local/`
4. `make && sudo make install`

## ccls
Update: I am using ccls for vim. Installed it with stand-alone clang version:
* from here: <https://github.com/MaskRay/ccls/wiki/Build>
```
wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
cmake --build Release
```

## bat
1. Installed from source with following command: `cargo install --locked bat`
2. The command installs it in .cargo/bin

## fd
1. git clone https://github.com/sharkdp/fd
2. cargo build
3. cargo install --path .
4. installed in ~/.cargo/bin/


## deno (--ww--)
1. installed with `curl -fsSL https://deno.land/x/install/install.sh | sh`
2. updated path to deno exec in ~/.bashrc
