<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<html>
<head>
	<title>환전원큐</title>
	<jsp:include page="../include/link.jsp"/>
	<style>
		#btn_info:hover {
			background-color: #40c4ff !important;
			color: whitesmoke !important;
			transition: all 0.5s;
			transition-timing-function: ease;
		}
	</style>
</head>
<body>
<div class="container-fluid position-relative d-flex p-0">
	<jsp:include page="../include/spinner.jsp"/>
	<jsp:include page="../include/sidebar.jsp"/>
	<a href="#" class="btn btn-lg bg-white border-0 btn-lg-square back-to-top"><i
			class="bi bi-arrow-up text-hanagreen"></i></a>
	<div class="content">
		<jsp:include page="../include/navbar.jsp"/>
		<div class="ms-5 fs-5" style="color: #bdbdbd">환전하기 / <strong style="color: #000000">환전완료</strong></div>
		<div class="container-fluid px-4 mt-4">
			<div class="row g-4">
				<div class="col-sm-12 col-md-12 col-xl-12">
					<div class="row rounded p-4 mb-4">
						<div class="row justify-content-center text-center rounded p-4 col-10" style="background-color: #fafafa;float: none; margin: 0 auto">
							<div class="col-12">
								<i class="fa-solid fa-check rounded-circle text-white p-4"
								   style="font-size: 30px; background-color: #29b6f6"></i>
							</div>
							<div class="col12 mt-2 mb-2 fs-3 text-black-50" style="font-family: hanaM">
								환전이 완료되었습니다.
							</div>
							<div class="rounded col-6 border-top mt-2 border-4 box w-75"
							     style="border-color: #29b6f6 !important; background-color: white !important; height: 75%; opacity: 1">
								<div class="col-12 mt-5 row">
									<div class="col-4">
										<div>
											<img src="/resources/flag/flag_${exchangeHistoryVO.sellCcyCode}.png"
											     style="width: 70px; height: 45px">
										</div>
										<div class="fs-5 mt-3 text-black-50" style="font-family: hanaM">
											${sellCntryKrNm}&nbsp;${exchangeHistoryVO.sellCcyCode}
										</div>
										<div class="text-dark mt-1 fs-5" style="font-family: hanaM">
											<fmt:formatNumber value="${exchangeHistoryVO.sellAmount}" pattern="#,###"/>
										</div>
									</div>
									<div class="col-4 pt-4">
										<i class="fa-solid fa-angles-right fa-fade fs-1 text-hanagreen"
										   style="--fa-animation-duration: 2s"></i>
									</div>
									<div class="col-4">
										<div>
											<img src="/resources/flag/flag_${exchangeHistoryVO.buyCcyCode}.png"
											     style="width: 70px; height: 45px">
										</div>
										<div class="fs-5 mt-3 text-black-50" style="font-family: hanaM">
											${buyCntryKrNm}&nbsp;${exchangeHistoryVO.buyCcyCode}
										</div>
										<div class="text-dark mt-1 fs-5" style="font-family: hanaM">
											<fmt:formatNumber value="${exchangeHistoryVO.buyAmount}" pattern="#,###"/>
										</div>
									</div>
									<div class="mt-2 text-black-50">
										외화를 찾으실 정보를 입력하세요.
									</div>
									<div class="mt-2">
										<button class="border border-3 fs-5 p-2 bg-white pe-4 ps-4" id="btn_info" style="color:#42a5f5;border-radius: 20px;border-color: #42a5f5 !important;">수령정보 등록</button>
									</div>
								</div>
							</div>
						</div>
					</div>
						<div class="row col-10 justify-content-center bg-white text-center rounded pe-5 ps-5 pt-5 pb-4 mb-4" style="float: none; margin: 0 auto">
							<div class="fs-4 text-start text-black-50 border-bottom border-2 pb-2 ps-0"
							     style="font-family: hanaM">
								신청내역
							</div>
							<div class="col-12 p-0 d-flex justify-content-between mt-3">
								<div class="text-start ps-0 text-black-50 fs-5" style="font-family: hanaM">
									거래일자
								</div>
								<div class="text-start ps-0 text-black-50 fs-5" style="font-family: hanaM">
									<%=simpleDateFormat.format(nowTime)%>
								</div>
							</div>
							<div class="col-12 p-0 d-flex justify-content-between mt-2">
								<div class="text-start ps-0 text-black-50 fs-5" style="font-family: hanaM">
									적용환율
								</div>
								<div class="text-start ps-0 text-black-50 fs-5" style="font-family: hanaM">
									${exchangeHistoryVO.applyExchangeRate}&nbsp;원
								</div>
							</div>
							<div class="col-12 p-0 d-flex justify-content-between mt-2">
								<div class="text-start ps-0 text-black-50 fs-5" style="font-family: hanaM">
									우대율
								</div>
								<div class="text-start ps-0 text-black-50 fs-5" style="font-family: hanaM">
									${exchangeHistoryVO.eventSpreadRate}%
								</div>
							</div>
							<div class="col-12 p-0 d-flex justify-content-between mt-2 mb-4">
								<div class="text-start ps-0 text-black-50 fs-5" style="font-family: hanaM">
									환전신청번호
								</div>
								<div class="text-start ps-0 text-black-50 fs-5" style="font-family: hanaM">
									${exchangeHistoryVO.historyNo}
								</div>
							</div>
							<hr>
							<div class="text-hanared text-start ps-0">
								* 영업점의 외화 보유현황에 따라 수령 하실 수 있는 권종에 제한이 있을 수 있습니다.
							</div>
							<div class="mt-4">
								<a class="btn btn-primary fs-6 p-2 bg-hanagreen border-0 me-3 pe-4 ps-4" style="font-size: 20px!important;border-radius: 20px;" href="/walletInfo">
									환전내역 조회
								</a>
								<button class="btn btn-primary fs-6 p-2 bg-hanasilver border-0 me-3 pe-4 ps-4" style="font-size: 20px!important;border-radius: 20px;">
									나중에 수령정보 등록
								</button>
							</div>
						</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../include/script.jsp"/>
</body>
</html>
