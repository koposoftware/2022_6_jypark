<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<title>환전원큐</title>
	<jsp:include page="../include/link.jsp"/>
	<style>
        #exchange {
            min-height: 750px;
            background-origin: content-box;
            background-image: url("/resources/img/exchange_main01.png");
            background-repeat: no-repeat;
            background-size: 100% 100%;
        }

        #do_exchange:hover {
            opacity: 0.7;
        }

        #exchange_history:hover {
            opacity: 0.5;
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
		<div class="ms-5 fs-5" style="color: #bdbdbd">환전지갑 / <strong style="color: #000000">환전하기</strong></div>
		<div class="container-fluid pt-4 px-4 mb-3 mt-3">
			<div class="row g-4 p-2">
				<div class="col-sm-12 col-md-12 col-xl-12 h-100 p-4 ms-2 bg-white flex-column box rounded row"
				     id="exchange">
					<div class="text-dark fs-1 mt-5 ms-3" style="font-family: hanaM;">
						최대 90% 환율(Spread)우대<br>
						당일수령가능
						<div class="mt-0 text-black-50 fs-4 mt-3">
							알뜰하게 환전하고<br>
							원할 때 바로 찾아가세요!
						</div>
					</div>
					<div class="col-12 mt-5">
						<a href="exchange/chooseCntry" id="do_exchange" type="button" class="btn bg-hanagreen text-white fs-5 p-2"
						        style="width: 130px; height: 50px; border-radius: 20px; font-family: dotomM">환전하기
						</a>
						<a href="walletInfo" id="exchange_history" type="button" class="btn bg-white border-2 text-black-50 fs-5 p-2"
						        style="width: 150px; height: 50px; border-radius: 20px; font-family: dotomM; border-color: #8d8d8d">
							환전내역보기
						</a>
					</div>
					<div class="flex-column" style="margin-top: 120px">
						<div>
							<button class="btn w-25 text-start mt-2 text-dark d-flex justify-content-between"
							        data-bs-toggle="modal" data-bs-target="#useInfo"
							        style="background-color: #f5f5f5">
								<span class="text-start fs-5 text-black-50" style="font-family: dotomM">
									<i class="fa-solid fa-book text-black-50" ></i>&nbsp;이용안내
								</span>
								<span class="text-dark">
									>
								</span>
							</button>
						</div>
						<div>
							<button type="button"
							        class="btn w-25 text-start mt-2 text-dark d-flex justify-content-between"
							        data-bs-toggle="modal" data-bs-target="#spread"
							        style="background-color: #f5f5f5">
								<span class="text-start fs-5 text-black-50" style="font-family: dotomM">
									<i class="fa-solid fa-percent text-black-50"></i>&nbsp우대율안내
								</span>
								<span class="text-dark">
									>
								</span>
							</button>
						</div>
						<div>
							<button class="btn w-25 text-start mt-2 text-dark d-flex justify-content-between"
							        style="background-color: #f5f5f5">
								<span class="text-start fs-5 text-black-50" style="font-family: dotomM">
									<i class="fa-solid fa-location-dot text-black-50"></i>&nbsp;수령점조회
								</span>
								<span class="text-dark">
									>
								</span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%--우대율 Modal--%>
<div class="modal fade " id="spread" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title text-hanagreen text-center fs-3" id="spreadLabel"><i
						class="fa-solid fa-gift"></i>&nbsp;우대율 안내</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				<br>
			</div>
			<div class="modal-body">
				<h6 class="text-black-50 mb-4">이벤트기간: ${spreadList[0].eventEndDate.substring(0, 10)}까지</h6>
				<table class="table border-0 table-hover text-end me-2 border-top">
					<colgroup>
						<col width=20%>
						<col width=20%>
						<col width=20%>
						<col width=20%>
						<col width=20%>
					</colgroup>
					<thead>
					<tr>
						<th class="text-center border-1 border-start-0 text-dark h-100 align-middle"
						    style="background-color: #eceff1; border-color: #c7c7c7; font-family: hanaM;">통화
						</th>
						<th class="text-center border-1 text-dark"
						    style="font-family: hanaM;background-color: #eceff1; border-color: #c7c7c7">기본우대율
						</th>
						<th class="text-center border-1 text-dark"
						    style="font-family: hanaM;background-color: #eceff1; border-color: #c7c7c7">이벤트우대율
						</th>
						<th class="text-center border-1 text-dark h-100 align-middle"
						    style="font-family:hanaM;background-color: #eceff1; border-color: #c7c7c7">환전가능 최소금액
						</th>
						<th class="text-center border-1 border-end-0 text-dark h-100 align-middle"
						    style="font-family:hanaM; background-color: #eceff1; border-color: #c7c7c7">
							환전금액 입력 단위
						</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${spreadList}" var="spread">
						<c:choose>
						<c:when test="${spread.eventSpreadRate >= 80}">
						<tr class="border-1 border-start-0 border-end-0 text-center" style="border-color: #c7c7c7;background-color: #e3f2fd">
								<td class="text-hanagreen border-1 border-start-0 text-dark"
								    style="border-color: #c7c7c7">
										${spread.cntryNmKr}&nbsp;${spread.ccyCode}
								</td>
								<td class="border-1 text-dark" style="font-family: hana; border-color: #c7c7c7">
										${spread.basicSpreadRate}
								</td>
								<td class="border-1 text-dark" style="border-color: #c7c7c7">
										${spread.eventSpreadRate}
								</td>
								<td class="border-1 text-dark" style="border-color: #c7c7c7">
									<fmt:formatNumber pattern="#,###" value="${spread.exchangeMinAmount}"/>
								</td>
								<td class="text-dark">
									<fmt:formatNumber pattern="#,###" value="${spread.exchangeMinInput}"/>&nbsp;단위
								</td>
						</tr>
						</c:when>
						<c:otherwise>
							<tr class="border-1 border-start-0 border-end-0 text-center" style="border-color: #c7c7c7; background-color: #fbe9e7">
								<td class="text-hanagreen border-1 border-start-0 text-dark"
								    style="border-color: #c7c7c7">
										${spread.cntryNmKr}&nbsp;${spread.ccyCode}
								</td>
								<td class="border-1 text-dark" style="font-family: hana; border-color: #c7c7c7">
										${spread.basicSpreadRate}
								</td>
								<td class="border-1 text-dark" style="border-color: #c7c7c7">
										${spread.eventSpreadRate}
								</td>
								<td class="border-1 text-dark" style="border-color: #c7c7c7">
									<fmt:formatNumber pattern="#,###" value="${spread.exchangeMinAmount}"/>
								</td>
								<td class="text-dark">
									<fmt:formatNumber pattern="#,###" value="${spread.exchangeMinInput}"/>&nbsp;단위
								</td>
							</tr>
						</c:otherwise>
						</c:choose>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="modal-footer border-top-0">
				<button type="button" class="btn bg-hanagreen text-white" style="width: 100px" data-bs-dismiss="modal">
					닫기
				</button>
			</div>
		</div>
	</div>
</div>
<%--이용안내 Modal--%>
<div class="modal fade " id="useInfo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title text-hanagreen text-center fs-3" id="useInfoLabel"><i class="fa-solid fa-book"></i>&nbsp;이용안내</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Open"></button>
				<br>
			</div>
			<div class="modal-body">
				<div class="row">
				<button class="form-control text-dark fs-5 p-3 box mb-1" style="background-color: #c2c2c2; font-family: dotomM" type="button" data-bs-toggle="collapse" data-bs-target="#useInfo01" aria-expanded="false" aria-controls="useInfo01">
					환전신청 및 결제
					<span class="float-end">
						▼
					</span>
				</button>
				<div class="collapse" id="useInfo01">
					<div class="card card-body border-2 text-dark" style="border-color: #c2c2c2;">
						<jsp:include page="../terms/exchangeInfo01.jsp"/>
					</div>
				</div>
				<button class="form-control fs-5 p-3 box mb-1 text-dark" style="background-color: #c2c2c2; font-family: dotomM" type="button" data-bs-toggle="collapse" data-bs-target="#useInfo02" aria-expanded="false" aria-controls="useInfo02">
					외화수령
					<span class="float-end">
						▼
					</span>
				</button>
				<div class="collapse" id="useInfo02">
					<div class="card card-body  border-2 text-dark" style="border-color: #c2c2c2;">
						<jsp:include page="../terms/exchangeInfo02.jsp"/>
					</div>
				</div>
				<button class="form-control text-dark fs-5 p-3 box mb-1" style="background-color: #c2c2c2;  font-family: dotomM" type="button" data-bs-toggle="collapse" data-bs-target="#useInfo03" aria-expanded="false" aria-controls="useInfo03">
					원화로 재환전 및 외화 계좌로 입금
					<span class="float-end">
						▼
					</span>
				</button>
				<div class="collapse" id="useInfo03">
					<div class="card card-body  border-2 text-dark" style="border-color: #c2c2c2;">
						<jsp:include page="../terms/exchangeInfo03.jsp"/>
					</div>
				</div>
					<button class="form-control text-dark fs-5 p-3 box" style="background-color: #c2c2c2; font-family: dotomM" type="button" data-bs-toggle="collapse" data-bs-target="#useInfo04" aria-expanded="true" aria-controls="useInfo04">
						기타 유의사항
						<span class="float-end">
						▼
					</span>
					</button>
					<div class="collapse" id="useInfo04">
						<div class="card card-body  border-2 text-dark" style="border-color: #c2c2c2;">
							<jsp:include page="../terms/exchangeInfo04.jsp"/>
						</div>
					</div>
			</div>
			</div>
			<div class="modal-footer border-top-0">
				<button type="button" class="btn bg-hanagreen text-white" style="width: 100px" data-bs-dismiss="modal">
					닫기
				</button>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../include/script.jsp"/>
<script>
	$('#useInfo01').collapse('show');
</script>
</body>
</html>