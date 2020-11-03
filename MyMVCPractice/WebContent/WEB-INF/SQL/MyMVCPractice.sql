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
    
    drop table tbl_member purge;
    
    rollback;
    
    select *
    from tbl_member;
    
    create table tbl_loginhistory
    (fk_userid              varchar2(20) not null
    , logindate             date default sysdate not null
    , clientip               varchar2(20) not null
    , constraint FK_tbl_loginhistory foreign key(fk_userid) references tbl_member(userid)
    );
    
    select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender
    , substr(birthday,1,4) as birthyyyy, substr(birthday,6,2) as birthmm, substr(birthday,8) as birthdd, coin, point
    , to_char(registerday, 'yyyy-mm-dd') as registerday
    , trunc(months_between(sysdate, lastpwdchangedate)) as pwdchangegap
    from tbl_member
    where status = 1 and userid = 'leess' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382';
    
    select *
    from tbl_loginhistory;
    
    drop table tbl_loginhistory purge;
    
    
    
    update tbl_member set registerday = add_months(registerday, -4), lastpwdchangedate = add_months(lastpwdchangedate, -4)
    where userid = 'eomjh';
    
    commit;
    
    -- 마지막으로 로그인을 한지 12개월이 초과한 경우 또는 회원을 가입하고서 로그인을 하지 않은지 12개월을 초과한 경우
    -- 로그인을 한지 1년이 지나서 휴면 상태로 되었삼. 관리자에게 문의하삼!@!@!@!@!@!@!@!@!@!@
    
    update tbl_member set registerday = add_months(registerday, -13), lastpwdchangedate = add_months(lastpwdchangedate, -13)
    where userid = 'kangkc';

    update tbl_loginhistory set logindate = add_months(logindate, +7)
    where fk_userid = 'kangkc';
    
    update tbl_member set registerday = add_months(registerday, -14), lastpwdchangedate = add_months(lastpwdchangedate, -14)
    where userid = 'youks';
    
    commit;
    ----------------------------------------------------------------------------------------------------------------------------------
    
    
     select max(logindate)
    , trunc(months_between(sysdate, max(logindate))) as lastlogingap
    from tbl_loginhistory
    where fk_userid = 'leess';
    
    select trunc(months_between(sysdate, max(logindate))) as lastlogingap
    from tbl_loginhistory
    where fk_userid = 'kangkc';
    
    --- 회원가입만하고서 로그인을 하지 않은 경우에는 tbl_loginhistory 테이블에 insert 되어진 정보가 없으므로 
    --- 마지막으로 로그인한 날짜를 회원가입한 날짜로 보도록 한다.
    select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender
    , birthyyyy, birthmm, birthdd, coin, point, registerday, pwdchangegap
    , nvl(lastlogingap, trunc(months_between(sysdate, registerday))) as lastlogingap
    from
    (select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender
    , substr(birthday,1,4) as birthyyyy, substr(birthday,6,2) as birthmm, substr(birthday,9) as birthdd, coin, point
    , to_char(registerday, 'yyyy-mm-dd') as registerday
    , trunc(months_between(sysdate, lastpwdchangedate)) as pwdchangegap
    from tbl_member
    where status = 1 and userid = 'youks' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382') m
    cross join
    (select trunc(months_between(sysdate, max(logindate))) as lastlogingap
    from tbl_loginhistory
    where fk_userid = 'youks'
    ) h;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    