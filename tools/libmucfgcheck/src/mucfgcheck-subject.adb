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

with DOM.Core.Nodes;
with DOM.Core.Elements;

with McKae.XML.XPath.XIA;

with Mulog;
with Muxml.Utils;

package body Mucfgcheck.Subject
is

   use McKae.XML.XPath.XIA;

   -------------------------------------------------------------------------

   procedure CPU_ID (XML_Data : Muxml.XML_Data_Type)
   is
      CPU_Count : constant Positive
        := Positive'Value
          (Muxml.Utils.Get_Attribute
             (Doc   => XML_Data.Doc,
              XPath => "/system/platform/processor",
              Name  => "logicalCpus"));
      Last_Id   : constant Natural := CPU_Count - 1;
      Nodes     : constant DOM.Core.Node_List
        := XPath_Query (N     => XML_Data.Doc,
                        XPath => "/system/subjects/subject");
   begin
      Check_Attribute (Nodes     => Nodes,
                       Node_Type => "subject",
                       Attr      => "cpu",
                       Name_Attr => "name",
                       Test      => Less_Or_Equal'Access,
                       Right     => Interfaces.Unsigned_64 (Last_Id),
                       Error_Msg => "not in valid range 0 .." & Last_Id'Img);
   end CPU_ID;

   -------------------------------------------------------------------------

   procedure Name_Uniqueness (XML_Data : Muxml.XML_Data_Type)
   is
      Subjects : constant DOM.Core.Node_List
        := XPath_Query (N     => XML_Data.Doc,
                        XPath => "/system/subjects/subject");

      --  Check that names of Left and Right differ.
      procedure Check_Name_Inequality (Left, Right : DOM.Core.Node);

      ----------------------------------------------------------------------

      procedure Check_Name_Inequality (Left, Right : DOM.Core.Node)
      is
         Left_Id   : constant String := DOM.Core.Elements.Get_Attribute
           (Elem => Left,
            Name => "id");
         Left_Name : constant String := DOM.Core.Elements.Get_Attribute
           (Elem => Left,
            Name => "name");
         Right_Id   : constant String := DOM.Core.Elements.Get_Attribute
           (Elem => Right,
            Name => "id");
         Right_Name : constant String := DOM.Core.Elements.Get_Attribute
           (Elem => Right,
            Name => "name");
      begin
         if Left_Name = Right_Name then
            raise Validation_Error with "Subjects with id " & Left_Id & " and "
              & Right_Id & " have identical name '" & Left_Name & "'";
         end if;
      end Check_Name_Inequality;
   begin
      Mulog.Log (Msg => "Checking uniqueness of" & DOM.Core.Nodes.Length
                 (List => Subjects)'Img & " subject name(s)");

      Compare_All (Nodes      => Subjects,
                   Comparator => Check_Name_Inequality'Access);
   end Name_Uniqueness;

end Mucfgcheck.Subject;