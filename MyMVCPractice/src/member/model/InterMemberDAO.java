package member.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterMemberDAO {
	
	// 회원가입 메서드
	int registerMember(MemberVO member) throws SQLException;

	// 아이디 중복검사 (tbl_member에서 userid가 있으면 true 없으면 false 리턴)
	boolean idDuplicateCheck(String userid) throws SQLException;
	// 이메일 중복검사
	boolean emailDuplicateCheck(String email) throws SQLException;
	
	// 입력받은 paraMap 을 가지고 한명의 회원 정보를 리턴시켜주는 메소드
	MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException;
}
