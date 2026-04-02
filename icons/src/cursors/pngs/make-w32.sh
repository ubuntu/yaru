#!/bin/sh

THEME=Yaru
DIR="../../.."

# $@ is for the caller to be able to supply arguments to anicursorgen (-s, in particular)
GEN=../anicursorgen.py\ "$@"
mkdir -p $DIR/$THEME/cursors
${GEN} default$s.in $DIR/$THEME/cursors/default.cur
${GEN} help$s.in $DIR/$THEME/cursors/help.cur
${GEN} pointer$s.in $DIR/$THEME/cursors/pointer.cur
${GEN} context-menu$s.in $DIR/$THEME/cursors/context-menu.cur
${GEN} progress$s.in $DIR/$THEME/cursors/progress.ani
${GEN} wait$s.in $DIR/$THEME/cursors/wait.ani
${GEN} cell$s.in $DIR/$THEME/cursors/cell.cur
${GEN} crosshair$s.in $DIR/$THEME/cursors/crosshair.cur
${GEN} text$s.in $DIR/$THEME/cursors/text.cur
${GEN} vertical-text$s.in $DIR/$THEME/cursors/vertical-text.cur
${GEN} alias$s.in $DIR/$THEME/cursors/alias.cur
${GEN} copy$s.in $DIR/$THEME/cursors/copy.cur
${GEN} no-drop$s.in $DIR/$THEME/cursors/no-drop.cur
${GEN} move$s.in $DIR/$THEME/cursors/move.cur
${GEN} not-allowed$s.in $DIR/$THEME/cursors/not-allowed.cur
${GEN} grab$s.in $DIR/$THEME/cursors/grab.cur
${GEN} grabbing$s.in $DIR/$THEME/cursors/grabbing.cur
${GEN} all-scroll$s.in $DIR/$THEME/cursors/all-scroll.cur
${GEN} col-resize$s.in $DIR/$THEME/cursors/col-resize.cur
${GEN} row-resize$s.in $DIR/$THEME/cursors/row-resize.cur
${GEN} n-resize$s.in $DIR/$THEME/cursors/n-resize.cur
${GEN} s-resize$s.in $DIR/$THEME/cursors/s-resize.cur
${GEN} e-resize$s.in $DIR/$THEME/cursors/e-resize.cur
${GEN} w-resize$s.in $DIR/$THEME/cursors/w-resize.cur
${GEN} ne-resize$s.in $DIR/$THEME/cursors/ne-resize.cur
${GEN} nw-resize$s.in $DIR/$THEME/cursors/nw-resize.cur
${GEN} sw-resize$s.in $DIR/$THEME/cursors/sw-resize.cur
${GEN} se-resize$s.in $DIR/$THEME/cursors/se-resize.cur
${GEN} ew-resize$s.in $DIR/$THEME/cursors/ew-resize.cur
${GEN} ns-resize$s.in $DIR/$THEME/cursors/ns-resize.cur
${GEN} nesw-resize$s.in $DIR/$THEME/cursors/nesw-resize.cur
${GEN} nwse-resize$s.in $DIR/$THEME/cursors/nwse-resize.cur
${GEN} zoom-in$s.in $DIR/$THEME/cursors/zoom-in.cur
${GEN} zoom-out$s.in $DIR/$THEME/cursors/zoom-out.cur