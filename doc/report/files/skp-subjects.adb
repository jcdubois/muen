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

package body Skp.Subjects
is

   type Trap_Table_Type is array (Trap_Range) of Trap_Entry_Type;

   Null_Trap_Table : constant Trap_Table_Type := Trap_Table_Type'
     (others => Null_Trap);

   type Event_Table_Type is array (Event_Range) of Event_Entry_Type;

   Null_Event_Table : constant Event_Table_Type := Event_Table_Type'
     (others => Null_Event);

   type Subject_Spec_Type is record
      CPU_Id             : Skp.CPU_Range;
      Profile            : Profile_Kind;
      PML4_Address       : SK.Word64;
      EPT_Pointer        : SK.Word64;
      VMCS_Address       : SK.Word64;
      IO_Bitmap_Address  : SK.Word64;
      MSR_Bitmap_Address : SK.Word64;
      Stack_Address      : SK.Word64;
      Entry_Point        : SK.Word64;
      CR0_Value          : SK.Word64;
      CR0_Mask           : SK.Word64;
      CR4_Value          : SK.Word64;
      CR4_Mask           : SK.Word64;
      CS_Access          : SK.Word32;
      Exception_Bitmap   : SK.Word32;
      VMX_Controls       : VMX_Controls_Type;
      Trap_Table         : Trap_Table_Type;
      Event_Table        : Event_Table_Type;
   end record;

   type Subject_Spec_Array is array (Skp.Subject_Id_Type) of Subject_Spec_Type;

   Subject_Specs : constant Subject_Spec_Array := Subject_Spec_Array'(
__subjects__);

   -------------------------------------------------------------------------

   function Get_CPU_Id (Subject_Id : Skp.Subject_Id_Type) return Skp.CPU_Range
   is
   begin
      --# accept Warning, 444, "CPU_Id is in CPU_Range (obviously)";
      --# assume Subject_Specs (Subject_Id).CPU_Id in Skp.CPU_Range;
      --# end accept;
      return Subject_Specs (Subject_Id).CPU_Id;
   end Get_CPU_Id;

   -------------------------------------------------------------------------

   function Get_CR0 (Subject_Id : Skp.Subject_Id_Type) return SK.Word64
   is
   begin
      --# accept Warning, 444, "CR0_Value is Word64 (obviously)";
      --# assume Subject_Specs (Subject_Id).CR0_Value in SK.Word64;
      --# end accept;
      return Subject_Specs (Subject_Id).CR0_Value;
   end Get_CR0;

   -------------------------------------------------------------------------

   function Get_CR0_Mask (Subject_Id : Skp.Subject_Id_Type) return SK.Word64
   is
   begin
      --# accept Warning, 444, "CR0_Mask is Word64 (obviously)";
      --# assume Subject_Specs (Subject_Id).CR0_Mask in SK.Word64;
      --# end accept;
      return Subject_Specs (Subject_Id).CR0_Mask;
   end Get_CR0_Mask;

   -------------------------------------------------------------------------

   function Get_CR4 (Subject_Id : Skp.Subject_Id_Type) return SK.Word64
   is
   begin
      --# accept Warning, 444, "CR4_Value is Word64 (obviously)";
      --# assume Subject_Specs (Subject_Id).CR4_Value in SK.Word64;
      --# end accept;
      return Subject_Specs (Subject_Id).CR4_Value;
   end Get_CR4;

   -------------------------------------------------------------------------

   function Get_CR4_Mask (Subject_Id : Skp.Subject_Id_Type) return SK.Word64
   is
   begin
      --# accept Warning, 444, "CR4_Mask is Word64 (obviously)";
      --# assume Subject_Specs (Subject_Id).CR4_Mask in SK.Word64;
      --# end accept;
      return Subject_Specs (Subject_Id).CR4_Mask;
   end Get_CR4_Mask;

   -------------------------------------------------------------------------

   function Get_CS_Access (Subject_Id : Skp.Subject_Id_Type) return SK.Word32
   is
   begin
      --# accept Warning, 444, "CS_Access is Word32 (obviously)";
      --# assume Subject_Specs (Subject_Id).CS_Access in SK.Word32;
      --# end accept;
      return Subject_Specs (Subject_Id).CS_Access;
   end Get_CS_Access;

   -------------------------------------------------------------------------

   function Get_Entry_Point
     (Subject_Id : Skp.Subject_Id_Type)
      return SK.Word64
   is
   begin
      --# accept Warning, 444, "Entry_Point is Word64 (obviously)";
      --# assume Subject_Specs (Subject_Id).Entry_Point in SK.Word64;
      --# end accept;
      return Subject_Specs (Subject_Id).Entry_Point;
   end Get_Entry_Point;

   -------------------------------------------------------------------------

   function Get_EPT_Pointer
     (Subject_Id : Skp.Subject_Id_Type)
      return SK.Word64
   is
   begin
      --# accept Warning, 444, "EPT_Pointer is Word64 (obviously)";
      --# assume Subject_Specs (Subject_Id).EPT_Pointer in SK.Word64;
      --# end accept;
      return Subject_Specs (Subject_Id).EPT_Pointer;
   end Get_EPT_Pointer;

   -------------------------------------------------------------------------

   function Get_Event
     (Subject_Id : Skp.Subject_Id_Type;
      Event_Nr   : Event_Range)
      return Event_Entry_Type
   is
   begin
      return Subject_Specs (Subject_Id).Event_Table (Event_Nr);
   end Get_Event;

   -------------------------------------------------------------------------

   function Get_Exception_Bitmap
     (Subject_Id : Skp.Subject_Id_Type)
      return SK.Word32
   is
   begin
      --# accept Warning, 444, "Exception_Bitmap is Word32 (obviously)";
      --# assume Subject_Specs (Subject_Id).Exception_Bitmap in SK.Word32;
      --# end accept;
      return Subject_Specs (Subject_Id).Exception_Bitmap;
   end Get_Exception_Bitmap;

   -------------------------------------------------------------------------

   function Get_IO_Bitmap_Address
     (Subject_Id : Skp.Subject_Id_Type)
      return SK.Word64
   is
   begin
      --# accept Warning, 444, "IO_Bitmap_Address is Word64 (obviously)";
      --# assume Subject_Specs (Subject_Id).IO_Bitmap_Address in SK.Word64;
      --# end accept;
      return Subject_Specs (Subject_Id).IO_Bitmap_Address;
   end Get_IO_Bitmap_Address;

   -------------------------------------------------------------------------

   function Get_MSR_Bitmap_Address
     (Subject_Id : Skp.Subject_Id_Type)
      return SK.Word64
   is
   begin
      --# accept Warning, 444, "MSR_Bitmap_Address is Word64 (obviously)";
      --# assume Subject_Specs (Subject_Id).MSR_Bitmap_Address in SK.Word64;
      --# end accept;
      return Subject_Specs (Subject_Id).MSR_Bitmap_Address;
   end Get_MSR_Bitmap_Address;

   -------------------------------------------------------------------------

   function Get_PML4_Address
     (Subject_Id : Skp.Subject_Id_Type)
      return SK.Word64
   is
   begin
      --# accept Warning, 444, "PML4_Address is Word64 (obviously)";
      --# assume Subject_Specs (Subject_Id).PML4_Address in SK.Word64;
      --# end accept;
      return Subject_Specs (Subject_Id).PML4_Address;
   end Get_PML4_Address;

   -------------------------------------------------------------------------

   function Get_Profile (Subject_Id : Skp.Subject_Id_Type) return Profile_Kind
   is
   begin
      --# accept Warning, 444, "Profile is Profile_Kind (obviously)";
      --# assume Subject_Specs (Subject_Id).Profile in Profile_Kind;
      --# end accept;
      return Subject_Specs (Subject_Id).Profile;
   end Get_Profile;

   -------------------------------------------------------------------------

   function Get_Stack_Address
     (Subject_Id : Skp.Subject_Id_Type)
      return SK.Word64
   is
   begin
      --# accept Warning, 444, "Stack_Address is Word64 (obviously)";
      --# assume Subject_Specs (Subject_Id).Stack_Address in SK.Word64;
      --# end accept;
      return Subject_Specs (Subject_Id).Stack_Address;
   end Get_Stack_Address;

   -------------------------------------------------------------------------

   function Get_Trap
     (Subject_Id : Skp.Subject_Id_Type;
      Trap_Nr    : Trap_Range)
      return Trap_Entry_Type
   is
   begin
      return Subject_Specs (Subject_Id).Trap_Table (Trap_Nr);
   end Get_Trap;

   -------------------------------------------------------------------------

   function Get_VMCS_Address
     (Subject_Id : Skp.Subject_Id_Type)
      return SK.Word64
   is
   begin
      --# accept Warning, 444, "VMCS_Address is Word64 (obviously)";
      --# assume Subject_Specs (Subject_Id).VMCS_Address in SK.Word64;
      --# end accept;
      return Subject_Specs (Subject_Id).VMCS_Address;
   end Get_VMCS_Address;

   -------------------------------------------------------------------------

   function Get_VMX_Controls
     (Subject_Id : Skp.Subject_Id_Type)
      return VMX_Controls_Type
   is
   begin
      return Subject_Specs (Subject_Id).VMX_Controls;
   end Get_VMX_Controls;

end Skp.Subjects;
