package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if ("GET".equals(method)) {
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		} else {
			String name = request.getParameter("name");
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String email = request.getParameter("email");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String extraAddress = request.getParameter("extraAddress");
			String gender = request.getParameter("gender");
			String birthyyyy = request.getParameter("birthyyyy");
			String birthmm = request.getParameter("birthmm");
			String birthdd = request.getParameter("birthdd");
		
			String mobile = hp1 + hp2 + hp3;
			String birthday = birthyyyy + "-" + birthmm + "-" + birthdd;
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailAddress, extraAddress, gender, birthday);			
			
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.registerMember(member);
			
			String message = "";
			String loc = "";
			
			if (n == 1) {
				message = "회원가입 성공!!!!";
				loc = request.getContextPath() + "/index.up";  // 시작페이지
			} else {
				message = "회원가입 실패!!!!";
				loc = "javascript:history.back()";  // 자바스크립트를 이용한 이전페이지로의 이동				
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}
