with Gdk.Event;       use Gdk.Event;
with Gtk.Handlers;

with Gtk.Box;         use Gtk.Box;
with Gtk.Builder;     use Gtk.Builder;
with Gtk.Label;       use Gtk.Label;
with Gtk.Widget;      use Gtk.Widget;
with Gtk.Menu_Bar;    use Gtk.Menu_Bar;
with Gtk.Menu;        use Gtk.Menu;
with Gtk.Menu_Item;   use Gtk.Menu_Item;
with Gtk.Main;
with Gtk.Toolbar;    use Gtk.Toolbar;
with Gtk.Window;      use Gtk.Window;
with Glib.Error;      use Glib.Error;
with Glib; use Glib;

with Ada.Text_IO; use Ada.Text_IO;

with Callback_Types;
with Menu_Handlers;


procedure Gtk_Experiment is
  
   Builder : Gtk_Builder;     
   Error: aliased GError;
   Result : Guint;

   Win   : Gtk_Window;
   Box   : Gtk_Box;
   MenuBar  : Gtk_Menu_Bar;
   Toolbar : Gtk_Toolbar;
   QuitItem : Gtk_Menu_Item;

   Label : Gtk_Label;
   Label2 : Gtk_Label;

   function Delete_Event_Cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event)
      return Boolean;
   
   ---------------------
   -- Delete_Event_Cb --
   ---------------------

   function Delete_Event_Cb
     (Self  : access Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event)
      return Boolean
   is
      pragma Unreferenced (Self, Event);
   begin
      Gtk.Main.Main_Quit;
      return True;
   end Delete_Event_Cb;

begin
   --  Initialize GtkAda.
   Gtk.Main.Init;

   Builder := Gtk_Builder_New;
   Result := Add_From_File (Builder, "ui/main.ui", Error'Access);
   if Error /= null then
      Put_Line ("Failed to load UI file: " & Get_Message (Error));
      return;
   end if;

   --  Create a window with a size of 400x400
   Win := Gtk_Window (Get_Object (Builder, "main_window"));
   Box := Gtk_Box (Get_Object (Builder, "main_box"));
   MenuBar := Gtk_Menu_Bar (Get_Object (Builder, "main_menu"));
   
   Result := Add_From_File (Builder, "ui/toolbar.ui", Error'Access);
   if Error /= null then
      Put_Line ("Failed to load UI file: " & Get_Message (Error));
      return;
   end if;

   Toolbar := Gtk_Toolbar (Get_Object (Builder, "main_toolbar"));
   
   Pack_Start
     (Box,
      Toolbar,
      Expand  => False,
      Fill    => False,
      Padding => 0);

   Reorder_Child
     (Box,
      Toolbar,
      Position => 1);
   
   QuitItem := Gtk_Menu_Item (Get_Object (Builder, "quit_item"));
   Callback_Types.Menu_Item_Callbacks.Connect
     (QuitItem,
      "activate",
      Callback_Types.Menu_Item_Callbacks.To_Marshaller (Menu_Handlers.On_Quit'Access));
   
   Win.Set_Default_Size (400, 400);
  
   --  Add a label
   Gtk_New (Label, "Hello world.");
   Box.Add (Label);

   --  Add a label
   Gtk_New (Label2, "Goodnight moon.");
   Box.Add (Label2);

   -- Stop the Gtk process when closing the window
   Win.On_Delete_Event (Delete_Event_Cb'Unrestricted_Access);

   --  Show the window and present it
   Win.Show_All;
   Win.Present;

   --  Start the Gtk+ main loop
   Gtk.Main.Main;
end Gtk_Experiment;
