<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
		<div class="container-fluid px-4">
			<div class="row g-4">
				<div class="col-sm-12 col-md-12 col-xl-12">
					<form class="row justify-content-center bg-white text-center rounded p-4 box"
					      action="/openAccountProcess" method="post">
						<div class="ms-5 fs-3 mb-3">모임통장개설<strong></strong></div>
						<div class="form-floating mb-3 col-sm-9 col-md-9 col-xl-9">
							<input class="form-control text-light" type="text" placeholder="계좌 별칭" name="alias"
							       id="alias" maxlength="15">
							<label for="password">&nbsp; 계좌별칭</label>
						</div>
						<div class="form-floating mb-3 col-sm-9 col-md-9 col-xl-9">
							<input class="form-control text-light" type="password" placeholder="통장 비밀번호" name="password"
							       id="password" maxlength="4">
							<label for="password">&nbsp; 비밀번호</label>
						</div>
						<div class="w-100"></div>
						<div class="form-floating mb-3 col-sm-9 col-md-9 col-xl-9 text-center">
							<input class="form-control" type="password" placeholder="통장 비밀번호 재확인" id="repassword"
							       maxlength="4">
							<label for="repassword">&nbsp; 비밀번호재확인</label>
						</div>
						<div class="form-floating mb-3 col-sm-9 col-md-9 col-xl-9">
							<div class="d-flex form-control w-100 bg-white justify-content-between h-100 mb-3">
								<div class="col-sm-1 col-md-1 col-xl-1 text-center fs-6">
									개설목적
								</div>
								<div class="col-sm-2 col-md-2 col-xl-2 text-center">
									<label for="first">입출금통장</label>
									<input type="checkbox" id="first" style="width: 15px; height: 15px" onclick="clickCheck(this)">
								</div>
								<div class="col-sm-2 col-md-2 col-xl-2 text-center">
									<label for="second">데이트모임통장</label>
									<input type="checkbox" id="second" style="width: 15px; height: 15px" onclick="clickCheck(this)">
								</div>
								<div class="col-sm-2 col-md-2 col-xl-2 text-center">
									<label for="third">여행모임통장</label>
									<input type="checkbox" id="third" style="width: 15px; height: 15px" onclick="clickCheck(this)">
								</div>
								<div class="col-sm-2 col-md-2 col-xl-2 text-center">
									<label for="four">기타</label>
									<input type="checkbox" id="four" style="width: 15px; height: 15px" onclick="clickCheck(this)">
								</div>
							</div>
						</div>
						<div class="mb-1 col-sm-9 col-md-9 col-xl-9">
							<textarea class="w-100 form-control bg-white" cols="10" rows="10" style="resize: none"
							          readonly>
								<jsp:include page="../terms/joinAccount.jsp"/>
							</textarea>
						</div>
						<div class="col-sm-9 col-md-9 col-xl-9">
							<div class="d-flex h-50 rounded-3 p-4 align-items-center form-control bg-white justify-content-between">
								<span class="fs-6 text-light">약관에 동의하시겠습니까?</span>
								<input type="checkbox" id="checkbox1" style="width: 15px; height: 15px">
							</div>
						</div>
						<div class="mb-1 col-sm-9 col-md-9 col-xl-9">
							<textarea class="w-100 form-control bg-white" cols="10" rows="10" style="resize: none"
							          readonly>
								<jsp:include page="../terms/joinAccount.jsp"/>
							</textarea>
						</div>
						<div class="col-sm-9 col-md-9 col-xl-9">
							<div class="d-flex h-50 rounded-3 p-4 align-items-center form-control bg-white justify-content-between">
								<span class="fs-6 text-light">약관에 동의하시겠습니까?</span>
								<input type="checkbox" id="checkbox2" style="width: 15px; height: 15px">
							</div>
						</div>
						<div class="mb-1 col-sm-9 col-md-9 col-xl-9">
							<textarea class="w-100 form-control bg-white" cols="10" rows="10" style="resize: none"
							          readonly>
								<jsp:include page="../terms/joinAccount.jsp"/>
							</textarea>
						</div>
						<div class="col-sm-9 col-md-9 col-xl-9">
							<div class="d-flex h-50 rounded-3 p-4 align-items-center form-control bg-white justify-content-between">
								<span class="fs-6 text-light">약관에 동의하시겠습니까?</span>
								<input type="checkbox" id="checkbox3" style="width: 15px; height: 15px">
							</div>
						</div>
						<div class="col-sm-9 col-md-9 col-xl-9">
							<button class="form-control rounded-3 p-3 opacity"
							        style="background-color: #f5f5f5" type="submit"> 계좌개설
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
    function clickCheck(target) {
        document.querySelectorAll(`input[type=checkbox]`)
            .forEach(el => el.checked = false);

        target.checked = true;
    }
</script>
<jsp:include page="../include/script.jsp"/>
</body>
</html>
