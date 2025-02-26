with Hcsr04;
with Orchestration;
with System_Configuration;
with Screen_Draw;

with Ada.Real_Time;

procedure Main is
   pragma Priority (System_Configuration.Main_Priority);
   --  Device : Hcsr04.Hcsr04_T := Hcsr04.Create (Mode => Hcsr04.Cyclic, -- Nous produirons une mesure cyclique (x par seconde)
   --                                             Cycle_Freq  => 1,      -- 1 mesure/trigger par seconde
   --                                             Trigger_Dur => 10);    -- La duree du trigger est de 10 microsecondes
begin
   --Orchestration.Trigger_Instant.Signal;
   -- Hcsr04.Echo_Interrupt_Handler.Handle_Interrupt;
   loop
      Screen_Draw.Display_Msg ("Distance: " & Hcsr04.Get_Data'Image & " cm");
      delay 1.0;
      --delay until Ada.Real_Time.Time_Last;
   end loop;
end Main;