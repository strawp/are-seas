#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ls $SCRIPT_DIR/dot-* | while read f;
do
  dotf=$HOME/$(echo $(basename $f) | sed 's/dot-/./');
  # echo "$f => $dotf"
  if [ -L $dotf ]; then
    rm $dotf;
  fi
  if [ -f $dotf ]; then
    rm $dotf;
  fi
  ln -s $f $dotf
  ls -la $dotf
done
