    show user;  -- USER이(가) "SYS"입니다.
    
    create user mymvcpractice_user identified by cclass; -- User MYMVCPRACTICE_USER이(가) 생성되었습니다.

    grant connect, resource, create view, unlimited tablespace to mymvcpractice_user;
    -- Grant을(를) 성공했습니다.

    show user;  -- USER이(가) "MYMVCPRACTICE_USER"입니다.
    
    create table tbl_main_image
    (imgno           number not null
    ,imgfilename     varchar2(100) not null
    ,constraint PK_tbl_main_image primary key(imgno)
    );
    
    create sequence seq_main_image
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
    insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '미샤.png');  
    insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '원더플레이스.png'); 
    insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '레노보.png'); 
    insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '동원.png'); 
    
    commit;
    
    select imgno, imgfilename
    from tbl_main_image
    order by imgno;