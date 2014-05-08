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

with Interfaces.C;

with Musinfo.Utils;

with C_Imports;

package body Interop_Tests
is

   use Ahven;
   use Musinfo;

   -------------------------------------------------------------------------

   procedure Initialize (T : in out Testcase)
   is
   begin
      T.Set_Name (Name => "Interoperability tests");
      T.Add_Test_Routine
        (Routine => Name_To_C'Access,
         Name    => "Name to C");
   end Initialize;

   -------------------------------------------------------------------------

   procedure Name_To_C
   is
      use type Interfaces.C.int;

      Ref_Str : constant String (Name_Index_Type) := (others => 'a');
   begin
      Assert (Condition => C_Imports.C_Assert_Name
              (Name => Utils.Create_Name (Str => Ref_Str)) = 1,
              Message   => "C name mismatch");
   end Name_To_C;

end Interop_Tests;
