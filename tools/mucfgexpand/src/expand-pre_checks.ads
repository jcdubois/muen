--
--  Copyright (C) 2014  Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2014  Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Muxml;

package Expand.Pre_Checks
is

   --  Register all pre-checks.
   procedure Register_All;

   --  Run registered pre-checks.
   procedure Run (Data : Muxml.XML_Data_Type);

   --  Return number of registered pre-checks.
   function Get_Count return Natural;

   --  Expander specific pre-checks.

   --  Check that tau0 is present in the scheduling plan.
   procedure Tau0_Presence_In_Scheduling (XML_Data : Muxml.XML_Data_Type);

   --  Check subject monitor references.
   procedure Subject_Monitor_References (XML_Data : Muxml.XML_Data_Type);

   --  Check subject channel references.
   procedure Subject_Channel_References (XML_Data : Muxml.XML_Data_Type);

   --  Check that each channel has exactly one reader and one writer.
   procedure Channel_Reader_Writer (XML_Data : Muxml.XML_Data_Type);

   --  Check that writer of a channel with hasEvent specifies an event ID.
   procedure Channel_Writer_Has_Event_ID (XML_Data : Muxml.XML_Data_Type);

   --  Check that reader of a channel with hasEvent modes async and ipi
   --  specifies a vector number.
   procedure Channel_Reader_Has_Event_Vector (XML_Data : Muxml.XML_Data_Type);

end Expand.Pre_Checks;