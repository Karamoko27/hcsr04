with Hcsr04;
with System_Configuration;

with Ada.Real_Time;

procedure Main is
   pragma Priority (System_Configuration.Main_Priority);
   --  Device : Hcsr04.Hcsr04_T := Hcsr04.Create (Mode        => Hcsr04.Cyclic,
   --                                             Cycle_Freq  => 60.0,
   --                                             Trigger_Dur => 10);
begin
   loop
      delay until Ada.Real_Time.Time_Last;
   end loop;
end Main;