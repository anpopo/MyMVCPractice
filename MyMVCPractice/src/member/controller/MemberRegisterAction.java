package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if ("GET".equals(method)) {
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		} else {
			
		}
	}

}
