#!/usr/bin/env bash

ME=$(basename ${BASH_SOURCE[0]})
MYDIR=$(realpath $(dirname ${BASH_SOURCE[0]})/..)
CSSDIR=$MYDIR/css
CSS=$CSSDIR/popup.css
THEME=Chybz

JSON=$(jq -Rcrj @json < $CSS | sed -e 's/""/\\n/g')

case $(uname -s) in
    Darwin)
    STDIR="$HOME/Library/Application Support/Sublime Text/Packages/User"
    ;;
    Linux)
    echo FIXME && exit 1
    ;;
esac

COLOR_SCHEME="$STDIR/$THEME.sublime-color-scheme"

if [[ ! -f "$COLOR_SCHEME" ]]; then
    echo '{}' > "$COLOR_SCHEME"
fi

grep -v '//' "$COLOR_SCHEME" | jq ".globals.popup_css=$JSON" > "$COLOR_SCHEME.new"
mv "$COLOR_SCHEME.new" "$COLOR_SCHEME"
