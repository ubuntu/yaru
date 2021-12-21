#!/bin/sh

THEME=Yaru
DIR="../../.."

# $@ is for the caller to be able to supply arguments to anicursorgen (-s, in particular)
GEN=../anicursorgen.py\ "$@"
# enter cursors folder
cd bitmaps

if [ ! -d "$DIR/$THEME/cursors" ]; then
	mkdir -p $DIR/$THEME/cursors
fi

${GEN} all-scroll$s.in $DIR/$THEME/cursors/all-scroll.cur
# ${GEN} based_arrow_down$s.in $DIR/$THEME/cursors/based_arrow_down.cur
# ${GEN} based_arrow_up$s.in $DIR/$THEME/cursors/based_arrow_up.cur
${GEN} bd_double_arrow$s.in $DIR/$THEME/cursors/bd_double_arrow.cur
${GEN} bd_double_arrow$s.in $DIR/$THEME/cursors/c7088f0f3e6c8088236ef8e1e3e70000.cur
${GEN} bd_double_arrow$s.in $DIR/$THEME/cursors/nwse-resize.cur
${GEN} bd_double_arrow$s.in $DIR/$THEME/cursors/size_fdiag.cur
${GEN} bd_double_arrow$s.in $DIR/$THEME/cursors/size-fdiag.cur
${GEN} bottom_left_corner$s.in $DIR/$THEME/cursors/bottom_left_corner.cur
${GEN} bottom_left_corner$s.in $DIR/$THEME/cursors/sw-resize.cur
${GEN} bottom_right_corner$s.in $DIR/$THEME/cursors/bottom_right_corner.cur
${GEN} bottom_right_corner$s.in $DIR/$THEME/cursors/se-resize.cur
${GEN} bottom_side$s.in $DIR/$THEME/cursors/bottom_side.cur
${GEN} bottom_side$s.in $DIR/$THEME/cursors/s-resize.cur
${GEN} bottom_tee$s.in $DIR/$THEME/cursors/bottom_tee.cur
# ${GEN} center_ptr$s.in $DIR/$THEME/cursors/center_ptr.cur
${GEN} circle$s.in $DIR/$THEME/cursors/circle.cur
${GEN} color-picker$s.in $DIR/$THEME/cursors/color-picker.cur
${GEN} context-menu$s.in $DIR/$THEME/cursors/context-menu.cur
${GEN} copy$s.in $DIR/$THEME/cursors/copy.cur
${GEN} copy$s.in $DIR/$THEME/cursors/1081e37283d90000800003c07f3ef6bf.cur
${GEN} copy$s.in $DIR/$THEME/cursors/6407b0e94181790501fd1e167b474872.cur
${GEN} cross$s.in $DIR/$THEME/cursors/cross.cur
${GEN} cross$s.in $DIR/$THEME/cursors/cross_reverse.cur
${GEN} cross$s.in $DIR/$THEME/cursors/diamond_cross.cur
${GEN} crossed_circle$s.in $DIR/$THEME/cursors/crossed_circle.cur
${GEN} crossed_circle$s.in $DIR/$THEME/cursors/03b6e0fcb3499374a867c041f52298f0.cur
${GEN} crossed_circle$s.in $DIR/$THEME/cursors/not-allowed.cur
${GEN} crosshair$s.in $DIR/$THEME/cursors/crosshair.cur
${GEN} dnd-ask$s.in $DIR/$THEME/cursors/dnd-ask.cur
${GEN} dnd-copy$s.in $DIR/$THEME/cursors/dnd-copy.cur
${GEN} dnd-link$s.in $DIR/$THEME/cursors/dnd-link.cur
${GEN} dnd-link$s.in $DIR/$THEME/cursors/alias.cur
${GEN} dnd-move$s.in $DIR/$THEME/cursors/dnd-move.cur
${GEN} dnd-no-drop$s.in $DIR/$THEME/cursors/dnd-no-drop.cur
${GEN} dnd-no-drop$s.in $DIR/$THEME/cursors/no-drop.cur
${GEN} dnd-no-drop$s.in $DIR/$THEME/cursors/forbidden.cur
${GEN} dnd-none$s.in $DIR/$THEME/cursors/dnd-none.cur
${GEN} dnd-none$s.in $DIR/$THEME/cursors/closedhand.cur
${GEN} dotbox$s.in $DIR/$THEME/cursors/dotbox.cur
${GEN} dotbox$s.in $DIR/$THEME/cursors/dot_box_mask.cur
${GEN} dotbox$s.in $DIR/$THEME/cursors/draped_box.cur
${GEN} dotbox$s.in $DIR/$THEME/cursors/icon.cur
${GEN} dotbox$s.in $DIR/$THEME/cursors/target.cur
${GEN} fd_double_arrow$s.in $DIR/$THEME/cursors/fd_double_arrow.cur
${GEN} fd_double_arrow$s.in $DIR/$THEME/cursors/fcf1c3c7cd4491d801f1e1c78f100000.cur
${GEN} fd_double_arrow$s.in $DIR/$THEME/cursors/nesw-resize.cur
${GEN} fd_double_arrow$s.in $DIR/$THEME/cursors/size_bdiag.cur
${GEN} fd_double_arrow$s.in $DIR/$THEME/cursors/size-bdiag.cur
${GEN} grabbing$s.in $DIR/$THEME/cursors/grabbing.cur
${GEN} grabbing$s.in $DIR/$THEME/cursors/size_all.cur
${GEN} hand1$s.in $DIR/$THEME/cursors/hand1.cur
${GEN} hand1$s.in $DIR/$THEME/cursors/grab.cur
${GEN} hand1$s.in $DIR/$THEME/cursors/openhand.cur
${GEN} hand2$s.in $DIR/$THEME/cursors/hand2.cur
${GEN} hand2$s.in $DIR/$THEME/cursors/hand.cur
${GEN} hand2$s.in $DIR/$THEME/cursors/pointer.cur
${GEN} hand2$s.in $DIR/$THEME/cursors/pointing_hand.cur
${GEN} hand2$s.in $DIR/$THEME/cursors/9d800788f1b08800ae810202380a0822.cur
${GEN} hand2$s.in $DIR/$THEME/cursors/e29285e634086352946a0e7090d73106.cur
${GEN} left_ptr$s.in $DIR/$THEME/cursors/left_ptr.cur
${GEN} left_ptr$s.in $DIR/$THEME/cursors/arrow.cur
${GEN} left_ptr$s.in $DIR/$THEME/cursors/default.cur
${GEN} left_ptr$s.in $DIR/$THEME/cursors/top_left_arrow.cur
${GEN} left_ptr_watch$s.in $DIR/$THEME/cursors/left_ptr_watch.ani
${GEN} left_ptr_watch$s.in $DIR/$THEME/cursors/08e8e1c95fe2fc01f976f1e063a24ccd.ani
${GEN} left_ptr_watch$s.in $DIR/$THEME/cursors/3ecb610c1bf2410f44200f48c40d3599.ani
${GEN} left_ptr_watch$s.in $DIR/$THEME/cursors/progress.ani
${GEN} left_ptr_watch$s.in $DIR/$THEME/cursors/00000000000000020006000e7e9ffc3f.ani
${GEN} left_ptr_watch$s.in $DIR/$THEME/cursors/half-busy.ani
${GEN} left_side$s.in $DIR/$THEME/cursors/left_side.cur
${GEN} left_side$s.in $DIR/$THEME/cursors/w-resize.cur
${GEN} left_tee$s.in $DIR/$THEME/cursors/left_tee.cur
${GEN} link$s.in $DIR/$THEME/cursors/link.cur
${GEN} link$s.in $DIR/$THEME/cursors/3085a0e285430894940527032f8b26df.cur
${GEN} link$s.in $DIR/$THEME/cursors/640fb0e74195791501fd1ed57b41487f.cur
${GEN} link$s.in $DIR/$THEME/cursors/a2a266d0498c3104214a47bd64ab0fc8.cur
${GEN} ll_angle$s.in $DIR/$THEME/cursors/ll_angle.cur
${GEN} lr_angle$s.in $DIR/$THEME/cursors/lr_angle.cur
${GEN} move$s.in $DIR/$THEME/cursors/move.cur
${GEN} move$s.in $DIR/$THEME/cursors/4498f0e0c1937ffe01fd06f973665830.cur
${GEN} move$s.in $DIR/$THEME/cursors/9081237383d90e509aa00f00170e968f.cur
${GEN} move$s.in $DIR/$THEME/cursors/fcf21c00b30f7e3f83fe0dfd12e71cff.cur
${GEN} move$s.in $DIR/$THEME/cursors/fleur.cur
${GEN} pencil$s.in $DIR/$THEME/cursors/pencil.cur
${GEN} pencil$s.in $DIR/$THEME/cursors/draft.cur
${GEN} plus$s.in $DIR/$THEME/cursors/plus.cur
${GEN} plus$s.in $DIR/$THEME/cursors/cell.cur
${GEN} pointer-move$s.in $DIR/$THEME/cursors/pointer-move.cur
${GEN} question_arrow$s.in $DIR/$THEME/cursors/question_arrow.cur
${GEN} question_arrow$s.in $DIR/$THEME/cursors/5c6cd98b3f3ebcb1f9c7f1c204630408.cur
${GEN} question_arrow$s.in $DIR/$THEME/cursors/d9ce0ab605698f320427677b458ad60b.cur
${GEN} question_arrow$s.in $DIR/$THEME/cursors/help.cur
${GEN} question_arrow$s.in $DIR/$THEME/cursors/left_ptr_help.cur
${GEN} question_arrow$s.in $DIR/$THEME/cursors/whats_this.cur
${GEN} right_ptr$s.in $DIR/$THEME/cursors/right_ptr.cur
${GEN} right_ptr$s.in $DIR/$THEME/cursors/draft_large.cur
${GEN} right_ptr$s.in $DIR/$THEME/cursors/draft_small.cur
${GEN} right_side$s.in $DIR/$THEME/cursors/right_side.cur
${GEN} right_side$s.in $DIR/$THEME/cursors/e-resize.cur
${GEN} right_tee$s.in $DIR/$THEME/cursors/right_tee.cur
${GEN} sb_down_arrow$s.in $DIR/$THEME/cursors/sb_down_arrow.cur
${GEN} sb_down_arrow$s.in $DIR/$THEME/cursors/down-arrow.cur
${GEN} sb_h_double_arrow$s.in $DIR/$THEME/cursors/sb_h_double_arrow.cur
${GEN} sb_h_double_arrow$s.in $DIR/$THEME/cursors/col-resize.cur
${GEN} sb_h_double_arrow$s.in $DIR/$THEME/cursors/14fef782d02440884392942c11205230.cur
${GEN} sb_h_double_arrow$s.in $DIR/$THEME/cursors/split_h.cur
${GEN} sb_h_double_arrow$s.in $DIR/$THEME/cursors/ew-resize.cur
${GEN} sb_h_double_arrow$s.in $DIR/$THEME/cursors/h_double_arrow.cur
${GEN} sb_h_double_arrow$s.in $DIR/$THEME/cursors/028006030e0e7ebffc7f7070c0600140.cur
${GEN} sb_h_double_arrow$s.in $DIR/$THEME/cursors/size_hor.cur
${GEN} sb_h_double_arrow$s.in $DIR/$THEME/cursors/size-hor.cur
${GEN} sb_left_arrow$s.in $DIR/$THEME/cursors/sb_left_arrow.cur
${GEN} sb_left_arrow$s.in $DIR/$THEME/cursors/left-arrow.cur
${GEN} sb_right_arrow$s.in $DIR/$THEME/cursors/sb_right_arrow.cur
${GEN} sb_right_arrow$s.in $DIR/$THEME/cursors/right-arrow.cur
${GEN} sb_up_arrow$s.in $DIR/$THEME/cursors/sb_up_arrow.cur
${GEN} sb_up_arrow$s.in $DIR/$THEME/cursors/up-arrow.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/sb_v_double_arrow.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/00008160000006810000408080010102.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/2870a09082c103050810ffdffffe0204.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/00008160000006810000408080010102.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/size_ver.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/size-ver.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/double_arrow.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/ns-resize.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/row-resize.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/split_v.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/v_double_arrow.cur
${GEN} tcross$s.in $DIR/$THEME/cursors/tcross.cur
${GEN} top_left_corner$s.in $DIR/$THEME/cursors/top_left_corner.cur
${GEN} top_left_corner$s.in $DIR/$THEME/cursors/nw-resize.cur
${GEN} top_right_corner$s.in $DIR/$THEME/cursors/top_right_corner.cur
${GEN} top_right_corner$s.in $DIR/$THEME/cursors/ne-resize.cur
${GEN} top_side$s.in $DIR/$THEME/cursors/top_side.cur
${GEN} top_side$s.in $DIR/$THEME/cursors/n-resize.cur
${GEN} top_tee$s.in $DIR/$THEME/cursors/top_tee.cur
${GEN} ul_angle$s.in $DIR/$THEME/cursors/ul_angle.cur
${GEN} ur_angle$s.in $DIR/$THEME/cursors/ur_angle.cur
${GEN} vertical-text$s.in $DIR/$THEME/cursors/vertical-text.cur
${GEN} watch$s.in $DIR/$THEME/cursors/watch.ani
${GEN} watch$s.in $DIR/$THEME/cursors/wait.ani
${GEN} wayland_cursor$s.in $DIR/$THEME/cursors/wayland_cursor.cur
${GEN} wayland_cursor$s.in $DIR/$THEME/cursors/wayland-cursor.cur
${GEN} X_cursor$s.in $DIR/$THEME/cursors/X_cursor.cur
${GEN} X_cursor$s.in $DIR/$THEME/cursors/x-cursor.cur
${GEN} X_cursor$s.in $DIR/$THEME/cursors/pirate.cur
${GEN} xterm$s.in $DIR/$THEME/cursors/xterm.cur
${GEN} xterm$s.in $DIR/$THEME/cursors/text.cur
${GEN} xterm$s.in $DIR/$THEME/cursors/ibeam.cur
${GEN} zoom-in$s.in $DIR/$THEME/cursors/zoom-in.cur
${GEN} zoom-out$s.in $DIR/$THEME/cursors/zoom-out.cur

# go back up one
cd ..
