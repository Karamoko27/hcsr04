
with Ada.Real_Time;  use Ada.Real_Time;
with System_Configuration;
package Orchestration is

   protected Trigger_Instant
     with Priority => System_Configuration.Main_Priority
   is
      procedure Signal;
      entry Wait;
   private
      Signalled    : Boolean := False;
   end Trigger_Instant;

end Orchestration;