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
    
    
    -- *** 회원 테이블 생성 하기 *** --
    
    create table tbl_member
    (userid                 varchar2(20)           not null  -- 회원아이디
    , pwd                   varchar2(200)          not null  -- SHA-256 암호화 대상
    , name                  varchar2(30)           not null  -- 이름
    , email                 varchar2(200)          not null  -- AES-256 암호화/복호화 대상
    , mobile                varchar2(200)                    -- 핸드폰번호
    , postcode              varchar2(5)                      -- 우편번호
    , address               varchar2(200)                    -- 주소
    , detailaddress         varchar2(200)                    -- 상세주소
    , extraaddress          varchar2(200)                    -- 참고항목
    , gender                varchar2(1)                      -- 성별 남자 1 여자 2
    , birthday              varchar2(10)                     -- 생년월일
    , coin                  number default 0                 -- 코인액
    , point                 number default 0                 -- 포인트
    , registerday           date default sysdate             -- 가입일자
    , lastpwdchangedate     date default sysdate             -- 마지막 암호 변경 날짜
    , status                number(1) default 1    not null  -- 회원탈퇴유무 1: 사용가능 2: 사용불가
    , idle                  number(1) default 0    not null  -- 휴면 유무 0: 활동중 1: 휴면중
    , constraint PK_tbl_member_userid primary key (userid)
    , constraint UK_tbl_member_email unique (email)
    , constraint CK_tbl_member_gender check (gender in('1', '2'))
    , constraint CK_tbl_member_status check (status in(0,1))
    , constraint CK_tbl_member_idle check (idle in(0, 1))
    );
    
    
    insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress
    , gender, birthday)
    values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);