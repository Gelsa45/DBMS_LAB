--create table employe(eid number primary key,ename varchar2(30),eadress varchar2(50),esalary number);
create or replace package information as 
    procedure add_emp(peid in number,pname in varchar2,padress in varchar2,psalary in number);
    procedure delete_emp(deid in number);
    procedure list_all;
    function get_sal(fid in number)return number;
end information;

create or replace package body information as
    procedure add_emp(peid in number,pname in varchar2,padress in varchar2,psalary in number) as
        begin
        insert into employe(eid,ename,eadress,esalary) values(peid,pname,padress,psalary) ;
        commit;
        dbms_output.put_line('Added ');
        end add_emp;
        
    procedure delete_emp(deid in number) as 
        begin
            delete from employe where eid=deid;
            commit;
            dbms_output.put_line('deleted ');
     end delete_emp;
    procedure list_all as
     cursor listall is
        select eid,ename,eadress,esalary from employe;
     veid number;
     vename varchar2(30);
     veadress varchar2(50);
     vesalary number;
    begin
        open listall ;
        loop
        fetch  listall into veid, vename , veadress , vesalary ;
        exit when listall%notfound;
        dbms_output.put_line(' id: '|| veid||' name: '||vename||' address: '||veadress||' salary= '||vesalary);
        
        end loop;
      --close listall;
end list_all;

     function get_sal(fid in number) return number as
      vsal number;
      begin 
        select esalary into vsal from employe where eid=fid;
       return vsal;
      end get_sal;
end information;
/
set serveroutput on;
declare
sal number;
did number:=&did;
sids number:=&sids;
begin
information.add_emp(100,'gel','thrissur',45656);
--information.add_emp(101,'ges','ekm',456);

information.delete_emp(did);

information.list_all;


sal:=information.get_sal(sids);
dbms_output.put_line('salary is '|| sal);
end;
/
select * from employe;
