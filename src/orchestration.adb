package body Orchestration is

   protected body Trigger_Instant is
      procedure Signal is
      begin
         Signalled := True;
      end Signal;

      entry Wait when Signalled is
      begin
         Signalled := False;
      end Wait;

   end Trigger_Instant;

end Orchestration;