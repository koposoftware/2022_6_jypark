<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>환전원큐</title>
	<jsp:include page="../include/link.jsp"/>
</head>
<body>
<div class="container-fluid position-relative d-flex p-0">
	<jsp:include page="../include/spinner.jsp"/>
	<jsp:include page="../include/sidebar.jsp"/>
	<a href="#" class="btn btn-lg bg-white border-0 btn-lg-square back-to-top"><i
			class="bi bi-arrow-up text-hanagreen"></i></a>
	<div class="content">
		<jsp:include page="../include/navbar.jsp"/>
		<div class="ms-5 fs-5" style="color: #bdbdbd">모임통장 / <strong style="color: #000000">거래내역</strong></div>
		<div class="container-fluid px-4 mt-4">
			<div class="row g-4">
				<div class="col-sm-12 col-md-12 col-xl-12">
					<div class="row bg-white rounded p-4 box mb-4">
						<div class="row justify-content-center bg-white text-center rounded p-4" method="post"
						     name="transferForm">
							<table class="table table-hover mb-3 border-light">
								<thead>
								<tr>
									<th scope="col" class="h5 text-black-50 border-light" style="width: 15%">조회정보</th>
									<th scope="col" class="h5 text-dark border-light" style="width: 85%"></th>
								</tr>
								</thead>
								<tbody>
								<tr class="text">
									<th scope="row" class="text-center align-middle">&nbsp;&nbsp;계좌선택</th>
									<td>
										<select class="form-select border-3 w-50" name="withdrawAccountNo"
										        id="selectAccountForm"
										        onchange="changeBallance()" style="height: 55px;">
											<option value="" selected disabled>계좌를 선택하세요.</option>
											<c:forEach items="${accountList}" var="account">
												<option value="${account.accountNo}">
														${account.alias} (${account.accountNo})
												</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row" class="text-center align-middle">&nbsp;&nbsp;조회기간</th>
									<td>
										<input class="form-control" type="text" id="demo" name="demo" value=""/>
									</td>
								</tr>
								<tr>
									<th scope="row" class="text-center align-middle">&nbsp;&nbsp;거래유형</th>
									<td>
										<button type="button"
										        class="btn bg-white text-light border-1 opacity me-2 pushButton border-2"
										        style="border-color: #f5f5f5">전체(입금 +
											출금)
										</button>
										<button type="button"
										        class="btn bg-white text-light border-1 opacity me-2 pushButton border-2"
										        style="border-color: #f5f5f5">입금
										</button>
										<button type="button"
										        class="btn bg-white text-light border-1 opacity me-2 pushButton border-2"
										        style="border-color: #f5f5f5">출금
										</button>
									</td>
								</tr>
								</tbody>
							</table>
							<div class="container-fluid bg-white mt-3 mb-5">
								<span class="float-start text-light" style="text-align: left">
									- 최근 1년간의 거래내역조회가 가능합니다.<br>
									&nbsp;(단, 입출금이 자유로운 예금일 경우, 거래량에 따라 약 최근 3개월 전부터 조회가 가능합니다.)<br>
									- 추가 거래내역은 과거거래내역 조회를 이용하시기 바랍니다.<br>
									- 추가입력 메모는 적요 및 메모와 다르게 거래이후 자유롭게 작성 및 편집이 가능합니다.
								</span>
								<button class="btn bg-hanagreen text-white float-end" style="width: 100px; height: 50px"
								        onclick="getTransactionList()" href="">조회
								</button>
							</div>
							<table class="table table-hover border-white mb-5 d-none" id="showTable">
								<thead>
								<tr>
									<th scope="col" class="h5 text-center" style="width: 15%; color: #6C7293">거래일시</th>
									<th scope="col" class="h5 text-center" style="width: 15%; color: #6C7293">적요</th>
									<th scope="col" class="h5 text-center" style="width: 15%; color: #6C7293">거래금액</th>
									<th scope="col" class="h5 text-center" style="width: 15%; color: #6C7293">잔액</th>
								</tr>
								</thead>

								<tbody class="border-1" id="tbody">
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/script.jsp"/>
</body>
</html>
