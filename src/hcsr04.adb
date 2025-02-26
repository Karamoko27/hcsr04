with Hcsr04;
with STM32.Device; use STM32.Device;
with STM32.GPIO; use STM32.GPIO;
with STM32.Timers; use STM32.Timers;
with STM32; use STM32;
with HAL; use HAL;
with System;
with Orchestration;


with Ada.Interrupts.Names;

package body Hcsr04 is

   protected type Data_T is
      procedure Set_Data (Value : Cms_T);
      function Get_Data return Cms_T;
   private
      Data_Value : Cms_T := 0;
   end Data_T;

   protected body Data_T is
      procedure Set_Data (Value : Cms_T) is
      begin
         Data_Value := Value;
      end Set_Data;
      function Get_Data return Cms_T is 
      begin
         return Data_Value;
      end Get_Data;
   end Data_T;

   Data : Data_T;

   function Get_Data return Cms_T is
      (Data.Get_Data);

   task body Trigger is
      Next_Release : Time;
      Period : constant Time_Span := Seconds (1);
      Counter : Cms_T := 0;
   begin
      loop
         Next_Release := Clock + Period;
         Counter := @ + 1;
         Data.Set_Data (Counter);
         delay until Next_Release;
      end loop;
   end Trigger;

   --  Trig_Pin : GPIO_Point renames PA5;

   --  Echo_Pin   : GPIO_Point renames PA6;
   --  Echo_Timer : Timer renames Timer_2;
   --  Echo_AF    : constant GPIO_Alternate_Function := GPIO_AF_TIM2_1;

   --  protected type Pulse_Width is
   --     procedure Set_Width (Width : UInt32);
   --     function Get_Width return UInt32;
   --  private
   --     Current_Width : UInt32 := 0;
   --  end Pulse_Width;

   --  protected body Pulse_Width is
   --     procedure Set_Width (Width : UInt32) is
   --     begin
   --        Current_Width := Width;
   --     end Set_Width;

   --     function Get_Width return UInt32 is
   --        (Current_Width);
   --  end Pulse_Width;

   --  Measured_Width : Pulse_Width;

   --  protected Echo_Interrupt_Handler is
   --     pragma Interrupt_Priority (System.Interrupt_Priority'First);
   --  private
   --     procedure Handle_Interrupt;
   --     pragma Attach_Handler (Handle_Interrupt,
   --        Ada.Interrupts.Names.TIM2_Interrupt); 
   --  end Echo_Interrupt_Handler;

   --  protected body Echo_Interrupt_Handler is
   --     procedure Handle_Interrupt is
   --        Rising_Count : UInt32;
   --        Falling_Count : UInt32;
   --     begin
   --        if Status (Echo_Timer, Timer_CC1_Indicated) then
   --           Rising_Count := Current_Capture_Value (Echo_Timer, Channel_1);
   --           Clear_Status (Echo_Timer, Timer_CC1_Indicated);
   --        end if;

   --        if Status (Echo_Timer, Timer_CC2_Indicated) then
   --           Falling_Count := Current_Capture_Value (Echo_Timer, Channel_2);
   --           Clear_Status (Echo_Timer, Timer_CC2_Indicated);

   --           if Falling_Count >= Rising_Count then
   --              Measured_Width.Set_Width (UInt32 (Falling_Count - Rising_Count));
   --           end if;
   --        end if;
   --     end Handle_Interrupt;
   --  end Echo_Interrupt_Handler;

   --  procedure Configure_Echo_Pin (This : GPIO_Point; Timer : STM32.Timers.Timer; AF : GPIO_Alternate_Function) is
   --  begin
   --     Enable_Clock (Echo_Pin);
   --     Configure_IO (Echo_Pin, 
   --        (Mode           => Mode_AF,
   --         AF             => AF,
   --         Resistors      => Floating,
   --         AF_Speed       => Speed_High,
   --         AF_Output_Type => Push_Pull));

   --     Enable_Clock (Echo_Timer);
   --     Configure (Echo_Timer, 
   --               Prescaler => 84,
   --               Period    => UInt32'Last);

   --     Configure_Channel_Input 
   --       (Echo_Timer,
   --        Channel   => Channel_1,
   --        Polarity  => Rising,
   --        Selection => Direct_TI,
   --        Prescaler => Div1,
   --        Filter    => 0);

   --     Configure_Channel_Input
   --       (Echo_Timer,
   --        Channel   => Channel_2,
   --        Polarity  => Falling,
   --        Selection => Direct_TI,
   --        Prescaler => Div1,
   --        Filter    => 0);

   --     Enable_Interrupt (Echo_Timer, Timer_CC1_Interrupt);
   --     Enable_Interrupt (Echo_Timer, Timer_CC2_Interrupt);

   --     Enable (Echo_Timer);
   --  end Configure_Echo_Pin;

   --  procedure Configure_Trigger_Pin (This : GPIO_Point) is
   --     Config : GPIO_Port_Configuration;
   --  begin
   --     Config := (Mode           => Mode_Out,
   --                Output_Type    => Push_Pull,
   --                Resistors      => Floating,
   --                Speed          => Speed_100MHz);
   --     This.Configure_IO (Config => Config);
   --  end Configure_Trigger_Pin;

   --  task body Trigger is
   --     Next_Release : Time;
   --     Period : constant Time_Span := Microseconds (50_000);
   --  begin
   --     Configure_Echo_Pin (Echo_Pin, Echo_Timer, Echo_AF);
   --     Configure_Trigger_Pin (Trig_Pin);
   --     loop
   --        Next_Release := Clock + Period;

   --        STM32.GPIO.Set (Trig_Pin);
   --        delay until Clock + Microseconds (10);
   --        STM32.GPIO.Clear (Trig_Pin);

   --        delay until Next_Release;
   --     end loop;
   --  end Trigger;

   --  -- Rajouter la task echo par Karamoko
   --  task body Echo is 
   --     Next_Release : Time;
   --     Period : constant Time_Span := Seconds (1);
   --     Echo_Bool : Boolean := False;
   --  begin
   --     -- Configure_Echo_Pin (Echo_Pin, Echo_Timer, Echo_AF);
   --     -- Configure_Trigger_Pin (Trig_Pin);
   --     loop
   --        Next_Release := Clock + Period;
   --        -- Echo_Bool := STM32.GPIO.Set (Echo_Pin); -- echo == 1
   --        --  if Echo_Bool then
   --        --     Orchestration.Trigger_Instant.Wait;
   --        --     Echo_Timer.Enable_Interrupt (Timer_CC1_Interrupt);
   --        --     Echo_Timer.Disable_Interrupt (Timer_CC2_Interrupt);
   --        --     if Echo_Bool /= STM32.GPIO.Set (Echo_Pin) then
   --        --        Echo_Timer.Enable_Interrupt (Timer_CC2_Interrupt);
   --        --        Echo_Timer.Disable_Interrupt (Timer_CC1_Interrupt);
   --        --        Orchestration.Trigger_Instant.Signal;
   --        --     end if;
   --        --  end if;
   --        delay until Next_Release;
   --     end loop;
   --  end Echo;


   --  --  function Get_Distance return Cms_T is
   --  --     Width : UInt32 := Measured_Width.Get_Width;
   --  --     Cms : UInt32 := (34_300 * Width) / 1_000_000; 
   --  --  begin
   --  --     return Cms_T (Cms);
   --  --  end Get_Distance;



   --  -- Rajout du body de la fonction Create par Karamoko
   --  --Probleme avec cyclic_duration que j'ai du mettre en Integer pour respecter Hcsr04_T CD à la place de fixed_t
   --  function Create (Mode        : Mode_T := Cyclic; 
   --                   Cycle_Freq  : Cyclic_Freq_T := 1.0; 
   --                   Trigger_Dur : Trigger_Duration_T := 10) return Hcsr04_T is
   --  New_Hcsr04 : Hcsr04_T;
   --  begin
   --     -- Initialisation des paramètres de New_Hcsr04
   --     New_Hcsr04.M  := Mode;
   --     New_Hcsr04.CF := Cycle_Freq;
   --     New_Hcsr04.TD := Trigger_Dur;

   --     -- Démarrage de la tâche Trigger
   --     return New_Hcsr04;
   --  end Create;

end Hcsr04;