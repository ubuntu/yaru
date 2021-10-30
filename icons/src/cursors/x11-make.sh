#!/bin/sh

THEME=Yaru
DIR="../../.."

# enter bitmaps folder
cd bitmaps

# if cursors folder doesn't exist
if [ ! -d "$DIR/$THEME/cursors" ]; then
	mkdir -p $DIR/$THEME/cursors
fi

xcursorgen all-scroll.in $DIR/$THEME/cursors/all-scroll
# xcursorgen based_arrow_down.in $DIR/$THEME/cursors/based_arrow_down
# xcursorgen based_arrow_up.in $DIR/$THEME/cursors/based_arrow_up
xcursorgen bd_double_arrow.in $DIR/$THEME/cursors/bd_double_arrow
xcursorgen bd_double_arrow.in $DIR/$THEME/cursors/c7088f0f3e6c8088236ef8e1e3e70000
xcursorgen bd_double_arrow.in $DIR/$THEME/cursors/nwse-resize
xcursorgen bd_double_arrow.in $DIR/$THEME/cursors/size_fdiag
xcursorgen bd_double_arrow.in $DIR/$THEME/cursors/size-fdiag
xcursorgen bottom_left_corner.in $DIR/$THEME/cursors/bottom_left_corner
xcursorgen bottom_left_corner.in $DIR/$THEME/cursors/sw-resize
xcursorgen bottom_right_corner.in $DIR/$THEME/cursors/bottom_right_corner
xcursorgen bottom_right_corner.in $DIR/$THEME/cursors/se-resize
xcursorgen bottom_side.in $DIR/$THEME/cursors/bottom_side
xcursorgen bottom_side.in $DIR/$THEME/cursors/s-resize
xcursorgen bottom_tee.in $DIR/$THEME/cursors/bottom_tee
# xcursorgen center_ptr.in $DIR/$THEME/cursors/center_ptr
xcursorgen circle.in $DIR/$THEME/cursors/circle
xcursorgen color-picker.in $DIR/$THEME/cursors/color-picker
xcursorgen context-menu.in $DIR/$THEME/cursors/context-menu
xcursorgen copy.in $DIR/$THEME/cursors/copy
xcursorgen copy.in $DIR/$THEME/cursors/1081e37283d90000800003c07f3ef6bf
xcursorgen copy.in $DIR/$THEME/cursors/6407b0e94181790501fd1e167b474872
xcursorgen cross.in $DIR/$THEME/cursors/cross
xcursorgen cross.in $DIR/$THEME/cursors/cross_reverse
xcursorgen cross.in $DIR/$THEME/cursors/diamond_cross
xcursorgen crossed_circle.in $DIR/$THEME/cursors/crossed_circle
xcursorgen crossed_circle.in $DIR/$THEME/cursors/03b6e0fcb3499374a867c041f52298f0
xcursorgen crossed_circle.in $DIR/$THEME/cursors/not-allowed
xcursorgen crosshair.in $DIR/$THEME/cursors/crosshair
xcursorgen dnd-ask.in $DIR/$THEME/cursors/dnd-ask
xcursorgen dnd-copy.in $DIR/$THEME/cursors/dnd-copy
xcursorgen dnd-link.in $DIR/$THEME/cursors/dnd-link
xcursorgen dnd-link.in $DIR/$THEME/cursors/alias
xcursorgen dnd-move.in $DIR/$THEME/cursors/dnd-move
xcursorgen dnd-no-drop.in $DIR/$THEME/cursors/dnd-no-drop
xcursorgen dnd-no-drop.in $DIR/$THEME/cursors/no-drop
xcursorgen dnd-no-drop.in $DIR/$THEME/cursors/forbidden
xcursorgen dnd-none.in $DIR/$THEME/cursors/dnd-none
xcursorgen dnd-none.in $DIR/$THEME/cursors/closedhand
xcursorgen dotbox.in $DIR/$THEME/cursors/dotbox
xcursorgen dotbox.in $DIR/$THEME/cursors/dot_box_mask
xcursorgen dotbox.in $DIR/$THEME/cursors/draped_box
xcursorgen dotbox.in $DIR/$THEME/cursors/icon
xcursorgen dotbox.in $DIR/$THEME/cursors/target
xcursorgen fd_double_arrow.in $DIR/$THEME/cursors/fd_double_arrow
xcursorgen fd_double_arrow.in $DIR/$THEME/cursors/fcf1c3c7cd4491d801f1e1c78f100000
xcursorgen fd_double_arrow.in $DIR/$THEME/cursors/nesw-resize
xcursorgen fd_double_arrow.in $DIR/$THEME/cursors/size_bdiag
xcursorgen fd_double_arrow.in $DIR/$THEME/cursors/size-bdiag
xcursorgen grabbing.in $DIR/$THEME/cursors/grabbing
xcursorgen grabbing.in $DIR/$THEME/cursors/size_all
xcursorgen hand1.in $DIR/$THEME/cursors/hand1
xcursorgen hand1.in $DIR/$THEME/cursors/grab
xcursorgen hand1.in $DIR/$THEME/cursors/openhand
xcursorgen hand2.in $DIR/$THEME/cursors/hand2
xcursorgen hand2.in $DIR/$THEME/cursors/hand
xcursorgen hand2.in $DIR/$THEME/cursors/pointer
xcursorgen hand2.in $DIR/$THEME/cursors/pointing_hand
xcursorgen hand2.in $DIR/$THEME/cursors/9d800788f1b08800ae810202380a0822
xcursorgen hand2.in $DIR/$THEME/cursors/e29285e634086352946a0e7090d73106
xcursorgen left_ptr.in $DIR/$THEME/cursors/left_ptr
xcursorgen left_ptr.in $DIR/$THEME/cursors/arrow
xcursorgen left_ptr.in $DIR/$THEME/cursors/default
xcursorgen left_ptr.in $DIR/$THEME/cursors/top_left_arrow
xcursorgen left_ptr_watch.in $DIR/$THEME/cursors/left_ptr_watch
xcursorgen left_ptr_watch.in $DIR/$THEME/cursors/08e8e1c95fe2fc01f976f1e063a24ccd
xcursorgen left_ptr_watch.in $DIR/$THEME/cursors/3ecb610c1bf2410f44200f48c40d3599
xcursorgen left_ptr_watch.in $DIR/$THEME/cursors/progress
xcursorgen left_ptr_watch.in $DIR/$THEME/cursors/00000000000000020006000e7e9ffc3f
xcursorgen left_ptr_watch.in $DIR/$THEME/cursors/half-busy
xcursorgen left_side.in $DIR/$THEME/cursors/left_side
xcursorgen left_side.in $DIR/$THEME/cursors/w-resize
xcursorgen left_tee.in $DIR/$THEME/cursors/left_tee
xcursorgen link.in $DIR/$THEME/cursors/link
xcursorgen link.in $DIR/$THEME/cursors/3085a0e285430894940527032f8b26df
xcursorgen link.in $DIR/$THEME/cursors/640fb0e74195791501fd1ed57b41487f
xcursorgen link.in $DIR/$THEME/cursors/a2a266d0498c3104214a47bd64ab0fc8
xcursorgen ll_angle.in $DIR/$THEME/cursors/ll_angle
xcursorgen lr_angle.in $DIR/$THEME/cursors/lr_angle
xcursorgen move.in $DIR/$THEME/cursors/move
xcursorgen move.in $DIR/$THEME/cursors/4498f0e0c1937ffe01fd06f973665830
xcursorgen move.in $DIR/$THEME/cursors/9081237383d90e509aa00f00170e968f
xcursorgen move.in $DIR/$THEME/cursors/fcf21c00b30f7e3f83fe0dfd12e71cff
xcursorgen move.in $DIR/$THEME/cursors/fleur
xcursorgen pencil.in $DIR/$THEME/cursors/pencil
xcursorgen pencil.in $DIR/$THEME/cursors/draft
xcursorgen plus.in $DIR/$THEME/cursors/plus
xcursorgen plus.in $DIR/$THEME/cursors/cell
xcursorgen pointer-move.in $DIR/$THEME/cursors/pointer-move
xcursorgen question_arrow.in $DIR/$THEME/cursors/question_arrow
xcursorgen question_arrow.in $DIR/$THEME/cursors/5c6cd98b3f3ebcb1f9c7f1c204630408
xcursorgen question_arrow.in $DIR/$THEME/cursors/d9ce0ab605698f320427677b458ad60b
xcursorgen question_arrow.in $DIR/$THEME/cursors/help
xcursorgen question_arrow.in $DIR/$THEME/cursors/left_ptr_help
xcursorgen question_arrow.in $DIR/$THEME/cursors/whats_this
xcursorgen right_ptr.in $DIR/$THEME/cursors/right_ptr
xcursorgen right_ptr.in $DIR/$THEME/cursors/draft_large
xcursorgen right_ptr.in $DIR/$THEME/cursors/draft_small
xcursorgen right_side.in $DIR/$THEME/cursors/right_side
xcursorgen right_side.in $DIR/$THEME/cursors/e-resize
xcursorgen right_tee.in $DIR/$THEME/cursors/right_tee
xcursorgen sb_down_arrow.in $DIR/$THEME/cursors/sb_down_arrow
xcursorgen sb_down_arrow.in $DIR/$THEME/cursors/down-arrow
xcursorgen sb_h_double_arrow.in $DIR/$THEME/cursors/sb_h_double_arrow
xcursorgen sb_h_double_arrow.in $DIR/$THEME/cursors/col-resize
xcursorgen sb_h_double_arrow.in $DIR/$THEME/cursors/14fef782d02440884392942c11205230
xcursorgen sb_h_double_arrow.in $DIR/$THEME/cursors/split_h
xcursorgen sb_h_double_arrow.in $DIR/$THEME/cursors/ew-resize
xcursorgen sb_h_double_arrow.in $DIR/$THEME/cursors/h_double_arrow
xcursorgen sb_h_double_arrow.in $DIR/$THEME/cursors/028006030e0e7ebffc7f7070c0600140
xcursorgen sb_h_double_arrow.in $DIR/$THEME/cursors/size_hor
xcursorgen sb_h_double_arrow.in $DIR/$THEME/cursors/size-hor
xcursorgen sb_left_arrow.in $DIR/$THEME/cursors/sb_left_arrow
xcursorgen sb_left_arrow.in $DIR/$THEME/cursors/left-arrow
xcursorgen sb_right_arrow.in $DIR/$THEME/cursors/sb_right_arrow
xcursorgen sb_right_arrow.in $DIR/$THEME/cursors/right-arrow
xcursorgen sb_up_arrow.in $DIR/$THEME/cursors/sb_up_arrow
xcursorgen sb_up_arrow.in $DIR/$THEME/cursors/up-arrow
xcursorgen sb_v_double_arrow.in $DIR/$THEME/cursors/sb_v_double_arrow
xcursorgen sb_v_double_arrow.in $DIR/$THEME/cursors/00008160000006810000408080010102
xcursorgen sb_v_double_arrow.in $DIR/$THEME/cursors/2870a09082c103050810ffdffffe0204
xcursorgen sb_v_double_arrow.in $DIR/$THEME/cursors/00008160000006810000408080010102
xcursorgen sb_v_double_arrow.in $DIR/$THEME/cursors/size_ver
xcursorgen sb_v_double_arrow.in $DIR/$THEME/cursors/size-ver
xcursorgen sb_v_double_arrow.in $DIR/$THEME/cursors/double_arrow
xcursorgen sb_v_double_arrow.in $DIR/$THEME/cursors/ns-resize
xcursorgen sb_v_double_arrow.in $DIR/$THEME/cursors/row-resize
xcursorgen sb_v_double_arrow.in $DIR/$THEME/cursors/split_v
xcursorgen sb_v_double_arrow.in $DIR/$THEME/cursors/v_double_arrow
xcursorgen tcross.in $DIR/$THEME/cursors/tcross
xcursorgen top_left_corner.in $DIR/$THEME/cursors/top_left_corner
xcursorgen top_left_corner.in $DIR/$THEME/cursors/nw-resize
xcursorgen top_right_corner.in $DIR/$THEME/cursors/top_right_corner
xcursorgen top_right_corner.in $DIR/$THEME/cursors/ne-resize
xcursorgen top_side.in $DIR/$THEME/cursors/top_side
xcursorgen top_side.in $DIR/$THEME/cursors/n-resize
xcursorgen top_tee.in $DIR/$THEME/cursors/top_tee
xcursorgen ul_angle.in $DIR/$THEME/cursors/ul_angle
xcursorgen ur_angle.in $DIR/$THEME/cursors/ur_angle
xcursorgen vertical-text.in $DIR/$THEME/cursors/vertical-text
xcursorgen watch.in $DIR/$THEME/cursors/watch
xcursorgen watch.in $DIR/$THEME/cursors/wait
xcursorgen wayland_cursor.in $DIR/$THEME/cursors/wayland_cursor
xcursorgen wayland_cursor.in $DIR/$THEME/cursors/wayland-cursor
xcursorgen X_cursor.in $DIR/$THEME/cursors/X_cursor
xcursorgen X_cursor.in $DIR/$THEME/cursors/x-cursor
xcursorgen X_cursor.in $DIR/$THEME/cursors/pirate
xcursorgen xterm.in $DIR/$THEME/cursors/xterm
xcursorgen xterm.in $DIR/$THEME/cursors/text
xcursorgen xterm.in $DIR/$THEME/cursors/ibeam
xcursorgen zoom-in.in $DIR/$THEME/cursors/zoom-in
xcursorgen zoom-out.in $DIR/$THEME/cursors/zoom-out

# go back up one
cd ..
