# Editor and pager configuration
export EDITOR="vim"
export VISUAL="$EDITOR"
export GIT_PAGER="less"
export BLOCKSIZE="k"

# Pager configuration
if command -v most &> /dev/null; then
    export PAGER="most"
    alias more="most"
else
    export PAGER="less"
    alias more="less"
fi

# Less options
export LESS="-EfmrSwX"

# Locale settings
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# Colors
export LSCOLORS="gxfxcxdxbxegedabagacad"

# Tool-specific configurations
export HOMEBREW_NO_ANALYTICS=1
export STARSHIP_CONFIG=~/.config/starship.toml
export AWS_DEFAULT_REGION="ap-northeast-1"

# Input method (Linux)
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus

# Perl CPAN mirror
export PERL_CPANM_OPT="--mirror http://cpan.nctu.edu.tw/ --mirror http://cpan.cpantesters.org/"
