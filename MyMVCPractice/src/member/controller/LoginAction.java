package member.controller;

import java.util.*;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import common.controller.AbstractController;
import member.model.*;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		
		if(!"POST".equalsIgnoreCase(method)) {
			String message = "비정상적인 경로로 들어왔어!~!";
			String loc = "javascript:histroy.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String clientip = request.getRemoteAddr();
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid);
		paraMap.put("pwd", pwd);
		paraMap.put("clientip", clientip);
		
		InterMemberDAO mdao = new MemberDAO();
		MemberVO loginuser = mdao.selectOneMember(paraMap);
		
		if (loginuser != null) {
			// System.out.println(loginuser.getName());			
			// session 세션 이라는 저장소에 로그인 되어진 loginuser을 저장시켜두어야 한다!!!
			// session이란 WAS 컴퓨터의 메모리 (RAM)의 일부분을 사용하는 것으로
			// 접속한 클라이언트 컴퓨터에서 보내온 정보를 저장하는 용도로 쓰인다!
			// 클라이언트 컴퓨터가 WAS컴퓨터에 웹으로 접속을 하기만 하면 무조건 자동적으로 WWAS컴퓨터의 메모리의 일부분에 Session이 생성 되어진다.
			// session은 클라이언트 컴퓨터 웹브라우저당 1개씩 생성되어진다. 예를들면 클라이언트 컴퓨터가 크롬 웹 브라우저로 WAS컴퓨터에 웹으로 연결하면,
			// session이 하나 생성되어지고, 또이어서 동일한 클라이언트 컴퓨터가 엣지 웹브라우저로 WAS 컴퓨터에 연결하면 
			// 또 하나의 새로운 session이 생성되어진다.
			// 세션(session)이라는 저장 영역에 loginuser 를 저장시켜두면 Command.properties 파일에 기술된 모든 클래스 및  모든 JSP 페이지(파일)에서 loginuser 정보를 읽어들일 수 있게 된다.
			// 그러므로 어떠한 정보를 여러 클래스 또는 여러 jsp페이지에서 공통적으로 사용하고자 한다면 session에 저장해야 한다.
			
			HttpSession session = request.getSession();
			session.setAttribute("loginuser", loginuser);
			
			String message = "로그인성공ㅊㅋㅊㅋㅊㅋ~~";
			String loc = request.getContextPath() + "/index.an";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
		} else {
			// System.out.println("ddafaf");
			String message = "로그인 실퍀ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ";
			String loc = "javascript:history.back()";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}

}
