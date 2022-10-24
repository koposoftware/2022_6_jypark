<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>환전원큐</title>
	<jsp:include page="../include/link.jsp"/>
</head>
<body>
<div class="container-fluid position-relative d-flex p-0">
	<jsp:include page="../include/sidebar.jsp"/>
	<a href="#" class="btn btn-lg bg-white border-0 btn-lg-square back-to-top"><i class="bi bi-arrow-up text-hanagreen"></i></a>
	<div class="content">
		<jsp:include page="../include/navbar.jsp"/>
		<div class="ms-5 fs-5">모임통장/<strong>계좌이체</strong></div>
		<div class="container-fluid px-4 mt-4">
			<div class="row g-4">
				<div class="col-sm-12 col-md-12 col-xl-12">
					<form action="transferProcess" class="row justify-content-center bg-white text-center rounded p-4" method="post" name="transferForm" onsubmit="return checkForm()">
						<table class="table table-hover mb-5 border-light">
							<thead>
							<tr>
								<th scope="col" class="h5 text-black-50 border-light" style="width: 15%">출금정보</th>
								<th scope="col" class="h5 text-dark border-light" style="width: 85%"></th>
							</tr>
							</thead>
							<tbody>
							<tr class="text">
								<th scope="row" class="text-center align-middle">&nbsp;&nbsp;계좌선택</th>
								<td>
									<select class="form-select border-1 w-50" name="withdrawAccountNo" id="selectAccountForm"
									        onchange="changeBallance()" style="height: 55px;">
										<option value="" selected disabled>계좌를 선택하세요.</option>
										<c:forEach items="${accountList}" var="account">
											<option value="${account.accountNo}" value2="${account.balance}">${account.accountNo}
												[${account.alias}]
											</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row" class="text-center align-middle">&nbsp;&nbsp;계좌잔액</th>
								<td>
									<input type="text" id="balance" class="form-control w-25" readonly>
								</td>
							</tr>
							<tr>
								<th scope="row" class="text-center align-middle">&nbsp;&nbsp;출금 비밀번호</th>
								<td><input type="password" name="password" class="form-control w-25" maxlength="4" minlength="4" placeholder="4자리비밀번호"></td>
							</tr>
							</tbody>
						</table>

						<table class="table table-hover border-light">
							<thead>
							<tr>
								<th scope="col" class="h5 text-black-50 border-light" style="width: 15%">입금정보</th>
								<th scope="col" class="h5 text-dark border-light" style="width: 85%"></th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<th scope="row" class="text-center align-middle">&nbsp;&nbsp;은행선택</th>
								<td>
									<select class="form-select border-1 w-50" name="depositBankCode" style="height: 55px;">
										<option value="" selected disabled>은행을 선택하세요.</option>
										<option value="환전원큐">환전원큐</option>
										<option value="하나은행">하나은행</option>
										<option value="국민은행">국민은행</option>
										<option value="신한은행">신한은행</option>
										<option value="농협뱅크">농협뱅크</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row" class="text-center align-middle">&nbsp;&nbsp;계좌번호</th>
								<td><input type="text" name="depositAccountNo" class="form-floating form-control w-50" maxlength="15"></td>
							</tr>
							<tr>
								<th scope="row" class="text-center align-middle">&nbsp;&nbsp;이체금액</th>
								<td><input type="number" name="transferAmount" class="form-control w-25"></td>
							</tr>
							<tr>
								<th scope="row" class="text-center align-middle">&nbsp;&nbsp;받는 분 통장 표시</th>
								<td><input type="text" name="depositTransMemo" class="form-control w-50"
								           value="${loginMember.name}"></td>
							</tr>
							<tr>
								<th scope="row" class="text-center align-middle">&nbsp;&nbsp;내 통장 표시</th>
								<td><input type="text" name="withdrawTransMemo" class="form-control w-50"
								           value="${loginMember.name}"></td>
							</tr>
							</tbody>
						</table>
						<button type="submit" id="transBtn" class="btn w-100 py-3 px-5 mt-3 text-black-50 border-0" style="background-color: #f5f5f5">이체하기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
<jsp:include page="../include/script.jsp"/>
<script>
    // 계좌잔액 변경
    function changeBallance() {
        var selectAccountBalance = $("#selectAccountForm > option:selected").attr("value2");
        $("#balance").val(selectAccountBalance.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원");
    }

    function checkForm() {
        let form = document.transferForm;
        var selectAccountBalance = $("#selectAccountForm > option:selected").attr("value2");
        if (form.withdrawAccountNo.value == '') {
            form.withdrawAccountNo.focus();
            alert("출금계좌를 선택하세요.")
            return false;
        }
        if (form.password.value == '') {
            form.password.focus();
            alert("출금 비밀번호를 입력하세요.")
            return false;
        }
        if (form.depositBankCode.value == '') {
            form.depositBankCode.focus();
            alert("입금 은행을 선택하세요.")
            return false;
        }
        if (form.depositAccountNo.value == '') {
            form.depositAccountNo.focus();
            alert("입금 계좌번호를 입력하세요.")
            return false;
        }
        if (form.transferAmount.value == '') {
            form.transferAmount.focus();
            alert("이체 금액을 입력하세요.")
            return false;
        }
        if (parseInt(form.transferAmount.value) > parseInt(selectAccountBalance)) {
            form.transferAmount.focus();
            alert("입력금액이 계좌잔액을 초과했습니다.");
            return false;
        }
        form.onsubmit;
    }
</script>
</body>
</html>