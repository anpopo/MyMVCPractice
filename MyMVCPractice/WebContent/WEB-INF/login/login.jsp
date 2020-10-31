<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		
		var frm = document.loginFrm;
		frm.action = "<%= request.getContextPath()%>/login/login.an";
		frm.method = "post";
		frm.submit();
		
		
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
	<hr>
	<marquee behavior=alternate scrollamount="2"> ${sessionScope.loginuser.name}님이 로그인 중이십니다.</marquee>
	<hr>

</c:if>







