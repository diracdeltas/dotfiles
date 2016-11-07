#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set private.optionR2ra 1
/bin/echo -n .
$cli set private.optionRCmd2la 1
/bin/echo -n .
$cli set remap.shiftR2uparrow 1
/bin/echo -n .
$cli set repeat.initial_wait 250
/bin/echo -n .
$cli set repeat.wait 33
/bin/echo -n .
/bin/echo
