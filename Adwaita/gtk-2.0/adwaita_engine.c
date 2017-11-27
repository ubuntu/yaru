/* Adwaita - a GTK+ engine
 *
 * Copyright (C) 2012 Red Hat, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * Authors: Cosimo Cecchi <cosimoc@gnome.org>
 */

#include <gmodule.h>
#include <glib.h>
#include <gtk/gtk.h>

#ifdef GDK_WINDOWING_X11
#include <gdk/gdkx.h>
#endif

/***************************************
 * Register & Initialize Drawing Style *
 ***************************************/
#define ADWAITA_TYPE_STYLE              (adwaita_style_get_type ())
#define ADWAITA_STYLE(object)           (G_TYPE_CHECK_INSTANCE_CAST ((object), ADWAITA_TYPE_STYLE, AdwaitaStyle))
#define ADWAITA_STYLE_CLASS(klass)      (G_TYPE_CHECK_CLASS_CAST ((klass), ADWAITA_TYPE_STYLE, AdwaitaStyleClass))
#define ADWAITA_IS_STYLE(object)        (G_TYPE_CHECK_INSTANCE_TYPE ((object), ADWAITA_TYPE_STYLE))
#define ADWAITA_IS_STYLE_CLASS(klass)   (G_TYPE_CHECK_CLASS_TYPE ((klass), ADWAITA_TYPE_STYLE))
#define ADWAITA_STYLE_GET_CLASS(obj)    (G_TYPE_INSTANCE_GET_CLASS ((obj), ADWAITA_TYPE_STYLE, AdwaitaStyleClass))

typedef struct
{
  GtkStyle parent_instance;
} AdwaitaStyle;

typedef struct
{
  GtkStyleClass parent_class;
} AdwaitaStyleClass;

G_DEFINE_DYNAMIC_TYPE (AdwaitaStyle, adwaita_style, GTK_TYPE_STYLE)

static void
do_toplevel_hack (GtkWidget   *widget,
                  const gchar *widget_name)
{
  gboolean tried_hack;

  tried_hack = GPOINTER_TO_INT (g_object_get_data (G_OBJECT (widget), "adwaita-toplevel-hack"));

  if (!tried_hack)
    {
      g_object_set_data (G_OBJECT (widget),
                         "adwaita-toplevel-hack", GINT_TO_POINTER (1));
      gtk_widget_set_name (widget, widget_name);
    }
}

static gboolean
wm_is_fallback (void)
{
#ifdef GDK_WINDOWING_X11
  const gchar *name;
  name = gdk_x11_screen_get_window_manager_name (gdk_screen_get_default ());
  return g_strcmp0 (name, "GNOME Shell") != 0;
#else
  return TRUE;
#endif
}

static cairo_t *
drawable_to_cairo (GdkDrawable  *window,
                   GdkRectangle *area)
{
  cairo_t *cr;

  g_return_val_if_fail (window != NULL, NULL);

  cr = (cairo_t*) gdk_cairo_create (window);
  cairo_set_line_width (cr, 1.0);
  cairo_set_line_cap (cr, CAIRO_LINE_CAP_SQUARE);
  cairo_set_line_join (cr, CAIRO_LINE_JOIN_MITER);

  if (area)
    {
      cairo_rectangle (cr, area->x, area->y, area->width, area->height);
      cairo_clip_preserve (cr);
      cairo_new_path (cr);
    }

  return cr;
}

static void
adwaita_draw_box (GtkStyle * style,
                  GdkWindow * window,
                  GtkStateType state_type,
                  GtkShadowType shadow_type,
                  GdkRectangle * area,
                  GtkWidget * widget,
                  const gchar * detail,
                  gint x,
                  gint y,
                  gint width,
                  gint height)
{
  if (GTK_IS_MENU (widget) &&
      g_strcmp0 (detail, "menu") == 0 &&
      wm_is_fallback ())
    {
      cairo_t *cr = drawable_to_cairo (window, area);
      cairo_set_source_rgb (cr, 0.34, 0.34, 0.33);
      cairo_rectangle (cr, x, y, width, height);
      cairo_stroke (cr);

      cairo_destroy (cr);
    }
  else
    {
      GTK_STYLE_CLASS (adwaita_style_parent_class)->draw_box (style, window, state_type, shadow_type,
                                                              area, widget, detail,
                                                              x, y, width, height);
    }
}

void
adwaita_draw_flat_box (GtkStyle      *style,
                       GdkWindow     *window,
                       GtkStateType   state_type,
                       GtkShadowType  shadow_type,
                       GdkRectangle  *area,
                       GtkWidget     *widget,
                       const gchar   *detail,
                       gint           x,
                       gint	      y,
                       gint	      width,
                       gint	      height)
{
  const gchar *app_name;

  GTK_STYLE_CLASS (adwaita_style_parent_class)->draw_flat_box (style, window, state_type, shadow_type,
                                                               area, widget, detail,
                                                               x, y, width, height);

  /* HACK: this is totally awful, but I don't see a better way to "tag" the OO.o hierarchy */
  if (!GTK_IS_WINDOW (widget) ||
      (gtk_window_get_window_type (GTK_WINDOW (widget)) != GTK_WINDOW_TOPLEVEL))
    return;

  app_name = g_get_application_name ();
  if (g_str_has_prefix (app_name, "OpenOffice.org"))
    do_toplevel_hack (widget, "openoffice-toplevel");
  else if (g_str_has_prefix (app_name, "LibreOffice"))
    do_toplevel_hack (widget, "libreoffice-toplevel");
}

static void
adwaita_style_init (AdwaitaStyle *style)
{
}

static void
adwaita_style_class_init (AdwaitaStyleClass * klass)
{
  GtkStyleClass *style_class = GTK_STYLE_CLASS (klass);

  style_class->draw_box = adwaita_draw_box;
  style_class->draw_flat_box = adwaita_draw_flat_box;
}

static void
adwaita_style_class_finalize (AdwaitaStyleClass * klass)
{
}

/**********************************
 * Register & Initialize RC Style *
 **********************************/
#define ADWAITA_TYPE_RC_STYLE              (adwaita_rc_style_get_type ())
#define ADWAITA_RC_STYLE(object)           (G_TYPE_CHECK_INSTANCE_CAST ((object), ADWAITA_TYPE_RC_STYLE, AdwaitaRcStyle))
#define ADWAITA_RC_STYLE_CLASS(klass)      (G_TYPE_CHECK_CLASS_CAST ((klass), ADWAITA_TYPE_RC_STYLE, AdwaitaRcStyleClass))
#define ADWAITA_IS_RC_STYLE(object)        (G_TYPE_CHECK_INSTANCE_TYPE ((object), ADWAITA_TYPE_RC_STYLE))
#define ADWAITA_IS_RC_STYLE_CLASS(klass)   (G_TYPE_CHECK_CLASS_TYPE ((klass), ADWAITA_TYPE_RC_STYLE))
#define ADWAITA_RC_STYLE_GET_CLASS(obj)    (G_TYPE_INSTANCE_GET_CLASS ((obj), ADWAITA_TYPE_RC_STYLE, AdwaitaRcStyleClass))

typedef struct
{
  GtkRcStyle parent_instance;
} AdwaitaRcStyle;

typedef struct
{
  GtkRcStyleClass parent_class;
} AdwaitaRcStyleClass;

G_DEFINE_DYNAMIC_TYPE (AdwaitaRcStyle, adwaita_rc_style, GTK_TYPE_RC_STYLE)

static GtkStyle *
adwaita_rc_style_create_style (GtkRcStyle *rc_style)
{
  return g_object_new (ADWAITA_TYPE_STYLE, NULL);
}

static void
adwaita_rc_style_init (AdwaitaRcStyle *rc_style)
{
}

static void
adwaita_rc_style_class_init (AdwaitaRcStyleClass * klass)
{
  GtkRcStyleClass *rc_class = GTK_RC_STYLE_CLASS (klass);

  rc_class->create_style = adwaita_rc_style_create_style;
}

static void
adwaita_rc_style_class_finalize (AdwaitaRcStyleClass * klass)
{
}

/****************
 * Engine Hooks *
 ****************/
void
theme_init (GTypeModule * module)
{
  adwaita_rc_style_register_type (module);
  adwaita_style_register_type (module);
}

void
theme_exit (void)
{
}

GtkRcStyle *
theme_create_rc_style (void)
{
  return g_object_new (ADWAITA_TYPE_RC_STYLE, NULL);
}
