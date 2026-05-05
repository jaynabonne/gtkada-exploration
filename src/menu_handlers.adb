with Gtk.Main;

package body Menu_Handlers is

   procedure On_Quit
     (Self : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class)
   is
   begin
      Gtk.Main.Main_Quit;
   end On_Quit;

   procedure On_Open
     (Self : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class)
   is
   begin
      -- Your open logic here
      null;
   end On_Open;

end Menu_Handlers;
