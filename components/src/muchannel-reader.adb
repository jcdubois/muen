--
--  Copyright (C) 2013, 2014  Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2013, 2014  Adrian-Ken Rueegsegger <ken@codelabs.ch>
--
--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <http://www.gnu.org/licenses/>.
--

package body Muchannel.Reader
is

   --  Returns True if the epoch of the channel and the reader are out of sync.
   function Has_Epoch_Changed
     (Channel : Channel_Type;
      Reader  : Reader_Type)
      return Boolean;

   --  Returns True if the channel has valid dimensions.
   function Is_Valid
     (Protocol     : Header_Field_Type;
      Size         : Header_Field_Type;
      Elements     : Header_Field_Type;
      Channel_Size : Header_Field_Type)
      return Boolean;

   --  Synchronize reader with given channel.
   procedure Synchronize
     (Channel :     Channel_Type;
      Reader  : out Reader_Type;
      Result  : out Result_Type);

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
     (Channel : Channel_Type;
      Reader  : Reader_Type)
      return Boolean
   is
   begin
      return Reader.Epoch /= Channel.Header.Epoch;
   end Has_Epoch_Changed;

   -------------------------------------------------------------------------

   function Has_Pending_Data
     (Channel : Channel_Type;
      Reader  : Reader_Type)
      return Boolean
   is
   begin
      return Is_Active (Channel => Channel) and then
        Reader.RC < Channel.Header.WC and then
        not Has_Epoch_Changed (Channel => Channel,
                               Reader  => Reader);
   end Has_Pending_Data;

   -------------------------------------------------------------------------

   function Is_Valid
     (Protocol     : Header_Field_Type;
      Size         : Header_Field_Type;
      Elements     : Header_Field_Type;
      Channel_Size : Header_Field_Type)
      return Boolean
   is
   begin
      return Size * Elements = Channel_Size
        and Protocol = Reader.Protocol;
   end Is_Valid;

   -------------------------------------------------------------------------

   procedure Read
     (Channel :        Channel_Type;
      Reader  : in out Reader_Type;
      Element :    out Element_Type;
      Result  :    out Result_Type)
   is
      Position : Data_Range;
   begin
      if not Is_Active (Channel => Channel) then
         Result := Inactive;
      else
         if Reader.Epoch = Null_Epoch or else
           Has_Epoch_Changed (Channel => Channel,
                              Reader  => Reader)
         then
            Synchronize (Channel => Channel,
                         Reader  => Reader,
                         Result  => Result);
            if Result /= Success then
               return;
            end if;
         end if;

         if Reader.RC >= Channel.Header.WC then
            Result := No_Data;
         else
            Position := Data_Range (Reader.RC mod Reader.Elements);
            Element  := Channel.Data (Position);

            --  Check for element overwrite by writer.

            if Channel.Header.WSC > Reader.RC + Reader.Elements then
               Result    := Overrun_Detected;
               Reader.RC := Channel.Header.WC;
            else
               Result    := Success;
               Reader.RC := Reader.RC + 1;
            end if;
            if Has_Epoch_Changed (Channel => Channel,
                                  Reader  => Reader)
            then
               Result := Epoch_Changed;
            end if;
         end if;
      end if;
   end Read;

   -------------------------------------------------------------------------

   procedure Synchronize
     (Channel :     Channel_Type;
      Reader  : out Reader_Type;
      Result  : out Result_Type)
   is
   begin
      if not Is_Active (Channel => Channel) then
         Result := Inactive;
      else
         if Channel.Header.Transport = SHMStream_Marker and then
           Is_Valid (Protocol     => Channel.Header.Protocol,
                     Size         => Channel.Header.Size,
                     Elements     => Channel.Header.Elements,
                     Channel_Size => Header_Field_Type
                       (Elements * (Element_Type'Size / 8)))
         then
            Reader.Epoch    := Channel.Header.Epoch;
            Reader.Protocol := Channel.Header.Protocol;
            Reader.Size     := Channel.Header.Size;
            Reader.Elements := Channel.Header.Elements;
            Reader.RC       := Header_Field_Type (Data_Range'First);

            if Has_Epoch_Changed (Reader  => Reader,
                                  Channel => Channel)
            then
               Result := Epoch_Changed;
            else
               Result := Success;
            end if;
         else
            Result := Incompatible_Interface;
         end if;
      end if;
   end Synchronize;

end Muchannel.Reader;