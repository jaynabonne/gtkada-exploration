with Gtk.Handlers;
with Gtk.Menu_Item;
with Gtk.Button;

package Callback_Types is

   -- For GtkMenuItem signals
   package Menu_Item_Callbacks is new Gtk.Handlers.Callback
     (Gtk.Menu_Item.Gtk_Menu_Item_Record);

   -- For GtkButton signals
   package Button_Callbacks is new Gtk.Handlers.Callback
     (Gtk.Button.Gtk_Button_Record);

end Callback_Types;
