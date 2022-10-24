<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>환전원큐</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css"/>
	<link href="/resources/css/loginstyle.css" rel="stylesheet">
	<script src="/resources/js/joinAccountView.js"></script>
	<script>
        function checkForm() {
            let form = document.registerForm;
            if (form.id.value == '') {
                form.id.focus();
                alert("아이디를 입력하세요.")
                return false;
            }
            if (form.password.value == '') {
                form.password.focus();
                alert("비밀번호를 입력하세요.")
                return false;
            }
            if (form.name.value == '') {
                form.name.focus();
                alert("이름을 입력하세요.")
                return false;
            }
            if (form.emailID.value == '') {
                form.emailID.focus();
                alert("이메일주소를 입력하세요.")
                return false;
            }
            if (form.tel.value == '') {
                form.tel.focus();
                alert("전화번호를 입력하세요.")
                return false;
            }
            if (form.tel.value.length != 11) {
                form.tel.focus();
                alert("전화번호를 입력하세요.")
                return false;
            }
            if (form.postNumber.value == '') {
                form.postNumber.focus();
                alert("우편번호를 입력하세요.")
                return false;
            }
            if (form.basicAddr.value == '') {
                form.basicAddr.focus();
                alert("주소를 입력하세요.")
                return false;
            }
            if (form.detailAddr.value == '') {
                form.detailAddr.focus();
                alert("상세주소를 입력하세요.")
                return false;
            }
            form.onsubmit;
        }

        function searchPostNumber() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if (data.userSelectedType === 'R') {
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if (data.buildingName !== '' && data.apartment === 'Y') {
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if (extraAddr !== '') {
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        document.getElementById("extraAddr").value = extraAddr;

                    } else {
                        document.getElementById("extraAddr").value = '';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postNumber').value = data.zonecode;
                    document.getElementById("basicAddr").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("detailAddr").focus();
                }
            }).open();
        }
	</script>
</head>
<body class="body">
<section class="form-container">
	<span id="arrowClick" class="form-container__arrow"><i class="fa fa-arrow-circle-left"
	                                                       aria-hidden="true"></i></span>
	<div class="overlay"></div>
	<div class="choose-form">
		<div class="title">
			<h1 class="title__h1">환전원큐<br>모임통장초대</h1>
			<h2 class="title__h2">${ownerName}님의 모임통장 초대입니다.</h2>
			<h2 class="title__h2">로그인 시 모임통장 참여</h2>
		</div>
		<div class="buttons">
			<a id="signUp" class="buttons__signup" href="#">회원가입</a>
			<a id="login" class="buttons__signup buttons__signup--login" href="#">로그인</a>
		</div>
	</div>
	<!-- Login Form -->
	<div class="login-form">
		<div class="form-wrapper">
			<form action="/joinAccountProcess" method="post">
				<label class="form-wrapper__label" for="login-username">아이디</label>
				<input id="login-username" class="form-wrapper__input" type="text"
				       placeholder="아이디를 입력하세요." name="id" required>
				<label class="form-wrapper__label" for="login-password">비밀번호</label>
				<input id="login-password" class="form-wrapper__input" type="password"
				       placeholder="비밀번호를 입력하세요." name="password"
				       title="Password must contain at least 3 characters" required>
				<input type="hidden" name="accountNo" value="${accountNo}"/>
				<a class="login-form__forgot-password" href="#">비밀번호를 잊으셨나요?</a>
				<button class="buttons__signup buttons__signup--login-form" type="submit">로그인</button>
			</form>

			<!-- Social-Media -->

			<div class="social-media">
				<h6 class="title__h2">Or connect with</h6>
				<a class="buttons__signup buttons__signup--social" href="#"><i class="fab fa-facebook-f"
				                                                               aria-hidden="true"></i>&nbsp;kakao</a>
				<a class="buttons__signup buttons__signup--social" href="#"><i class="fab fa-google"
				                                                               aria-hidden="true"></i>&nbsp;google</a>
			</div>
		</div>
	</div>

	<!-- Register Form -->
	<div class="login-form login-form--register">
		<div class="form-wrapper" style="height: 700px !important;">
			<form action="/registerProcess" method="post">
				<label class="form-wrapper__label" for="memberID">아이디</label>
				<input id="memberID" class="form-wrapper__input" type="text"
				       placeholder="아이디를 입력하세요." name="id" required>
				<label class="form-wrapper__label" for="memberPassword">비밀번호</label>
				<input id="memberPassword" class="form-wrapper__input" type="password"
				       placeholder="password를 입력하세요." name="password" required>
				<label class="form-wrapper__label" for="memberPassword2">비밀번호확인</label>
				<input id="memberPassword2" class="form-wrapper__input" type="password"
				       placeholder="password를 입력하세요." required>
				<label class="form-wrapper__label" for="memberName">이름</label>
				<input id="memberName" class="form-wrapper__input" type="text"
				       placeholder="이름을 입력하세요." name="name" required>

				<label class="form-wrapper__label" for="emailID">이메일</label>
				<input id="emailID" class="form-wrapper__input" type="email"
				       placeholder="example@hotmail.com" name="email" required>

				<label class="form-wrapper__label" for="tel">전화번호</label>
				<input id="tel" class="form-wrapper__input" type="text"
				       placeholder="전화번호를 입력하세요(숫자만)" name="tel" maxlength="11" required>
				<div class="row">
					<div class="col-7">
						<label class="form-wrapper__label" for="postNumber">우편번호</label>
						<input id="postNumber" class="form-wrapper__input" type="text"
						       placeholder="우편번호" name="postNumber" required>
					</div>
					<div class="col-5">
						<button type="button" class="btn btn-lg btn-primary p-1" style="font-size: 12px"
						        onclick="searchPostNumber()">우편번호 찾기
						</button>
					</div>
				</div>
				<label class="form-wrapper__label" for="basicAddr">기본주소</label>
				<input id="basicAddr" class="form-wrapper__input" type="text"
				       placeholder="주소를 입력하세요." name="basicAddr" required>
				<label class="form-wrapper__label" for="detailAddr">상세주소</label>
				<input id="detailAddr" class="form-wrapper__input" type="text"
				       placeholder="상세주소를 입력하세요." name="detailAddr" required>
				<label class="form-wrapper__label d-none" for="extraAddr">참고항목</label>
				<input id="extraAddr" class="form-wrapper__input d-none" type="text"
				       placeholder="참고항목을 입력하세요.">

				<button class="buttons__signup buttons__signup--sign-up-form" type="submit">회원가입
				</button>
			</form>
		</div>
	</div>
</section>
</body>
</html>
