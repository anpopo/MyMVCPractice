package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends AbstractController {
	
	@Override
	public String toString() {
		return "### 클래스 MainController의 인스턴스 메소드 toString() 호출함 ###";
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		super.setRedirect(true);
		super.setViewPage("index.an");
	}

}
