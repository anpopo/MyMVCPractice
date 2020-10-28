<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%

	String ctxPath = request.getContextPath();
%>
<style>
	
	
	marquee#storename {
		font-size: 30pt;
		color: gray;
		font-weight: bold;
		margin: 20px;
		
	}
	
	marquee#storename:hover {
		background-color: yellow;
	}
</style>


<jsp:include page="header.jsp"></jsp:include>


<marquee id="storename" >감자네집 쇼핑몰 (연습)</marquee>

<div class="container">
	<div style="width: 70%; margin: 0 auto;">
	
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
	
				<c:forEach items="${imgList}" varStatus="status">
					<c:if test="${status.index == 0}">
						<li data-target="#myCarousel" data-slide-to="${status.index}" class="active"></li>
					</c:if>
					<c:if test="${status.index > 0}">
						<li data-target="#myCarousel" data-slide-to="${status.index}"></li>
					</c:if>
	
				</c:forEach>
				<!-- 
	       <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	       <li data-target="#myCarousel" data-slide-to="1"></li>
	       <li data-target="#myCarousel" data-slide-to="2"></li> 
	       -->
			</ol>
	
			<!-- Wrapper for slides -->
			<div class="carousel-inner">
				<c:forEach var="imgvo" items="${imgList}" varStatus="status">
					<c:if test="${status.index == 0}">
						<div class="item active">
	        				<img src="<%= ctxPath %>/images/${imgvo.imgfilename}" style="width:100%;">
	      				</div>
					</c:if>
					<c:if test="${status.index > 0}">
						<div class="item">
	       					<img src="<%= ctxPath %>/images/${imgvo.imgfilename}" style="width:100%;">
	     				</div>
					</c:if>
				</c:forEach>
	
	
			
				<!-- 
	      <div class="item active">
	        <img src="image/image1.jpg" alt="야외 풀장" style="width:100%;">
	      </div>
	
	      <div class="item">
	        <img src="image/image2.jpg" alt="디럭스룸" style="width:100%;">
	      </div>
	    
	      <div class="item">
	        <img src="image/image3.jpg" alt="레스토랑" style="width:100%;">
	      </div> 
	      -->
			</div>
	
			<!-- Left and right controls -->
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right"></span> <span
				class="sr-only">Next</span>
			</a>
		</div>
	</div>
</div>

<jsp:include page="footer.jsp"></jsp:include>
