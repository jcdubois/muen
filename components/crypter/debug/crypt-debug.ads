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

package Crypt.Debug
is

   --  Output subject greeter.
   procedure Put_Greeter;

   --  Output processing message for given client ID.
   procedure Put_Process_Message (Client_ID : SK.Byte);

   --  Output hash data as hex string.
   procedure Put_Hash (Item : Crypt.Message_Type);

   --  Output given message and Word16 value.
   procedure Put_Word16
     (Message : String;
      Value   : SK.Word16);

   --  Output spurious interrupt message for given vector.
   procedure Put_Spurious (Vector : SK.Byte);

end Crypt.Debug;
