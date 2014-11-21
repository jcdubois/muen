--
--  Copyright (C) 2013, 2014  Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2013, 2014  Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

package body Muchannel.Readers
is

   --  Returns True if the epoch of the channel and the reader are out of sync.
   function Has_Epoch_Changed
     (Channel_Epoch : Header_Field_Type;
      Reader        : Reader_Type)
      return Boolean;

   --  Returns True if the channel has valid dimensions.
   function Is_Valid
     (Channel_Protocol : Header_Field_Type;
      Element_Size     : Header_Field_Type;
      Element_Count    : Header_Field_Type;
      Channel_Size     : Header_Field_Type)
      return Boolean;

   -------------------------------------------------------------------------

   procedure Drain
     (Channel :        Channel_Type;
      Reader  : in out Reader_Type)
   is
   begin
      Reader.RC := Channel.Header.WC;
   end Drain;

   -------------------------------------------------------------------------

   function Has_Epoch_Changed
     (Channel_Epoch : Header_Field_Type;
      Reader        : Reader_Type)
      return Boolean
   is
   begin
      return Reader.Epoch /= Channel_Epoch;
   end Has_Epoch_Changed;

   -------------------------------------------------------------------------

   procedure Has_Pending_Data
     (Channel :     Channel_Type;
      Reader  :     Reader_Type;
      Result  : out Boolean)
   is
      Channel_Epoch : constant Header_Field_Type := Channel.Header.Epoch;
      Write_Count   : constant Header_Field_Type := Channel.Header.WC;
   begin
      Result := Is_Active_Channel (Epoch => Channel_Epoch) and then
        Reader.RC < Write_Count and then
        not Has_Epoch_Changed
          (Channel_Epoch => Channel_Epoch,
           Reader        => Reader);
   end Has_Pending_Data;

   -------------------------------------------------------------------------

   function Is_Valid
     (Channel_Protocol : Header_Field_Type;
      Element_Size     : Header_Field_Type;
      Element_Count    : Header_Field_Type;
      Channel_Size     : Header_Field_Type)
      return Boolean
   is
   begin
      return Element_Size * Element_Count = Channel_Size
        and Channel_Protocol = Readers.Protocol;
   end Is_Valid;

   -------------------------------------------------------------------------

   procedure Read
     (Channel :        Channel_Type;
      Reader  : in out Reader_Type;
      Element :    out Element_Type;
      Result  :    out Result_Type)
   is
      Position      : Data_Range;
      Count         : Header_Field_Type;
      Transport     : Header_Field_Type;
      Channel_Epoch : Header_Field_Type := Channel.Header.Epoch;
   begin
      if not Is_Active_Channel (Epoch => Channel_Epoch) then
         Result := Inactive;
      else
         if Reader.Epoch = Null_Epoch or else
           Has_Epoch_Changed (Channel_Epoch => Channel_Epoch,
                              Reader        => Reader)
         then
            Transport       := Channel.Header.Transport;
            Reader.Protocol := Channel.Header.Protocol;
            Reader.Size     := Channel.Header.Size;
            Reader.Elements := Channel.Header.Elements;

            if Transport = SHMStream_Marker and then
              Is_Valid (Channel_Protocol => Reader.Protocol,
                        Element_Size     => Reader.Size,
                        Element_Count    => Reader.Elements,
                        Channel_Size     => Header_Field_Type
                          (Elements * (Element_Type'Size / 8)))
            then
               Reader.Epoch := Channel.Header.Epoch;
               Reader.RC    := Header_Field_Type (Data_Range'First);

               Channel_Epoch := Channel.Header.Epoch;
               if Has_Epoch_Changed (Channel_Epoch => Channel_Epoch,
                                     Reader        => Reader)
               then
                  Result := Epoch_Changed;
               else
                  Result := Success;
               end if;
            else
               Reader := Null_Reader;
               Result := Incompatible_Interface;
            end if;

            if Result /= Success then
               return;
            end if;
         end if;

         Count := Channel.Header.WC;
         if Reader.RC >= Count then
            Result := No_Data;
         else
            Position := Data_Range (Reader.RC mod Reader.Elements);
            Element  := Channel.Data (Position);

            --  Check for element overwrite by writer.

            Count := Channel.Header.WSC;
            if Count > Reader.RC + Reader.Elements then
               Result    := Overrun_Detected;
               Reader.RC := Channel.Header.WC;
            else
               Result    := Success;
               Reader.RC := Reader.RC + 1;
            end if;
            Channel_Epoch := Channel.Header.Epoch;
            if Has_Epoch_Changed (Channel_Epoch => Channel_Epoch,
                                  Reader        => Reader)
            then
               Result := Epoch_Changed;
            end if;
         end if;
      end if;
   end Read;

end Muchannel.Readers;
