--
--  Copyright (C) 2016  Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2016  Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Ada.Strings.Unbounded;

package Merge.Utils
is

   type String_Array is array (Positive range <>)
     of Ada.Strings.Unbounded.Unbounded_String;

   No_Strings : constant String_Array;

   --  Append specified string to given string array.
   function "&"
     (Arr : String_Array;
      Str : String)
      return String_Array;

   --  Splits the given string into an array of strings using the specified
   --  separator as delimiter.
   function Tokenize
     (Str       : String;
      Separator : Character := ':')
      return String_Array;

   --  Searches the specified directories and returns the full path to the
   --  file with given name. An exception is raised if none of the specified
   --  directories contains such a file.
   function Lookup_File
     (Filename    : String;
      Directories : String_Array)
      return String;

   File_Not_Found : exception;

private

   No_Strings : constant String_Array (1 .. 0) := (others => <>);

end Merge.Utils;
