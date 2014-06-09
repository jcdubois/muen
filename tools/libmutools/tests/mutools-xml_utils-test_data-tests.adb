--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Mutools.XML_Utils.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;

package body Mutools.XML_Utils.Test_Data.Tests is


--  begin read only
   procedure Test_1_Add_Memory_Region (Gnattest_T : in out Test);
   procedure Test_Add_Memory_Region_6142bd (Gnattest_T : in out Test) renames Test_1_Add_Memory_Region;
--  id:2.2/6142bd7e03979890/Add_Memory_Region/1/0/
   procedure Test_1_Add_Memory_Region (Gnattest_T : in out Test) is
   --  mutools-xml_utils.ads:27:4:Add_Memory_Region
--  end read only

      pragma Unreferenced (Gnattest_T);

      Filename : constant String := "obj/memory.xml";
      Policy   : Muxml.XML_Data_Type;
   begin
      Muxml.Parse (Data => Policy,
                   Kind => Muxml.Format_Src,
                   File => "data/test_policy.xml");
      Add_Memory_Region
        (Policy      => Policy,
         Name        => "test",
         Address     => "16#9000_1000#",
         Size        => "16#3000#",
         Caching     => "UC",
         Alignment   => "16#1000#",
         Memory_Type => "");
      Add_Memory_Region
        (Policy      => Policy,
         Name        => "noaddress",
         Address     => "",
         Size        => "16#8000#",
         Caching     => "WC",
         Alignment   => "16#0020_0000#",
         Memory_Type => "");

      Muxml.Write (Data => Policy,
                   Kind => Muxml.Format_Src,
                   File => Filename);

      Assert (Condition => Test_Utils.Equal_Files
              (Filename1 => Filename,
               Filename2 => "data/memory.xml"),
              Message   => "Policy mismatch");

      Ada.Directories.Delete_File (Name => Filename);
--  begin read only
   end Test_1_Add_Memory_Region;
--  end read only


--  begin read only
   procedure Test_2_Add_Memory_Region (Gnattest_T : in out Test);
   procedure Test_Add_Memory_Region_741476 (Gnattest_T : in out Test) renames Test_2_Add_Memory_Region;
--  id:2.2/741476e4715f4faa/Add_Memory_Region/0/0/
   procedure Test_2_Add_Memory_Region (Gnattest_T : in out Test) is
   --  mutools-xml_utils.ads:38:4:Add_Memory_Region
--  end read only

      pragma Unreferenced (Gnattest_T);

      Filename : constant String := "obj/memory_with_file.xml";
      Policy   : Muxml.XML_Data_Type;
   begin
      Muxml.Parse (Data => Policy,
                   Kind => Muxml.Format_Src,
                   File => "data/test_policy.xml");
      Add_Memory_Region
        (Policy      => Policy,
         Name        => "test",
         Address     => "16#2000#",
         Size        => "16#4000#",
         Caching     => "WB",
         Alignment   => "16#1000#",
         Memory_Type => "",
         File_Name   => "testfile",
         File_Offset => "16#1000#");

      Muxml.Write (Data => Policy,
                   Kind => Muxml.Format_Src,
                   File => Filename);

      Assert (Condition => Test_Utils.Equal_Files
              (Filename1 => Filename,
               Filename2 => "data/memory_with_file.xml"),
              Message   => "Policy mismatch");

      Ada.Directories.Delete_File (Name => Filename);
--  begin read only
   end Test_2_Add_Memory_Region;
--  end read only


--  begin read only
   procedure Test_Create_Memory_Node (Gnattest_T : in out Test);
   procedure Test_Create_Memory_Node_4c3d32 (Gnattest_T : in out Test) renames Test_Create_Memory_Node;
--  id:2.2/4c3d32628a5ec36a/Create_Memory_Node/1/0/
   procedure Test_Create_Memory_Node (Gnattest_T : in out Test) is
   --  mutools-xml_utils.ads:50:4:Create_Memory_Node
--  end read only

      pragma Unreferenced (Gnattest_T);

      Impl : DOM.Core.DOM_Implementation;
      Data : Muxml.XML_Data_Type;
      Node : DOM.Core.Node;
   begin
      Data.Doc := DOM.Core.Create_Document (Implementation => Impl);

      Node := Create_Memory_Node (Policy      => Data,
                                  Name        => "region1",
                                  Address     => "16#1000#",
                                  Size        => "16#0200_1000#",
                                  Caching     => "WB",
                                  Alignment   => "16#1000#",
                                  Memory_Type => "subject");

      Assert (Condition => DOM.Core.Elements.Get_Attribute
              (Elem => Node,
               Name => "name") = "region1",
              Message   => "Name mismatch");
      Assert (Condition => DOM.Core.Elements.Get_Attribute
              (Elem => Node,
               Name => "physicalAddress") = "16#1000#",
              Message   => "Address mismatch");
      Assert (Condition => DOM.Core.Elements.Get_Attribute
              (Elem => Node,
               Name => "size") = "16#0200_1000#",
              Message   => "Size mismatch");
      Assert (Condition => DOM.Core.Elements.Get_Attribute
              (Elem => Node,
               Name => "caching") = "WB",
              Message   => "Caching mismatch");
      Assert (Condition => DOM.Core.Elements.Get_Attribute
              (Elem => Node,
               Name => "alignment") = "16#1000#",
              Message   => "Alignment mismatch");
      Assert (Condition => DOM.Core.Elements.Get_Attribute
              (Elem => Node,
               Name => "type") = "subject",
              Message   => "Memory type mismatch");

      Node := Create_Memory_Node (Policy      => Data,
                                  Name        => "region2",
                                  Address     => "",
                                  Size        => "16#1000#",
                                  Caching     => "UC",
                                  Alignment   => "",
                                  Memory_Type => "");
      Assert (Condition => DOM.Core.Elements.Get_Attribute
              (Elem => Node,
               Name => "physicalAddress") = "",
              Message   => "Address set");
      Assert (Condition => DOM.Core.Elements.Get_Attribute
              (Elem => Node,
               Name => "alignment") = "",
              Message   => "Alignment set");
      Assert (Condition => DOM.Core.Elements.Get_Attribute
              (Elem => Node,
               Name => "type") = "",
              Message   => "Memory type set");


--  begin read only
   end Test_Create_Memory_Node;
--  end read only


--  begin read only
   procedure Test_Has_Managed_DEBUGCTL (Gnattest_T : in out Test);
   procedure Test_Has_Managed_DEBUGCTL_07c840 (Gnattest_T : in out Test) renames Test_Has_Managed_DEBUGCTL;
--  id:2.2/07c840ea4cf93188/Has_Managed_DEBUGCTL/1/0/
   procedure Test_Has_Managed_DEBUGCTL (Gnattest_T : in out Test) is
   --  mutools-xml_utils.ads:62:4:Has_Managed_DEBUGCTL
--  end read only

      pragma Unreferenced (Gnattest_T);

      Policy : Muxml.XML_Data_Type;
      Ctrls  : DOM.Core.Node;
   begin
      Muxml.Parse (Data => Policy,
                   Kind => Muxml.Format_Src,
                   File => "data/test_policy.xml");

      Ctrls := Muxml.Utils.Get_Element
        (Doc   => Policy.Doc,
         XPath => "/system/subjects/subject/vcpu/vmx/controls");

      Assert (Condition => not Has_Managed_DEBUGCTL (Controls => Ctrls),
              Message   => "DEBUGCTL is managed");

      DOM.Core.Nodes.Set_Node_Value
        (N     => DOM.Core.Nodes.First_Child
           (N => Muxml.Utils.Get_Element
                (Doc   => Ctrls,
                 XPath => "entry/LoadDebugControls")),
         Value => "1");
      DOM.Core.Nodes.Set_Node_Value
        (N     => DOM.Core.Nodes.First_Child
           (N => Muxml.Utils.Get_Element
                (Doc   => Ctrls,
                 XPath => "exit/SaveDebugControls")),
         Value => "1");
      Assert (Condition => Has_Managed_DEBUGCTL (Controls => Ctrls),
              Message   => "DEBUGCTL not managed");
--  begin read only
   end Test_Has_Managed_DEBUGCTL;
--  end read only


--  begin read only
   procedure Test_Has_Managed_PERFGLOBALCTRL (Gnattest_T : in out Test);
   procedure Test_Has_Managed_PERFGLOBALCTRL_811a8a (Gnattest_T : in out Test) renames Test_Has_Managed_PERFGLOBALCTRL;
--  id:2.2/811a8a093040ed89/Has_Managed_PERFGLOBALCTRL/1/0/
   procedure Test_Has_Managed_PERFGLOBALCTRL (Gnattest_T : in out Test) is
   --  mutools-xml_utils.ads:66:4:Has_Managed_PERFGLOBALCTRL
--  end read only

      pragma Unreferenced (Gnattest_T);

      Policy : Muxml.XML_Data_Type;
      Ctrls  : DOM.Core.Node;
   begin
      Muxml.Parse (Data => Policy,
                   Kind => Muxml.Format_Src,
                   File => "data/test_policy.xml");

      Ctrls := Muxml.Utils.Get_Element
        (Doc   => Policy.Doc,
         XPath => "/system/subjects/subject/vcpu/vmx/controls");

      Assert (Condition => not Has_Managed_PERFGLOBALCTRL (Controls => Ctrls),
              Message   => "PERFGLOBALCTL is managed");

      DOM.Core.Nodes.Set_Node_Value
        (N     => DOM.Core.Nodes.First_Child
           (N => Muxml.Utils.Get_Element
                (Doc   => Ctrls,
                 XPath => "entry/LoadIA32PERFGLOBALCTRL")),
         Value => "1");
      Assert (Condition => Has_Managed_PERFGLOBALCTRL (Controls => Ctrls),
              Message   => "DEBUGCTL not managed");
--  begin read only
   end Test_Has_Managed_PERFGLOBALCTRL;
--  end read only

end Mutools.XML_Utils.Test_Data.Tests;
