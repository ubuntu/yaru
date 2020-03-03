The cursors are named according to the current freedesktop.org cursor
conventions specification (draft):

    <http://www.freedesktop.org/Standards/cursor-spec>

Other cursors are provided as symlinks by name or hash.


    X-cursor           The X window system logo.
    default            Default cursor. Indicates the interface is idle and prepared to accept commands from the user. Used to manipulate basic user interface elements like buttons and scrollbars. Usually a left pointing diagonal arrow.
    right-arrow        Inverted version of the default cursor. This cursor is used in Motif when a popup menu or a drop down combo-box is open, to indicate that the widget has grabbed the mouse. Typically rendered as a right pointing diagonal arrow.
    up-arrow           Up pointing arrow cursor. This cursor is typically used to identify an insertion point.
    text               Text input cursor. Indicates that the cursor is in a region in which horizontal text can be selected and possibly edited. Typically rendered as a vertical I-beam.
    vertical-text      Text input cursor. Indicates that the cursor is in a region in which vertical text can be selected and possibly edited. Typically rendered as a horizontal I-beam.
    pointer            Indicates that the object below the cursor is clickable. This cursor is typically used for links in web browsers. It shouldn't be abused for pushbuttons and other UI elements where it's otherwise apparent by the design of the widget that it's a clickable object. Often rendered as a pointing hand.
    crosshair          Crosshair cursor. Typically used for precision drawing or manipulation of an area.
    help               Help cursor. Indicates that the system is in a context help mode, and if the user clicks an object a small window will open up to provide usage information for that object. The context help mode is typically activated by clicking a help button on the titlebar of a window that provides context help. Often rendered as the default cursor with a question mark symbol next to it.
    progress           Default cursor + busy cursor. Indicates a pending activity which may asynchronously affect the interface but which is not blocking commands from the user.
    wait               Busy cursor. Indicates that the interface is not prepared to accept commands from the user and is blocked on some external resource. Often rendered as a watch or an hourglass.
    copy               !DnD copy cursor. Indicates that a copy of the dragged object will be created in the area below the cursor if dropped. Typically rendered as the default cursor with a small plus sign next to it.
    alias              !DnD link cursor. Indicates that a link to the original location of the dragged object will be created in the area below the cursor if dropped. Typically rendered as the default cursor with a small curved arrow next to it.
    no-drop            !DnD no-drop cursor. Indicates that the dragged object can't be dropped in the region below the cursor. Typically rendered as the default cursor with a small circle with a diagonal line through it. Can be identical to not-allowed.
    not-allowed        Forbidden cursor. Indicates that a particular region is invalid for the current operation. Often rendered as circle with a diagonal line through it.
    cell               The thick plus sign cursor that's typically used in spread-sheet applications to select cells.
    all-scroll         Scroll/move cursor. Used to indicate that moving the mouse will also move the UI element below the cursor. Often rendered as a combined vertical and horizontal twin-headed arrow.
    context-menu       Indicates that a context menu is available for the object underneath the cursor. Typically rendered as the default cursor with a small menu-like graphic next to it.
    row-resize         Horizontal splitter bar cursor. Indicates that the bar below the cursor can be moved up and down to resize the objects it separates. Used when it's not apparent if the object below the cursor is just a visual separator between two other UI elements, or an object that can be manipulated. Usually rendered as a vertical twin-headed arrow, split in the middle by a horizontal line.
    col-resize         Vertical splitter bar cursor. Indicates that the bar below the cursor can be moved left and right to resize the objects it separates. Used when it's not apparent if the object below the cursor is just a visual separator between two other UI elements, or an object that can be manipulated. Usually rendered as a horizonal twin-headed arrow, split in the middle by a vertical line.
    e-resize           Indicates that the cursor is over the right edge of a window, and that the edge can be clicked and dragged in order to resize the window horizontally.
    ne-resize          Indicates that the cursor is over the top-right edge of a window, and that the edge can be clicked and dragged in order to resize the window diagonally.
    nw-resize          Indicates that the cursor is over the top-left edge of a window, and that the edge can be clicked and dragged in order to resize the window diagonally.
    n-resize           Indicates that the cursor is over the top edge of a window, and that the edge can be clicked and dragged in order to resize the window vertically.
    se-resize          Indicates that the cursor is over the bottom-right edge of a window, and that the edge can be clicked and dragged in order to resize the window diagonally.
    sw-resize          Indicates that the cursor is over the bottom-left edge of a window, and that the edge can be clicked and dragged in order to resize the window diagonally.
    s-resize           Indicates that the cursor is over the bottom edge of a window, and that the edge can be clicked and dragged in order to resize the window vertically.
    w-resize           Indicates that the cursor is over the left edge of a window, and that the edge can be clicked and dragged in order to resize the window horizontally.
    ew-resize          Horizontal resizing cursor. Indicates that cursor is over the the left or right edge of a window, and that ithe edge can be clicked and dragged to resize the window horizontally. Typically rendered as a horizontal twin-headed arrow.
    ns-resize          Vertical resizing cursor. Indicates that cursor is over the the top or bottom edge of a window, and that the edge can be clicked and dragged to resize the window vertically. Typically rendered as a verticaly twin-headed arrow.
    nesw-resize        Back-diagonal resizing cursor. Indicates that the UI element below the cursor is the top-right or bottom-left corner of a window, and that it can be clicked and dragged to resize the window diagonally. Typically a twin-headed arrow.
    nwse-resize        Forward-diagonal resizing cursor. Indicates that the UI element below the cursor is the top-left or bottom-right corner of a window, and that it can be clicked and dragged to resize the window diagonally. Typically a twin-headed arrow.

This is the current xorg naming convention (CursorName.c, cursor.bdf):

    x_cursor           XC_X_cursor
    arrow              XC_arrow
    based_arrow_down   XC_based_arrow_down
    based_arrow_up     XC_based_arrow_up
    boat               XC_boat
    bogosity           XC_bogosity
    bottom_left_corner XC_bottom_left_corner
    bottom_right_corner XC_bottom_right_corner
    bottom_side        XC_bottom_side
    bottom_tee         XC_bottom_tee
    box_spiral         XC_box_spiral
    center_ptr         XC_center_ptr
    circle             XC_circle
    clock              XC_clock
    coffee_mug         XC_coffee_mug
    cross              XC_cross
    cross_reverse      XC_cross_reverse
    crosshair          XC_crosshair
    diamond_cross      XC_diamond_cross
    dot                XC_dot
    dotbox             XC_dotbox
    double_arrow       XC_double_arrow
    draft_large        XC_draft_large
    draft_small        XC_draft_small
    draped_box         XC_draped_box
    exchange           XC_exchange
    fleur              XC_fleur
    gobbler            XC_gobbler
    gumby              XC_gumby
    hand1              XC_hand1
    hand2              XC_hand2
    heart              XC_heart
    icon               XC_icon
    iron_cross         XC_iron_cross
    left_ptr           XC_left_ptr
    left_side          XC_left_side
    left_tee           XC_left_tee
    leftbutton         XC_leftbutton
    ll_angle           XC_ll_angle
    lr_angle           XC_lr_angle
    man                XC_man
    middlebutton       XC_middlebutton
    mouse              XC_mouse
    pencil             XC_pencil
    pirate             XC_pirate
    plus               XC_plus
    question_arrow     XC_question_arrow
    right_ptr          XC_right_ptr
    right_side         XC_right_side
    right_tee          XC_right_tee
    rightbutton        XC_rightbutton
    rtl_logo           XC_rtl_logo
    sailboat           XC_sailboat
    sb_down_arrow      XC_sb_down_arrow
    sb_h_double_arrow  XC_sb_h_double_arrow
    sb_left_arrow      XC_sb_left_arrow
    sb_right_arrow     XC_sb_right_arrow
    sb_up_arrow        XC_sb_up_arrow
    sb_v_double_arrow  XC_sb_v_double_arrow
    shuttle            XC_shuttle
    sizing             XC_sizing
    spider             XC_spider
    spraycan           XC_spraycan
    star               XC_star
    target             XC_target
    tcross             XC_tcross
    top_left_arrow     XC_top_left_arrow
    top_left_corner    XC_top_left_corner
    top_right_corner   XC_top_right_corner
    top_side           XC_top_side
    top_tee            XC_top_tee
    trek               XC_trek
    ul_angle           XC_ul_angle
    umbrella           XC_umbrella
    ur_angle           XC_ur_angle
    watch              XC_watch
    xterm              XC_xterm

This is the current (Qt4) cursor name scheme (qcursor.cpp, qcursor_x11.cpp):

    Qt::ArrowCursor    left_ptr
    Qt::UpArrowCursor  up_arrow
    Qt::CrossCursor    cross
    Qt::WaitCursor     wait
    Qt::BusyCursor     left_ptr_watch
    Qt::IBeamCursor    ibeam
    Qt::SizeVerCursor  size_ver
    Qt::SizeHorCursor  size_hor
    Qt::SizeBDiagCursor size_bdiag
    Qt::SizeFDiagCursor size_fdiag
    Qt::SizeAllCursor  size_all
    Qt::SplitVCursor   split_v
    Qt::SplitHCursor   split_h
    Qt::PointingHandCursor pointing_hand
    Qt::ForbiddenCursor forbidden
    Qt::WhatsThisCursor whats_this

My denominated map of QCursor to XCursor:

    Qt::ArrowCursor    XC_left_ptr;
    Qt::UpArrowCursor  XC_center_ptr;
    Qt::CrossCursor    XC_crosshair;
    Qt::WaitCursor     XC_watch;
    Qt::IBeamCursor    XC_xterm;
    Qt::SizeAllCursor  XC_fleur;
    Qt::PointingHandCursor XC_hand2;
    Qt::SizeBDiagCursor XC_top_right_corner;
    Qt::SizeFDiagCursor XC_bottom_right_corner;
    Qt::BlankCursor
    Qt::SizeVerCursor  XC_sb_v_double_arrow;
    Qt::SplitVCursor   XC_sb_v_double_arrow;
    Qt::SizeHorCursor  XC_sb_h_double_arrow;
    Qt::SplitHCursor   XC_sb_h_double_arrow;
    Qt::WhatsThisCursor XC_question_arrow;
    Qt::ForbiddenCursor XC_circle;
    Qt::BusyCursor     XC_watch;

This is the current Gnome curser names (gdk_enums.def)

    # x-cursor         GDK_X_CURSOR
    arrow              GDK_ARROW
    based-arrow-down   GDK_BASED_ARROW_DOWN
    based-arrow-up     GDK_BASED_ARROW_UP
    boat               GDK_BOAT
    bogosity           GDK_BOGOSITY
    bottom-left-corner GDK_BOTTOM_LEFT_CORNER
    bottom-right-corner GDK_BOTTOM_RIGHT_CORNER
    bottom-side        GDK_BOTTOM_SIDE
    bottom-tee         GDK_BOTTOM_TEE
    box-spiral         GDK_BOX_SPIRAL
    center-ptr         GDK_CENTER_PTR
    circle             GDK_CIRCLE
    clock              GDK_CLOCK
    coffee-mug         GDK_COFFEE_MUG
    cross              GDK_CROSS
    cross-reverse      GDK_CROSS_REVERSE
    crosshair          GDK_CROSSHAIR
    diamond-cross      GDK_DIAMOND_CROSS
    dot                GDK_DO
    dotbox             GDK_DOTBOX
    double-arrow       GDK_DOUBLE_ARROW
    draft-large        GDK_DRAFT_LARGE
    draft-small        GDK_DRAFT_SMALL
    draped-box         GDK_DRAPED_BOX
    exchange           GDK_EXCHANGE
    fleur              GDK_FLEUR
    gobbler            GDK_GOBBLER
    gumby              GDK_GUMBY
    hand1              GDK_HAND1
    hand2              GDK_HAND2
    heart              GDK_HEART
    icon               GDK_ICON
    iron-cross         GDK_IRON_CROSS
    left-ptr           GDK_LEFT_PTR
    left-side          GDK_LEFT_SIDE
    left-tee           GDK_LEFT_TEE
    leftbutton         GDK_LEFTBUTTON
    ll-angle           GDK_LL_ANGLE
    lr-angle           GDK_LR_ANGLE
    man                GDK_MAN
    middlebutton       GDK_MIDDLEBUTTON
    mouse              GDK_MOUSE
    pencil             GDK_PENCIL
    pirate             GDK_PIRATE
    plus               GDK_PLUS
    question-arrow     GDK_QUESTION_ARROW
    right-ptr          GDK_RIGHT_PTR
    right-side         GDK_RIGHT_SIDE
    right-tee          GDK_RIGHT_TEE
    rightbutton        GDK_RIGHTBUTTON
    rtl-logo           GDK_RTL_LOGO
    sailboat           GDK_SAILBOAT
    sb-down-arrow      GDK_SB_DOWN_ARROW
    sb-h-double-arrow  GDK_SB_H_DOUBLE_ARROW
    sb-left-arrow      GDK_SB_LEFT_ARROW
    sb-right-arrow     GDK_SB_RIGHT_ARROW
    sb-up-arrow        GDK_SB_UP_ARROW
    sb-v-double-arrow  GDK_SB_V_DOUBLE_ARROW
    shuttle            GDK_SHUTTLE
    sizing             GDK_SIZING
    spider             GDK_SPIDER
    spraycan           GDK_SPRAYCAN
    star               GDK_STAR
    target             GDK_TARGET
    tcross             GDK_TCROSS
    top-left-arrow     GDK_TOP_LEFT_ARROW
    top-left-corner    GDK_TOP_LEFT_CORNER
    top-right-corner   GDK_TOP_RIGHT_CORNER
    top-side           GDK_TOP_SIDE
    top-tee            GDK_TOP_TEE
    trek               GDK_TREK
    ul-angle           GDK_UL_ANGLE
    umbrella           GDK_UMBRELLA
    ur-angle           GDK_UR_ANGLE
    watch              GDK_WATCH
    xterm              GDK_XTERM
    last-cursor        GDK_LAST_CURSOR
    # cursor-is-pixmap GDK_CURSOR_IS_PIXMAP

CSS3 Cursors (http://www.w3.org/TR/css3-ui/#cursor0)

    auto               The UA determines the cursor to display based on the current context.
    default            The platform-dependent default cursor. Often rendered as an arrow.
    none               No cursor is rendered for the element.
    context-menu       A context menu is available for the object under the cursor. Often rendered as an arrow with a small menu-like graphic next to it.
    help               Help is available for the object under the cursor. Often rendered as a question mark or a balloon.
    pointer            The cursor is a pointer that indicates a link.
    progress           A progress indicator. The program is performing some processing, but is different from 'wait' in that the user may still interact with the program. Often rendered as a spinning beach ball, or an arrow with a watch or hourglass.
    wait               Indicates that the program is busy and the user should wait. Often rendered as a watch or hourglass.
    cell               Indicates that a cell or set of cells may be selected. Often rendered as a thick plus-sign with a dot in the middle.
    crosshair          A simple crosshair (e.g., short line segments resembling a "+" sign). Often used to indicate a two dimensional bitmap selection mode.
    text               Indicates text that may be selected. Often rendered as a vertical I-beam. User agents may automatically display a horizontal I-beam/cursor (e.g. same as the 'vertical-text' keyword) for vertical text, or for that matter, any angle of I-beam/cursor for text that is rendered at any particular angle.
    vertical-text      Indicates vertical-text that may be selected. Often rendered as a horizontal I-beam.
    alias              Indicates an alias of/shortcut to something is to be created. Often rendered as an arrow with a small curved arrow next to it.
    copy               Indicates something is to be copied. Often rendered as an arrow with a small plus sign next to it.
    move               Indicates something is to be moved.
    no-drop            Indicates that the dragged item cannot be dropped at the current cursor location. Often rendered as a hand or pointer with a small circle with a line through it.
    not-allowed        Indicates that the requested action will not be carried out. Often rendered as a circle with a line through it.
    e-resize
    n-resize
    ne-resize
    nw-resize
    s-resize
    se-resize
    sw-resize,
    w-resize           Indicates that some edge is to be moved. For example, the 'se-resize' cursor is used when the movement starts from the south-east corner of the box.
    ew-resize
    ns-resize
    nesw-resize
    nwse-resize        Indicates a bidirectional resize cursor.
    col-resize         Indicates that the item/column can be resized horizontally. Often rendered as arrows pointing left and right with a vertical bar separating them.
    row-resize         Indicates that the item/row can be resized vertically. Often rendered as arrows pointing up and down with a horizontal bar separating them.
    all-scroll         Indicates that the something can be scrolled in any direction. Often rendered as arrows pointing up, down, left, and right with a dot in the middle.
