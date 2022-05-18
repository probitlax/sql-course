# sql-course


![Alt text](ConnectToDBWithoutTNS.PNG?raw=true "ConnectToDBWithoutTNS.PNG")

------------------------------------------------------------
# session 1. introduction

Oracle Database 
- Oracle Server 9i, 11g, 12c
- Oracle Client
- Oracle XE

Oracle Tools:
- SQL PLUS
- SQL Developer
- Net Manager
- TNS File 
- ..


Third Party Application
- PL/SQL Developer
- Toad
- Navicat
- ..

Database Archetecture:
- commit and rollback
- transaction
- redo log files
- backup
- ...

Entity Relationship Model:
- Algebra

Database Objects:
part one
- Schema
- Tablespace
- Table
- Column
- Data Type (Number(2,2) ,Varchar2(4000) ,Clob ,Blob, Date, Timestamp(6)) Data type
- constraint
- primary key
- foreign key
- Index
part two
- View 
- Materialized view
- Synonym
- Trigger
- Function
- Procedure
- package
- Job
- Directory
- DBLink


SQL Language:
- Delarative programming
- Procedural language
- Imperative programming

Naming Convesion:
- 30 characters
- Objects'name by default are Uppercase (unless '')
- Commands are not Case Sensitive


Type of commands:
DDL:  
- create 
- drop
- truncate


DML:  
- delete
- update
- insert into values
- insert into select

DCL: 
- Grant
- Revoke

Simple query:
- Select (Alias as , rowid)
- Select distinct
- From(Alias)
- (=,!=,<>,<,>) Where
- Order by
- And
- (or)
- In
- Like
- between
- Is null
- Is not null
- Nvl(col1,col2)
- Nvl2(col1,col2,col3)
- Decode (col1, a,b , c,d , e)
- case col1 when a then 'b' when 'c' then  'd' else 'e' end
- To_char
- To_date


Joins:
- Left join
- Right join
- Full outer join


Set query:
- UNION 
-  EXCEPT
- INTERSECT
 

Aggregation query:
- Group by
- Having
- Max
- Min
- Count
- Count distinct
- Sum
- Start with
- connect by
- level

Subquery:
- correlated subquery in Select part
- correlated subquery in Where clause
- subquery in Ffrom part 
- with as





------------------------------------------------------------
# session 2. select-from-where-and-or-date

### select
select * 
from TBL_DEPARTMENT ;

###  table alias 
select dep.* 
from TBL_DEPARTMENT dep;

###  choose columns
select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep;

###  column alias
select dep.dep_id DEPARTMENT_ID, 
         dep.dep_parent_id as DEPARTMENT_parent_ID,
         dep.dep_name as "DepartmentName",
         'Hellooo!' COMMENT_
from TBL_DEPARTMENT dep;


###  rownum
select rownum , dep.*  
from TBL_DEPARTMENT dep;

###  rowid
select dep.* , rowid 
from TBL_DEPARTMENT dep;

###  order
select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
order by dep.dep_id desc;

select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
order by 1 ;

select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
order by dep.dep_id desc , dep.dep_name asc;



###  distinct
select  distinct dep.dep_name , dep.dep_code
from TBL_DEPARTMENT dep ;


###  where (=, !=,>,<,<=,>=)
select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
where dep.dep_id = 1
order by dep.dep_id desc;

select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
where dep.dep_name = 'Amir'
order by dep.dep_id desc;

select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
where dep.dep_id between  1 and 2
order by dep.dep_id desc;

###  where in
select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
where dep.dep_id in ( 1 , 2 , 3)
and   dep.dep_id not in ( 2 , 3)
order by dep.dep_id desc;


###  where like
select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
where dep.dep_name like '%Amir%';

select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
where dep.dep_name like '%A__r%';

###  and
select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
where dep.dep_id = 1
and    dep.dep_parent_id = 2
order by dep.dep_id desc;


###  or ()
select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
where   dep.dep_id < 100
and   (  dep.dep_id = 1  or  dep.dep_parent_id = 2 )
order by dep.dep_id desc;


###  null 
select let.let_id,
         let.let_final_reg_date 
from TBL_LETTER let
where let.let_final_reg_date is not null;

--sysdate , calendar , to_char()
select sysdate ,
         to_char (sysdate , 'yyyy/mm/dd hh24:mi:ss') col1, 
         to_char (sysdate , 'MON DAY yyyy - hh:mi PM') col2,
         to_char (sysdate , 'yyyy/mm/dd hh24:mi:ss', 'nls_calendar=''Persian''') col3
from dual;

###  date condition
select let.let_id,
         let.let_final_reg_date ,
         to_char ( let.let_final_reg_date , 'yyyy/mm/dd hh24:mi:ss', 'nls_calendar=''Persian''')  as "let_final_reg_date_persian",
         to_char ( sysdate - 1 , 'yyyy/mm/dd hh24:mi:ss', 'nls_calendar=''Persian''') as "24hoursAgo"
from TBL_LETTER let
where let.let_final_reg_date is not null
and     let.let_final_reg_date > sysdate - 1 ;

select let.let_id , 
         to_char (  let.let_record_date  ,'yyyy/mm/dd hh24:mi','nls_calendar=''Persian''')
from TBL_LETTER let
where ( let.let_sender_per_id = 1
            or
            let.let_registrar_per_id = 1
             )
and  let.let_record_date  >=  to_date ( '&FromDate'  ,'yyyy/mm/dd','nls_calendar=''Persian''')   
and  let.let_record_date <=  to_date ( '&ToDate'  ,'yyyy/mm/dd','nls_calendar=''Persian''') + 1 
and  to_char( let.let_record_date,'hh24') not in ('08' , '09' , '16') ;


###  interval
select let.let_id,
         let.let_final_reg_date ,
         to_char ( let.let_final_reg_date , 'yyyy/mm/dd hh24:mi:ss', 'nls_calendar=''Persian''')  as "let_final_reg_date_persian",
         to_char ( sysdate - interval '1'  hour , 'yyyy/mm/dd hh24:mi:ss', 'nls_calendar=''Persian''') as "1hourAgo"
from TBL_LETTER let
where let.let_final_reg_date is not null
and     let.let_final_reg_date > sysdate - interval '1'  hour;


###  to_date()
select let.let_id,
         let.let_final_reg_date ,
         to_char ( let.let_final_reg_date , 'yyyy/mm/dd hh24:mi:ss', 'nls_calendar=''Persian''')  as "let_final_reg_date_persian",
         to_char ( sysdate - interval '1'  hour , 'yyyy/mm/dd hh24:mi:ss', 'nls_calendar=''Persian''') as "1hourAgo"
from TBL_LETTER let
where let.let_final_reg_date is not null
and     let.let_final_reg_date > to_date ('2015/01/01' , 'yyyy/mm/dd');

select let.let_id,
         let.let_final_reg_date ,
         to_char ( let.let_final_reg_date , 'yyyy/mm/dd hh24:mi:ss', 'nls_calendar=''Persian''')  as "let_final_reg_date_persian",
         to_char ( sysdate - interval '1'  hour , 'yyyy/mm/dd hh24:mi:ss', 'nls_calendar=''Persian''') as "1hourAgo"
from TBL_LETTER let
where let.let_final_reg_date is not null
and let.let_final_reg_date between to_date('2005/01/01' , 'yyyy/mm/dd') and to_date('2015/01/01' , 'yyyy/mm/dd') ;



###  nvl (if x is null then y)
select let.let_id,
         let.let_fi
         nvl( to_char ( let.let_final_reg_date , 'yyyy/mm/dd hh24:mi:ss', 'nls_calendar=''Persian''')  , 'TEMPORARY') LETTER_REGISTERATION
from TBL_LETTER let;

###  nvl2 (if x is not? null then y else z)
select let.let_id,
         nvl2( to_char ( let.let_final_reg_date , 'yyyy/mm/dd hh24:mi:ss', 'nls_calendar=''Persian''')  ,'FIANL' ,'TEMPORARY') LETTER_REGISTERATION
from TBL_LETTER let;

###  decode
select let.let_type
        decode (let.let_type,
                'O' , 'Output' ,
                'I' , 'Input' ,
                'E' , 'External' ,
                'S' , 'Self',
                'Not Specified'
                ) let_type_name2
from TBL_LETTER let
where let.let_final_reg_date is not null;

###  case
select let.let_type,
       case 
          when let.let_type='O' then 'Output'
          when let.let_type='I' then 'Input'
          when let.let_type='E' then 'External'
          when let.let_type='S' then 'Self'
        end let_type_name1
from TBL_LETTER let
where let.let_final_reg_date is not null;




------------------------------------------------------------
# session 2. subQuery




###  select subquery (one column)
select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name,
		 (select 'x' from dual) column1
from TBL_DEPARTMENT dep;

###  where subquery (one column)
select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
where dep.dep_id  in (select 1 from dual);

select let.let_id
from TBL_LETTER let
where let.let_registrar_dep_id  in (select dep.dep_id 
                                                        from TBL_DEPARTMENT dep
                                                        where dep.dep_name like 'Amir');


###  where subquery (two column)
select dep.dep_id , 
         dep.dep_parent_id,
         dep.dep_name
from TBL_DEPARTMENT dep
where (dep.dep_id , dep.dep_parent_id) in (select 1,2 from dual);






###  select (CorrelatedSubQuery from foreign table) 
select *
from TBL_DEPARTMENT dep;

select *
from TBL_LETTER let;

Select  dep.dep_name,
        (select count(let.let_id)  
        from   TBL_LETTER let  
        where  dep.dep_id = let.let_sender_per_id
        ) cnt
from TBL_DEPARTMENT dep
order by cnt desc;

###  select (CorrelatedSubQuery) 
select *
from TBL_DEPARTMENT dep
where dep.dep_id = 1115513 ;

select  dep1.dep_name
from TBL_DEPARTMENT dep1
where dep1.dep_id = 2 ;

select dep.dep_id ,
       dep.dep_name,
       dep.dep_parent_id,
       (select dep1.dep_name
        from TBL_DEPARTMENT dep1
        where dep1.dep_id = dep.dep_parent_id) dep_parent_name
from TBL_DEPARTMENT dep ;

###  where (CorrelatedSubQuery) 
select let.let_id,
       ( select p.per_first_name||' '||p.per_last_name from TBL_PERSONS p where p.per_id=let.let_sender_per_id) person_name,
       ( select dep.dep_name from TBL_DEPARTMENT dep where dep.dep_id=let.let_sender_dep_id) department_name     
from TBL_LETTER let
where let.let_sender_dep_id in (select dlv1.dlv_sender_dep_id
                               from TBL_DELIVER dlv1
                               where dlv1.dlv_let_id=let.let_id )
and let.let_sender_per_id in (select dlv2.dlv_sender_per_id
                              from TBL_DELIVER dlv2
                              where dlv2.dlv_let_id=let.let_id  );                                                     

###  where (CorrelatedSubQuery) 
select let.let_id,
       ( select p.per_first_name||' '||p.per_last_name from TBL_PERSONS p where p.per_id=let.let_sender_per_id) person_name,
       ( select dep.dep_name from TBL_DEPARTMENT dep where dep.dep_id=let.let_sender_dep_id) department_name     
from TBL_LETTER let
where (let.let_sender_dep_id,let.let_sender_per_id ) in (select dlv1.dlv_sender_dep_id,dlv1.dlv_sender_per_id
													   from TBL_DELIVER dlv1
													   where dlv1.dlv_let_id=let.let_id ); 



###  temp table
select tbl1.org_name ,
         tbl1.rn
from (select dep.dep_name || ' Organization' org_name ,
                   rownum rn
          from TBL_DEPARTMENT dep
          where dep.dep_name like '%%'
          order by dep.dep_name ) tbl1
where tbl1.rn between 1 and 10 ;
                                    

------------------------------------------------------------
# session 3. not-in-any-all


###  not in (null)
select count(*) 
from TBL_LETTER let

select count(*) 
from TBL_DELIVER dlv

###  wrong
select count(*) 
from TBL_LETTER let
where let.let_id not in ( select dlv.dlv_let_id 
                                    from TBL_DELIVER dlv );

###  not in (handle null)
select count(*) 
from TBL_LETTER let
where let.let_id not in ( select dlv.dlv_let_id 
                                    from TBL_DELIVER dlv
                                    where dlv.dlv_let_id is not null );
###  exists                             
select count(*) 
from TBL_LETTER let
where not exists ( select dlv.dlv_let_id 
                           from TBL_DELIVER dlv
                           where  dlv.dlv_let_id = let.let_id );      
						   
						   

						   
###  in 					   
select table1.idc  idc
from ( select 1 idc from dual
          union
          select 2 idc from dual
          union
          select 3 idc from dual ) table1
where table1.idc in (select table2.idc
                                      from ( select 1 idc from dual
                                                union
                                                select 2 idc from dual
                                                ) table2
                                       ) ;						   
						   
###  any                             						   
select table1.idc  idc
from ( select 1 idc from dual
          union
          select 2 idc from dual
          union
          select 3 idc from dual ) table1
where table1.idc > ANY (select table2.idc
                                      from ( select 1 idc from dual
                                                union
                                                select 2 idc from dual
                                                ) table2
                                       ) ;

 ###  1: false                                     
- compare 1 > 1 --> false
- compare 1 > 2 --> false
 
 ###  2: true
- compare 2 > 1 --> true
- compare 2 > 2 --> false
 
 ###  3: true
- compare 3 > 1 --> true
- compare 3 > 2 --> true



###  all
select table1.idc  idc
from ( select 1 idc from dual
          union
          select 2 idc from dual
          union
          select 3 idc from dual ) table1
where table1.idc > ALL (select table2.idc
                                      from ( select 1 idc from dual
                                                union
                                                select 2 idc from dual
                                                ) table2
                                       ) ;


 ###  1:  false                                    
- compare 1 > 1 --> false
- compare 1 > 2 --> false
 
 ###  2:  false
- compare 2 > 1 --> true
- compare 2 > 2 --> false
 
 ###  3: true
- compare 3 > 1 --> true
- compare 3 > 2 --> true


------------------------------------------------------------
# session 4. .Join


###  select table1
select * 
from TBL_LETTER let;

###  select table2
select *
from TBL_LETTER_RECEIVER lrc;

###  inner join
select let.let_id ,
        let.let_sender_dep_id , 
        lrc.lrc_dep_id
from TBL_LETTER let,
       TBL_LETTER_RECEIVER lrc
where let.let_id = lrc.lrc_let_id ;

select let.let_id ,
        let.let_sender_dep_id , 
        lrc.lrc_dep_id
from TBL_LETTER let inner join TBL_LETTER_RECEIVER lrc on ( let.let_id = lrc.lrc_let_id ) ;

###  left join , right join
- List of all letters whether having receivers or not
- the side we place the + can be null, i.e. the other side have to be listed completely. 

select let.let_id ,
        let.let_sender_dep_id , 
        lrc.lrc_dep_id
from TBL_LETTER let,
       TBL_LETTER_RECEIVER lrc
where let.let_id = lrc.lrc_let_id (+)
and     lrc.lrc_dep_id is null ;

select let.let_id ,
        let.let_sender_dep_id , 
        lrc.lrc_dep_id
from TBL_LETTER let left join TBL_LETTER_RECEIVER lrc on ( let.let_id = lrc.lrc_let_id ) 
and  lrc.lrc_let_id is null ;

###  full outer join
select let.let_id ,
        let.let_sender_dep_id , 
        lrc.lrc_dep_id
from TBL_LETTER let full outer join TBL_LETTER_RECEIVER lrc on ( let.let_id = lrc.lrc_let_id ) 
and  let.let_id = lrc.lrc_let_id ;



------------------------------------------------------------
# session 5. aggregation-group-having-distinct-decode-case

### count
select count (dlv.dlv_let_id) as "count",
         max   (dlv.dlv_let_id) as "max",
         min    (dlv.dlv_let_id) as "min",
         sum   (dlv.dlv_let_id) as "sum",
         avg    (dlv.dlv_let_id) as "avg"
from TBL_DELIVER dlv;

###  distinct
select distinct dlv.dlv_let_id
from TBL_DELIVER dlv;


### group by
select decode (let.let_type,
                'O' , 'Output' ,
                'I' , 'Input' ,
                'E' , 'External' ,
                'S' , 'Self',
                'Not Specified'
                ) let_type_name2,  
       count(*) COUNT_let_type 
from TBL_LETTER let
where let.let_final_reg_date is not null
group by let.let_type;

###  group by
select dlv.dlv_let_id ,
        count(*) COUNT_DLV,
        max(dlv.dlv_date) MAX_dlv_date,
        min(dlv.dlv_date) MIN_dlv_date,
        --sum()
        --avg
from TBL_DELIVER dlv
group by dlv.dlv_let_id
having count(*)> 1;


### group by day
select to_char (let.let_final_reg_date, 'yyyy/mm/dd'),
       count (let.let_id)
from TBL_LETTER let
group by to_char (let.let_final_reg_date, 'yyyy/mm/dd');

### group by hour
select to_char (let.let_final_reg_date, 'yyyy/mm/dd hh24'),
       count (let.let_id)
from TBL_LETTER let
group by to_char (let.let_final_reg_date, 'yyyy/mm/dd hh24')
order by to_char (let.let_final_reg_date, 'yyyy/mm/dd hh24') desc;

###  max day
select  *
from ( select to_char (let.let_final_reg_date, 'yyyy/mm/dd') let_final_reg_date_group ,
             count (let.let_id)  group_count
      from TBL_LETTER let
      where let.let_final_reg_date is not null
      group by to_char (let.let_final_reg_date, 'yyyy/mm/dd')
      )tbl
where tbl.group_count = ( select  max (group_count)
                          from ( select to_char (let.let_final_reg_date, 'yyyy/mm/dd') let_final_reg_date_group ,
                                       count (let.let_id)  group_count
                                from TBL_LETTER let
                                where let.let_final_reg_date is not null
                                group by to_char (let.let_final_reg_date, 'yyyy/mm/dd')
                                )tbl
                        ) ;




-----------------------------------------------------------
# session 6. set-union-unionall-minus-intersect


### union all, union, intersect, minus 
select let.let_id     ,
       to_nchar (let.let_comment) comment1 /*VARCHAR2(4000)*/,
       'LETTER'  COMMENT_SORCE
from TBL_LETTER let
union all 
select act.act_let_id ,
       act.act_comment comment1 /*NVARCHAR2(1000)*/ ,
       'ACTION'  COMMENT_SORCE
from TBL_ACTION act
union all
select dlv.dlv_let_id ,
       dlv.dlv_comment comment1 /*NVARCHAR2(1000)*/ ,
       'DELIVER'  COMMENT_SORCE
from TBL_DELIVER dlv
union all
select 0,
       to_nchar('Amirhossein') comment1,
       'UNKNOWN'  COMMENT_SORCE
from dual;

###  dual
select sysdate from dual ; 




------------------------------------------------------------
# session 7. hierarchial-connectby-startwith-prior-siblings-level-root-leaf

###  first parent
select dep.dep_id ,
       dep.dep_parent_id,
       dep.dep_name
from TBL_DEPARTMENT dep
where dep.dep_id = 1204948 ;

###  self join (root parent is null)
select ch_dep.dep_id ,
       ch_dep.dep_name,
       pa_dep.dep_parent_id,
       pa_dep.dep_name
from TBL_DEPARTMENT ch_dep,
     TBL_DEPARTMENT pa_dep
where ch_dep.dep_parent_id = pa_dep.dep_id ;

###  childs
select dep.dep_id ,
       dep.dep_name, 
       level
from TBL_DEPARTMENT dep
start with dep.dep_id = 1204948
connect by prior dep.dep_id = dep.dep_parent_id 
order by level;

###  parents
select dep.dep_id ,
       dep.dep_name, 
       level
from TBL_DEPARTMENT dep
start with dep.dep_id = 1123358
connect by prior dep.dep_parent_id = dep.dep_id 
order by level;

###  sys_connect_by_path
select dep.dep_id ,
       dep.dep_name, 
       level,
       sys_connect_by_path(dep.dep_id , '\')
from TBL_DEPARTMENT dep
start with dep.dep_id = 1204948
connect by prior dep.dep_id = dep.dep_parent_id 
order by level;

###  siblings
select dep.dep_id ,
       dep.dep_name, 
       level,
       sys_connect_by_path(dep.dep_id , '\')
from TBL_DEPARTMENT dep
start with dep.dep_id = 1204948
connect by prior dep.dep_id = dep.dep_parent_id 
order siblings by dep.dep_id;

###  lpad
select a1.fld_id, 
         a1.fld_name,
         a1.fld_parent_id,
         level,
         sys_connect_by_path(a1.fld_name, ' \ ' ),
         lpad(a1.fld_name,  (level)*10 , '_')
from TBL_folder a1
start with a1.fld_name='test'
connect by prior a1.fld_id=a1.fld_parent_id;

###  where level
select a1.fld_id, 
         a1.fld_name,
         a1.fld_parent_id,
         level,
         sys_connect_by_path(a1.fld_name, ' \ ' ),
         lpad(a1.fld_name,  (level)*10 , '_')
from TBL_folder a1
where level>=2 and level<=3
###  where level in (1,2)
###  where level <=  2
start with a1.fld_name='f1'
connect by prior a1.fld_id=a1.fld_parent_id;



###  Connect_by_root
select dep.dep_id ,
       dep.dep_name, 
       dep.dep_parent_id,
       connect_by_root dep.dep_id Root,
       level
from TBL_DEPARTMENT dep
start with dep.dep_id = 1204948
connect by prior dep.dep_id = dep.dep_parent_id 
order by level;



###  WHERE (Harvest nodes)
select dep.dep_id ,
       dep.dep_name, 
       dep.dep_parent_id,
       connect_by_root dep.dep_id Root,
       level
from TBL_DEPARTMENT dep
where dep.dep_name like '%dep%'
start with dep.dep_id = 1204948 
connect by prior dep.dep_id = dep.dep_parent_id;


###  AND (Harvest stems i.e. a node and all its sub node)
select dep.dep_id ,
       dep.dep_name, 
       dep.dep_parent_id,
       connect_by_root dep.dep_id Root,
       level
from TBL_DEPARTMENT dep
start with dep.dep_id = 1204948 
connect by prior dep.dep_id = dep.dep_parent_id
and dep.dep_name like '%dep%'




- The "where" and "and" before the "start with" harvest all the nodes that does not meet the conditions: 
At first we create a temp table "select .. from .. where .." and then 'choose the start nodes and then traverse.

select *
from TBL_FOLDER t 
where ( t.fld_dep_id = 11117147
            and t.fld_code < 1000 /*before start*/
          )
Start with t.fld_parent_id is null
connect by prior t.fld_id = t.fld_parent_id;


- There is no "where" after "start with" and there is just "and". The "and" after start with harvest the "start node" and it's all sub nodes.  At first we choose the start nodes to traverse by applying the conditions and then traverse.

select *
from TBL_FOLDER t 
Start with ( t.fld_parent_id is null 
                 and  t.fld_dep_id = 11117147
                 and t.fld_code < 1000 /*after start*/
                )
connect by prior t.fld_id = t.fld_parent_id;




------------------------------------------------------------
# session 8. ascii-String


select 'Amirhossein works hard!' main_str,
       upper('Amirhossein works hard!') upper_str,
       lower('Amirhossein works hard!') loer_str,
       initcap('Amirhossein works hard!') initcap_str,
       instr ('Amirhossein works hard!' , 'works') instr_s,
       substr('Amirhossein works hard!',1,4) substr_s1,
       substr('Amirhossein works hard!',-5) substr_s2,
       replace('Amirhossein works hard!', 'works' , 'does not work') replace_str
from dual;

select asciistr('امیرحسین فرمد') asciistr_s,
       unistr('\00C7\00E3\00ED\00D1\00CD\00D3\00ED\00E4') unistr_s
from dual;



------------------------------------------------------------
# session 9. GenerateData


### DBMS_RANDOM.string('Setting',Length) 

-   Generate 20 random String with length of 10 and mix mixed case alpha characters:

select DBMS_RANDOM.string('x',10) from dual connect by level <= 20;

-   Generate 20 random String with length of 10 and lowercase alpha characters:

select DBMS_RANDOM.string('u',10) from dual connect by level <= 20;

-  Generate 20 random String with length of 10 and cotains just a,b, characters:

select randomstring('abc', 10) res from dual connect by level <= 20;




### DBMS_RANDOM.VALUE
-  Generate random 20 random value with 38 digits of precision in (0 , 1):

SELECT DBMS_RANDOM.VALUE FROM DUAL CONNECT BY LEVEL < 20 ; 

- Generate random 20 random value in (0 , 100):

SELECT TRUNC(DBMS_RANDOM.VALUE(0, 100)) FROM DUAL CONNECT BY LEVEL < 20 ;



- To generate more rows, use a WITH clause and materialize the results as a global temporary table, then use that to create a cartesian product. You can control the number of rows returned using ROWNUM:

WITH data AS (
  SELECT /*+ MATERIALIZE */ level AS id
  FROM   dual
  CONNECT BY level <= 10000
)
SELECT rownum AS id
FROM   data, data, data
WHERE  rownum <= 1000000;


### DBMS_RANDOM.VALUE for DATE
- Generate random 20 random date in(2010-01-01 , 2012-01-01):

SELECT TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2010-01-01','J') ,TO_CHAR(DATE '2012-01-01','J') ) ),'J' ) FROM DUAL CONNECT BY LEVEL < 20 ;
SELECT TRUNC(SYSDATE + DBMS_RANDOM.value(0,366)) FROM DUAL CONNECT BY LEVEL < 20 ;

- By doing the correct divisions, we can add random numbers of hours, seconds or minutes to a date:

SET SERVEROUTPUT ON
DECLARE
  l_hours_in_day NUMBER := 24;
  l_mins_in_day  NUMBER := 24*60;
  l_secs_in_day  NUMBER := 24*60*60;
BEGIN
  FOR i IN 1 .. 5 LOOP
    DBMS_OUTPUT.put_line('hours= ' || (TRUNC(SYSDATE) + (TRUNC(DBMS_RANDOM.value(0,1000))/l_hours_in_day)));
  END LOOP;
  FOR i IN 1 .. 5 LOOP
    DBMS_OUTPUT.put_line('mins = ' || (TRUNC(SYSDATE) + (TRUNC(DBMS_RANDOM.value(0,1000))/l_mins_in_day)));
  END LOOP;
  FOR i IN 1 .. 5 LOOP
    DBMS_OUTPUT.put_line('secs = ' || (TRUNC(SYSDATE) + (TRUNC(DBMS_RANDOM.value(0,1000))/l_secs_in_day)));
  END LOOP;
END;
/




### Choose Random Row from a table
SELECT * FROM ( SELECT * FROM USER_TABLES ORDER BY dbms_random.VALUE ) WHERE ROWNUM <= 1 ;



------------------------------------------------------------
# session 10. RegularExpression

###  Regular Expression
select REGEXP_SUBSTR(comment, '\#[^#]+')
from   letter LET
where  REGEXP_COUNT(comment, '#') >=2 and REGEXP_COUNT(comment, '#') <=3  ;




------------------------------------------------------------
# session 11. Pagination

###  h2, SqlServer, postgresql:
SELECT * 
FROM tbl_article 
order by artifact_insertion_date ,artifact_id 
LIMIT 10 OFFSET 0;



###  oracle equivalent:
select *
from (
  select b.*, rownum rn
  from (
    select *
     from tbl_article 
     order by artifact_insertion_date ,artifact_id 
  ) b
  where rownum <= 10 
)
where rn > 0;


------------------------------------------------------------
# session 12. CommaSeparated

WITH Q_STR AS
(Select NGNQ_L4FNDRSLTPRSRCHVL('channelStrategies', to_char(d.l4220content)) STR
from lc4lfstrgdata d
where d.l4220agrstrtgtp = 11
and d.l4204loanfileid = '0124.700.21945506.1')
SELECT REGEXP_SUBSTR(STR, '[^,]+', 1, LEVEL) COL1
FROM Q_STR
CONNECT BY LEVEL <= REGEXP_COUNT(STR, ',') + 1;



------------------------------------------------------------
# session 14. FullTextSearch

create index IDX_COL1 on TBL1 ( COL1 )  indextype is ctxsys.context PARAMETERS ('SYNC ( ON COMMIT)');

select * from TBL1 where contains ( COL1 ,'%YourSearchString%')>0 order by 1;


------------------------------------------------------------
# session 14. Performance Tuning and tips

###  1. instead of checking conditions with several and:(x,y,z) in (a,b,c)
###  2. number of join conditions are always : n-1
###  3. never forget paranthesis: ( x or y or z ) and w
###  4. be careful about nulls: x not in NULL
###  5. Never use function on column unless we have function based index
###  6. Use Oracle hint to change execution path.
###  7. Use Oracle profile, thershold to change execution path.
###  8. Never use left or right join condition by OR and instead use UNIION ALL because:
- its hard to understand. its performance is not effective. old sql syntax does not support left/right outer join. Example:
- BAD:

select distinct b.beh_id
from TBL_behalf b,
       TBL_person_department pd,
       TBL_letter   let,
       TBL_letter_signer  signer,
       TBL_letter_paraph_signer paraph
where let.let_id = &letid
and    signer.lsg_let_id  = let.let_id
and    paraph.lsp_let_id = let.let_id
and b.beh_behalf_dep_id = &depId
and pd.prp_dep_id(+) = b.beh_owner_dep_id
and pd.prp_per_id(+) = b.beh_owner_per_id
and (
      ( let.let_sender_dep_id = b.beh_owner_dep_id) 
      or 
      (  signer.lsg_dep_id = b.beh_owner_dep_id) 
      or
      (   paraph.lsp_dep_id = b.beh_owner_dep_id)
      )
and b.beh_behalf_per_id is null;

- GOOD:

select distinct b.beh_id
from TBL_behalf b, TBL_person_department pd, TBL_letter let
where let.let_id = &letid
and b.beh_behalf_dep_id = &depId
and pd.prp_dep_id(+) = b.beh_owner_dep_id
and pd.prp_per_id(+) = b.beh_owner_per_id
and let.let_sender_dep_id = b.beh_owner_dep_id
and b.beh_behalf_per_id is null
union all
select distinct b.beh_id
from TBL_behalf b, TBL_person_department pd, TBL_letter_signer signer
where b.beh_behalf_dep_id = &depId
and pd.prp_dep_id(+) = b.beh_owner_dep_id
and pd.prp_per_id(+) = b.beh_owner_per_id
and signer.lsg_let_id = &letid
and signer.lsg_dep_id = b.beh_owner_dep_id
and b.beh_behalf_per_id is null
union all
select distinct b.beh_id
from TBL_behalf  b, TBL_person_department   pd,  TBL_letter_paraph_signer paraph
where b.beh_behalf_dep_id = &depId
and pd.prp_dep_id(+) = b.beh_owner_dep_id
and pd.prp_per_id(+) = b.beh_owner_per_id
and paraph.lsp_let_id = &letid
and paraph.lsp_dep_id = b.beh_owner_dep_id
and b.beh_behalf_per_id is null;



### 9. Never fetch all data in inner part of query before pagination and other filters Look at DEP_ORGAN. it is calculated for all records and then just first 100th of them will be shown.

- Bad

select *
from (select g_paging_tmp_table.*, ROWNUM VLP_ROWNUM
      from (
             select * from (
               select PER.*, 
				       pack_gpoa.get_all_dpet_organ_current(PER_ID) DEP_ORGAN
               from TBL_PERSONS PER
               where pack_gpoa.get_current_center(cntr_code) = 1 and per_is_active = 'Y'
             )
             ORDER BY PER_LAST_NAME ASC
           ) g_paging_tmp_table ) where  VLP_ROWNUM <=100
ORDER BY VLP_ROWNUM;

- Good

select per2.* ,
       pack_gpoa.get_all_dpet_organ_current(tbl2.PER_ID) DEP_ORGAN
from  TBL_PERSONS per2,
      (select tbl1.*,
      rownum rn
      from (
             select * 
             from ( select per.per_id , per.per_last_name
                    from TBL_PERSONS per
                    where  per_is_active = 'Y'
             )
             order by per_last_name asc
           ) tbl1 
      ) tbl2
where  rn <=100
and per2.per_id = tbl2.per_id
order by rn;


