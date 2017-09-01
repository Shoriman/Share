setopt no_global_rcs
PYENV_ROOT=~/.pyenv
export PATH="/opt/local/bin:/usr/local/bin:/opt/local/sbin:/usr/local/lib/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/opt/local/libexec/gnubin:$PYENV_ROOT/bin:/Users/nishimoto/.pyenv/versions/anaconda3-4.4.0"
#export PYTHONPATH="/Library/Python/2.7/site-packages:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export READNULLCMD=less
export FCEDIT=emacs
export EDITOR=emacs
