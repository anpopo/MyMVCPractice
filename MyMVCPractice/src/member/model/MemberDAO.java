package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class MemberDAO implements InterMemberDAO {
	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public MemberDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/mymvcpractice_oracle");
		    aes = new AES256(SecretMyKey.KEY);
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 회원가입 메서드
	@Override
	public int registerMember(MemberVO member) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress"
					+ ", gender, birthday)\n"+
					"    values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getUserid());
			pstmt.setString(2, Sha256.encrypt(member.getPwd()));
			pstmt.setString(3, member.getName());
			pstmt.setString(4, aes.encrypt(member.getEmail()));
			pstmt.setString(5, aes.encrypt(member.getMobile()));
			pstmt.setString(6, member.getPostcode());
			pstmt.setString(7, member.getAddress());
			pstmt.setString(8, member.getDetailaddress());
			pstmt.setString(9, member.getExtraaddress());
			pstmt.setString(10, member.getGender());
			pstmt.setString(11, member.getBirthday());
			
			
			result = pstmt.executeUpdate();
		} catch(UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return result;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {
		boolean isExist = false;
		
		try {
			conn = ds.getConnection();
			String sql = "select userid\n"+
					"    from tbl_member\n"+
					"    where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			isExist = rs.next();  // 행이 있으면 (중복된 유저아이디) true, 행이 없으면 (중복되지 않은 유저아이디) false
			
			
		} finally {
			close();
		}
		
		return isExist;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	@Override
	public boolean emailDuplicateCheck(String email) throws SQLException {
		boolean isExist = false;
		
		
		try {
			conn = ds.getConnection();
			String sql = "select email\n"+
					"    from tbl_member\n"+
					"    where email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(email));
			
			rs = pstmt.executeQuery();
			
			isExist = rs.next();  // 행이 있으면 (중복된 유저아이디) true, 행이 없으면 (중복되지 않은 유저아이디) false
			
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return isExist;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	@Override
	public MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException {
		MemberVO member = null;
		
		try {
			conn = ds.getConnection();
			String sql = "select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender\n"+
					"    , birthyyyy, birthmm, birthdd, coin, point, registerday, pwdchangegap\n"+
					"    , nvl(lastlogingap, trunc(months_between(sysdate, registerday))) as lastlogingap\n"+
					"    from\n"+
					"    (select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender\n"+
					"    , substr(birthday,1,4) as birthyyyy, substr(birthday,6,2) as birthmm, substr(birthday,9) as birthdd, coin, point\n"+
					"    , to_char(registerday, 'yyyy-mm-dd') as registerday\n"+
					"    , trunc(months_between(sysdate, lastpwdchangedate)) as pwdchangegap\n"+
					"    from tbl_member\n"+
					"    where status = 1 and userid = ? and pwd = ?) m\n"+
					"    cross join\n"+
					"    (select trunc(months_between(sysdate, max(logindate))) as lastlogingap\n"+
					"    from tbl_loginhistory\n"+
					"    where fk_userid = ?\n"+
					"    ) h";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")));
			pstmt.setString(3, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				member = new MemberVO();
				member.setUserid(rs.getString(1));
				member.setName(rs.getString(2));
				member.setEmail(aes.decrypt(rs.getString(3)));
				member.setMobile(aes.decrypt(rs.getString(4)));
				member.setPostcode(rs.getString(5));
				member.setAddress(rs.getString(6));
				member.setDetailaddress(rs.getString(7));
				member.setExtraaddress(rs.getString(8));
				member.setGender(rs.getString(9));
				member.setBirthday(rs.getString(10) + "-" + rs.getString(11) + "-" + rs.getString(12));
				member.setCoin(rs.getInt(13));
				member.setPoint(rs.getInt(14));
				member.setRegisterday(rs.getString(15));
				member.setBirthyyyy(rs.getString(10));
				member.setBirthmm(rs.getString(11));
				member.setBirthdd(rs.getString(12));
				
				if (rs.getInt(16) >= 3) {
					member.setRequirePwdChange(true);  // 로그인시 암호를 변경하라른 alert을 띄우도록 한다.
				}
				
				
				if (rs.getInt(17) >= 12) {
					member.setIdle(1);
					sql = " update tbl_member set idle = 1 where userid = ? ";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, paraMap.get("userid"));
					
					pstmt.executeUpdate();
					
				}
				if (member.getIdle() != 1) {
					sql = " insert into tbl_loginhistory(fk_userid, clientip) "
							+ " values(?, ?) ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("userid"));
					pstmt.setString(2, paraMap.get("clientip"));
					pstmt.executeUpdate();					
				}
				
			}
			
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return member;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	@Override
	public String findUserid(Map<String, String> paraMap) throws SQLException {
		String userid = null;
		try {
			conn = ds.getConnection();
			String sql = "select userid\n"+
					"    from tbl_member\n"+
					"    where status = 1 and name = ? and email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("name"));
			pstmt.setString(2, aes.encrypt(paraMap.get("email")));
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				userid = rs.getString(1);
				
			}
			
		} catch(UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return userid;
	}
}
