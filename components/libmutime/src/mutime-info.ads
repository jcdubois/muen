--
--  Copyright (C) 2015  Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2015  Adrian-Ken Rueegsegger <ken@codelabs.ch>
--  All rights reserved.
--
--  Redistribution and use in source and binary forms, with or without
--  modification, are permitted provided that the following conditions are met:
--
--    * Redistributions of source code must retain the above copyright notice,
--      this list of conditions and the following disclaimer.
--
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
--  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
--  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
--  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
--  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
--  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
--  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
--  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
--  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
--  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
--  POSSIBILITY OF SUCH DAMAGE.
--

package Mutime.Info
with
   Abstract_State => (State with External => Async_Writers)
is

   subtype Timezone_Type is Integer_62 range
     -12 * 60 * 60 * 10 ** 6 .. 14 * 60 * 60 * 10 ** 6;

   --  TSC tick rate in Hz from 1 Mhz to 100 Ghz.
   subtype TSC_Tick_Rate_Hz_Type is
     Interfaces.Unsigned_64 range 1000000 .. 100000000000;

   type Time_Info_Type is record
      --  Time when TSC was zero
      TSC_Time_Base      : Timestamp_Type;
      --  TSC Ticks in Hz
      TSC_Tick_Rate_Hz   : TSC_Tick_Rate_Hz_Type;
      --  Timezone offset in microseconds
      Timezone_Microsecs : Timezone_Type;
   end record;

   --  Calculate current timestamp using the information stored in the time
   --  info record and the specified CPU ticks. The procedure returns the
   --  timestamp and the calculated correction to the time base in
   --  microseconds.
   procedure Get_Current_Time
     (Schedule_Ticks :     Integer_62;
      Correction     : out Integer_63;
      Timestamp      : out Timestamp_Type)
   with
      Global  => (Input => State),
      Depends => ((Correction, Timestamp) => (Schedule_Ticks, State));

private

   for Time_Info_Type use record
      TSC_Time_Base      at  0 range 0 .. 63;
      TSC_Tick_Rate_Hz   at  8 range 0 .. 63;
      Timezone_Microsecs at 16 range 0 .. 63;
   end record;

   procedure Get_Current_Time
     (TI             :     Time_Info_Type;
      Schedule_Ticks :     Integer_62;
      Correction     : out Integer_63;
      Timestamp      : out Timestamp_Type)
   with
      Depends => ((Correction, Timestamp) => (Schedule_Ticks, TI));

end Mutime.Info;
