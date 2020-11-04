package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class IdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if ("POST".equals(method)) {
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			InterMemberDAO mdao = new MemberDAO();
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("name", name);
			paraMap.put("email", email);
			
			String userid = mdao.findUserid(paraMap);
			
			request.setAttribute("paraMap", paraMap);
			
			if(userid != null) {
				request.setAttribute("userid", userid);
				
			} else {
				request.setAttribute("userid", "존재하지않네??ㅋㅋㅋㅋㅋ끄지라");
			}
			
		}
		request.setAttribute("method", method);
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/idFind.jsp");
	}

}
