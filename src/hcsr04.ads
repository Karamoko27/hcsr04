with System_Configuration;
with Ada.Real_Time;  use Ada.Real_Time;

package Hcsr04 is

   type Cms_T is range 0 .. 1000;

   --function Get_Distance return Cms_T;
   subtype Cyclic_Duration_T is Integer range 16667 .. 100000;
   type Hcsr04_T is private;
   type Hcsr04_Ptr_T is access all Hcsr04_T;
   type Mode_T is (Cyclic, On_Demand);

   D : constant := 2.0 ** (-31);
   type Fixed_T is delta D range 0.0 .. 1_000_000.0;
   subtype Cyclic_Freq_T is Fixed_T range 1.0 .. 60.0;
   subtype Trigger_Duration_T is Integer range 10 .. 20;

   --  function Create (Mode        : Mode_T             := Cyclic; 
   --                   Cycle_Freq  : Cyclic_Freq_T      := 1.0; 
   --                   Trigger_Dur : Trigger_Duration_T := 10) return Hcsr04_T;

   

   function Get_Data return Cms_T;

private

   type Hcsr04_T is record
      M  : Mode_T;
      CF : Cyclic_Freq_T := 1.0;
      TD : Trigger_Duration_T := 10;
   end record;

   task Trigger with
     Storage_Size => 1 * 128,
     Priority     => System_Configuration.Trigger_Priority;
   
   --  task Echo with
   --    Storage_Size => 1 * 256,
   --    Priority     => System_Configuration.Echo_Priority;

end Hcsr04;