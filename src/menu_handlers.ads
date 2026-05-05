with Gtk.Menu_Item;

package Menu_Handlers is

   procedure On_Quit
     (Self : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class);

   procedure On_Open
     (Self : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class);

end Menu_Handlers;
