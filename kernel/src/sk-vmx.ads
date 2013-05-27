with Skp;

--# inherit
--#    Skp.Kernel,
--#    X86_64,
--#    SK.CPU,
--#    SK.CPU_Global,
--#    SK.Interrupts,
--#    SK.GDT,
--#    SK.Descriptors,
--#    SK.Constants,
--#    SK.Subjects,
--#    SK.Apic,
--#    SK.Locks;
package SK.VMX
--# own
--#    State;
--# initializes
--#    State;
is

   --  Enter VMX root operation.
   procedure Enable;
   --# global
   --#    in out X86_64.State;
   --# derives
   --#    X86_64.State from *;

   --  Clear VMCS with given address.
   procedure Clear (VMCS_Address : SK.Word64);
   --# global
   --#    in out X86_64.State;
   --# derives
   --#    X86_64.State from *, VMCS_Address;

   --  Load VMCS with given address.
   procedure Load (VMCS_Address : SK.Word64);
   --# global
   --#    in out X86_64.State;
   --# derives
   --#    X86_64.State from *, VMCS_Address;

   --  Run given subject.
   procedure Run (Subject_Id : Skp.Subject_Id_Type);
   --# global
   --#    in out Subjects.State;
   --#    in out Locks.State;
   --#    in out X86_64.State;
   --# derives
   --#    Subjects.State, Locks.State, X86_64.State from
   --#       *,
   --#       Subject_Id,
   --#       Subjects.State,
   --#       X86_64.State;

   --  Read value from specified field of the current, active VMCS. If the
   --  operation fails, CPU.Panic is called.
   procedure VMCS_Read
     (Field :     SK.Word16;
      Value : out SK.Word64);
   --# global
   --#    X86_64.State;
   --# derives
   --#    Value, X86_64.State from X86_64.State, Field;

   --  Write given value to the specified field of the current, active VMCS. If
   --  the operation fails, CPU.Panic is called.
   procedure VMCS_Write
     (Field : SK.Word16;
      Value : SK.Word64);
   --# global
   --#    in out X86_64.State;
   --# derives
   --#    X86_64.State from *, Field, Value;

   --  Setup control fields of the currently active VMCS.
   procedure VMCS_Setup_Control_Fields
     (IO_Bitmap_Address  : SK.Word64;
      MSR_Bitmap_Address : SK.Word64;
      Ctls_Exec_Pin      : SK.Word32;
      Ctls_Exec_Proc     : SK.Word32;
      Ctls_Exec_Proc2    : SK.Word32;
      Ctls_Exit          : SK.Word32;
      Ctls_Entry         : SK.Word32;
      CR0_Mask           : SK.Word64;
      CR4_Mask           : SK.Word64);
   --# global
   --#    in out X86_64.State;
   --# derives
   --#    X86_64.State from
   --#       *,
   --#       Ctls_Exec_Pin,
   --#       Ctls_Exec_Proc,
   --#       Ctls_Exec_Proc2,
   --#       Ctls_Exit,
   --#       Ctls_Entry,
   --#       IO_Bitmap_Address,
   --#       MSR_Bitmap_Address,
   --#       CR0_Mask,
   --#       CR4_Mask;

   --  Setup host fields of the currently active VMCS.
   procedure VMCS_Setup_Host_Fields;
   --# global
   --#    in     Interrupts.IDT_Pointer;
   --#    in     GDT.GDT_Pointer;
   --#    in     State;
   --#    in out X86_64.State;
   --# derives
   --#    X86_64.State from
   --#       *,
   --#       Interrupts.IDT_Pointer,
   --#       GDT.GDT_Pointer,
   --#       State;

   --  Setup guest fields of the currently active VMCS.
   procedure VMCS_Setup_Guest_Fields
     (PML4_Address : SK.Word64;
      EPT_Pointer  : SK.Word64;
      CR0_Value    : SK.Word64;
      CR4_Value    : SK.Word64;
      CS_Access    : SK.Word32);
   --# global
   --#    in out X86_64.State;
   --# derives
   --#    X86_64.State from
   --#       *,
   --#       PML4_Address,
   --#       EPT_Pointer,
   --#       CR0_Value,
   --#       CR4_Value,
   --#       CS_Access;

   --  Enable/Disable interrupt-window exiting depending on the given value.
   procedure VMCS_Set_Interrupt_Window (Value : Boolean);
   --# global
   --#    in out X86_64.State;
   --# derives
   --#    X86_64.State from *, Value;

end SK.VMX;
