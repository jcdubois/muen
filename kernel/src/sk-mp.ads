--# inherit
--#    SK;
package SK.MP
--# own
--#    CPU_Online_Count;
--# initializes
--#    CPU_Online_Count;
is

   --  Increment counter of online CPUs.
   procedure Increment_CPU_Count;
   --# global
   --#    in out CPU_Online_Count;
   --# derives
   --#    CPU_Online_Count from *;

   --  Wait until all AP processors are online.
   procedure Wait_For_AP_Processors;
   --# derives ;

end SK.MP;
