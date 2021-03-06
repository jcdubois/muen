--
--  Copyright (C) 2013  Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2013  Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Skp;

with SK;

use type SK.Byte;

package Handler
with
   Initializes => Requesting_Subject
is

   --  Interrupt handler.
   procedure Handle_Interrupt (Vector : SK.Byte)
   with
      Global     => (Output => Requesting_Subject),
      Depends    => (Requesting_Subject => Vector),
      Export,
      Convention => C,
      Link_Name  => "dispatch_interrupt";

   Requesting_Subject : Skp.Subject_Id_Type := Skp.Subject_Id_Type'First
     with Atomic;

end Handler;
