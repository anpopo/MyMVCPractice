package member.model;

import java.sql.SQLException;

public interface InterMemberDAO {
	
	// 회원가입 메서드
	int registerMember(MemberVO member) throws SQLException;
}
