with System; use System;

package System_Configuration is

   Main_Priority : constant Priority := Priority'First;
   Trigger_Priority : constant Priority := Main_Priority + 1;
   Echo_Priority : constant Priority := Trigger_Priority + 1;

end system_configuration;