<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
   table#loginTbl , table#snsloginTbl{
      width: 95%;
      border: solid 1px gray;
      border-collapse: collapse;
      margin-top: 20px;
   }
   
   table#loginTbl #th {
      background-color: silver;
      font-size: 14pt;
      text-align: center;
   }
   
   table#loginTbl td {
      border: solid 1px gray;
   }
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		var loginUserid = localStorage.getItem("saveid");
		
		// localStorage에 저장되어진 유저의 아이디의 값이 있는지 확인한다.
		// storage에 유저아이디의 값이 들어있다면,
		if (loginUserid != null) {
			$("input#loginUserid").val(loginUserid);
			$("input:checkbox[id=saveid]").prop("checked", true);
		}
		
		
		$("button#btnSubmit").click(function(){
			// 로그인 시도한다.
			goLogin();
		});
		
		$("input:password[id=loginPwd]").keyup(function(event){
			if (event.keyCode == 13) {
				// 로그인 시도한다. 키코드 13번은 엔터키			
				goLogin();
				
			}
		});
		
		
		$(".myclose").click(function(){
			javascript:history.go(0);
		// 현재 페이지를 새로고침을 함으로써 모달창에 입력한 성명과 이메일의 값이 텍스트박스에 남겨있지 않고 삭제하는 효과를 누린다. 
	    
		/* === 새로고침(다시읽기) 방법 3가지 차이점 ===
		   >>> 1. 일반적인 다시읽기 <<<
		   window.location.reload();
		   ==> 이렇게 하면 컴퓨터의 캐시에서 우선 파일을 찾아본다.
		            없으면 서버에서 받아온다. 
		   
		   >>> 2. 강력하고 강제적인 다시읽기 <<<
		   window.location.reload(true);
		   ==> true 라는 파라미터를 입력하면, 무조건 서버에서 직접 파일을 가져오게 된다.
		            캐시는 완전히 무시된다.
		   
		   >>> 3. 부드럽고 소극적인 다시읽기 <<<
		   history.go(0);
		   ==> 이렇게 하면 캐시에서 현재 페이지의 파일들을 항상 우선적으로 찾는다.
		*/
		});
	});
	
	
	
	
	// 로그인 처리 함수 로그인을 클릭했을 경우나 엔터를 쳤을 경우 둘다 작동되어야 하기 때문에
	// 같은 기능을 하는 function을 만들어서 실행만 시켜준다.
	function goLogin() {
		// alert("로그인시도우!");
		var loginUserid = $("input#loginUserid").val().trim();
		var loginPwd = $("input#loginPwd").val().trim();
		
		if (loginUserid == '') {
			$("input#loginUserid").val("");
			$("input#loginUserid").focus();
			return;  // 함수 끝내기
		}
		if (loginPwd == '') {
			$("input#loginPwd").val("");
			$("input#loginPwd").focus();
			return;  // 함수 끝내기
		}
		
		if ($("input:checkbox[id=saveid]").prop("checked")) {
			
			localStorage.setItem("saveid", $("input#loginUserid").val());
		} else {
			
			localStorage.removeItem('saveid');
		}
		
		var frm = document.loginFrm;
		frm.action = "<%= request.getContextPath()%>/login/login.an";
		frm.method = "post";
		frm.submit();
		
		
	}
	
	function goLogOut() {
		
		location.href="<%= request.getContextPath()%>/login/logout.an"
	}
</script>

<!-- 로그인을 하기위한 폼을 생성해 주는 것! -->
<c:if test="${empty sessionScope.loginuser}">

	<form name="loginFrm">
		<table id="loginTbl">
	    	<thead>
	            <tr>
	               <th colspan="2" id="th">LOGIN</th>
	            </tr>
	         </thead>
	         
	         <tbody>
	            <tr>
	               <td style="width: 30%; border-bottom: hidden; border-right: hidden; padding: 10px;">ID</td>
	               <td style="width: 70%; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="text" id="loginUserid" name="userid" size="13" class="box" /></td>
	            </tr>   
	            <tr>
	               <td style="width: 30%; border-top: hidden; border-bottom: hidden; border-right: hidden; padding: 10px;">암호</td>
	               <td style="width: 70%; border-top: hidden; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="password" id="loginPwd" name="pwd" size="13" class="box" /></td>
	            </tr>
	            
	            <%-- 아이디 찾기, 비밀번호 찾기 --%>
	            <tr>
	               <td colspan="2" align="center">
	                  <a style="cursor: pointer;" data-toggle="modal" data-target="#userIdfind" data-dismiss="modal">아이디찾기</a> /
	                  <a style="cursor: pointer;" data-toggle="modal" data-target="#passwdFind" data-dismiss="modal" data-backdrop="static">비밀번호찾기</a>
	               </td>
	            </tr>
	            
	            <tr>
	               <td colspan="2" align="center" style="padding: 10px;">
	                  <input type="checkbox" id="saveid" name="saveid" style="vertical-align: text-top;" /><label for="saveid" style="margin-right: 20px; vertical-align: middle;">아이디저장</label>
	                  <button type="button" id="btnSubmit" style="width: 67px; height: 27px; background-image: url('<%= request.getContextPath()%>/images/login.png'); vertical-align: middle; border: none;"></button>
	               </td>
	            </tr>
	         </tbody>
	       </table>
	</form>

</c:if>


<c:if test="${not empty sessionScope.loginuser}">
	<table style="width: 95%; height: 130px;">
          <tr style="background-color: pink;">
             <td align="center">
             	<marquee behavior=alternate scrollamount="2">
                	<span style="color: blue; font-weight: bold;">${(sessionScope.loginuser).name}</span>
                	[<span style="color: red; font-weight: bold;">${(sessionScope.loginuser).userid}</span>]님
                </marquee>
                <br/><br/>
                <div align="left" style="padding-left: 20px; line-height: 150%;">
                   <span style="font-weight: bold;">코인액:</span>&nbsp;&nbsp; <fmt:formatNumber value="${(sessionScope.loginuser).coin}" pattern="###,###" /> 원
                   <br/>
                   <span style="font-weight: bold;">포인트:</span>&nbsp;&nbsp; <fmt:formatNumber value="${(sessionScope.loginuser).point}" pattern="###,###" /> POINT
                </div>
                <br/>로그인 중...<br/><br/>
                [<a href="javascript:goEditPersonal('${(sessionScope.loginuser).userid}');">나의정보</a>]&nbsp;&nbsp;
                 [<a href="javascript:goCoinPurchaseTypeChoice('${(sessionScope.loginuser).userid}');">코인충전</a>] 
                 <br/><br/>
                <button type="button" onclick="goLogOut();">로그아웃</button>
             </td>
          </tr>
       </table> 

</c:if>

 <%-- ****** 아이디 찾기 Modal ****** --%>
  <div class="modal fade" id="userIdfind" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">아이디 찾기</h4>
        </div>
        <div class="modal-body" style="height: 300px; width: 100%;">
          <div id="idFind">
             <iframe style="border: none; width: 100%; height: 280px;" src="<%= request.getContextPath()%>/login/idFind.an">
             </iframe>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>


  <%-- ****** 비밀번호 찾기 Modal ****** --%>
  <div class="modal fade" id="passwdFind" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">비밀번호 찾기</h4>
        </div>
        <div class="modal-body">
          <div id="pwFind">
             <iframe style="border: none; width: 100%; height: 350px;" src="<%= request.getContextPath() %>/login/pwdFind.an">  
             </iframe>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>





