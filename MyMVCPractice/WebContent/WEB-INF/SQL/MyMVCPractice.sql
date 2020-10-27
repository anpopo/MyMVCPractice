    show user;  -- USER이(가) "SYS"입니다.
    
    create user mymvcpractice_user identified by cclass; -- User MYMVCPRACTICE_USER이(가) 생성되었습니다.

    grant connect, resource, create view, unlimited tablespace to mymvcpractice_user;
    -- Grant을(를) 성공했습니다.

    show user;  -- USER이(가) "MYMVCPRACTICE_USER"입니다.