with Ahven.Text_Runner;
with Ahven.Framework;

with Xml_Tests;

procedure Test_Runner is
   use Ahven.Framework;

   S : constant Test_Suite_Access := Create_Suite (Suite_Name => "SKP tests");
begin
   Add_Test (Suite => S.all,
             T     => new Xml_Tests.Testcase);

   Ahven.Text_Runner.Run (Suite => S);
   Release_Suite (T => S);
end Test_Runner;
