<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<title>환전원큐</title>
	<jsp:include page="../include/link.jsp"/>
	<link rel="stylesheet"
	      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<style>
        input::-webkit-inner-spin-button {
            appearance: none;
            -moz-appearance: none;
            -webkit-appearance: none;
        }

        .form-select:focus {
            outline: none !important;
            box-shadow: none !important;
        }
	</style>
</head>
<body>
<jsp:include page="../include/spinner.jsp"/>
<jsp:include page="../include/sidebar.jsp"/>
<a href="#" class="btn btn-lg bg-white border-0 btn-lg-square back-to-top"><i
		class="bi bi-arrow-up text-hanagreen"></i></a>
<div class="content">
	<jsp:include page="../include/navbar.jsp"/>
	<div class="ms-5 fs-5" style="color: #bdbdbd">환전지갑 / <strong style="color: #000000">외화배달신청</strong></div>
	<div class="container-fluid px-4 mt-4">
		<div class="row g-4">
			<div class="col-sm-12 col-md-12 col-xl-12">
				<div class="row bg-white rounded p-4 box mb-4">
					<div class="row justify-content-center bg-white text-center rounded p-4">
						<form action="/deliveryProcess" method="post">
						<table class="table table-hover mb-3 border-light">
							<thead>
							<tr>
								<th scope="col" class="h5 text-black-50 border-light" style="width: 15%">환전정보입력</th>
								<th scope="col" class="h5 text-dark border-light" style="width: 85%"></th>
							</tr>
							</thead>
							<tbody>
							<tr class="border-0">
								<th scope="row" class="text-center align-middle" style="background-color: #eeeeee">
									&nbsp;&nbsp;지갑번호
								</th>
								<td>
									<input class="form-control text-black-50" type="text" value="${walletNo}" name="walletNo" style="width: 15%; font-family: dotomM" readonly>
								</td>
							</tr>
							<tr class="border-0">
								<th scope="row" class="text-center align-middle" style="background-color: #eeeeee">
									&nbsp;&nbsp;수령신청통화
								</th>
								<td class="d-flex">
									<input class="form-control text-black-50 me-2" value="${cntryKrNm}&nbsp;${ccyCode}" name="ccyCode" style="width: auto; font-family: dotomM" readonly>
									<div class="text-black-50 align-self-center me-2"
									     style="font-size: 16px; font-family: dotomM;">
										보유금액
									</div>
									<input class="form-control me-2 text-hanagreen" value="<fmt:formatNumber value="${balance}" pattern="#,###"/>" name="reserveAmount" style="width: auto; font-family: dotomM" readonly>
								</td>
							</tr>
							<tr class="border-0">
								<th scope="row" class="text-center align-middle pt-2 pb-2"
								    style="background-color: #eeeeee">&nbsp;&nbsp;권종선택
								</th>
								<td class="d-flex">
									<div class="text-black-50 me-4 ms-2 align-self-center fs-5"
									     style="font-size: 16px;width: auto; font-family: dotomM">
										${ccyCode}
									</div>
									<div class="d-flex">
										<c:forEach items="${denominationList}" var="denomination" varStatus="d_status">
										<div class="text-black-50 me-2 align-self-center"
										     style="font-size: 16px; width: auto; font-family: dotomM">
											${denomination}
										</div>
										<select class="form-select me-2 selectGroup" style="border-color: #b0bec5" id="${denomination}" onchange="calculation_total()">
											<c:forEach begin="0" end="100" varStatus="status">
												<option class="ps-2 pe-2" value="${status.index}">
														${status.index}
												</option>
											</c:forEach>
										</select>
										</c:forEach>
									</div>
									<input class="ms-2 align-self-center text-center form-control pe-2 ps-2" id="sum" value="0" style="color: #2979ff;font-size: 16px; width: 7%;font-family: dotomM" readonly>
								</td>
							</tr>
							</tbody>
						</table>

						<table class="table table-hover mb-3 border-light">
							<thead>
							<tr>
								<th scope="col" class="h5 text-black-50 border-light" style="width: 15%">수령정보입력</th>
								<th scope="col" class="h5 text-dark border-light" style="width: 85%"></th>
							</tr>
							</thead>
							<tbody>
							<tr class="border-0">
								<th scope="row" class="text-center align-middle" style="background-color: #eeeeee">
									&nbsp;&nbsp;주소
								</th>
								<td>
									<div class="d-flex">
										<input class="form-wrapper__input form-control me-2 text-black-50"
										       id="postNumber" type="text" name="postNumber"
										       style="font-size: 16px;font-family: dotomM;width: 10%" readonly required>
										<button type="button" class="btn bg-white text-black-50 border-2 p-1 pe-2 ps-2 me-2"
										        style="border-color: #90a4ae!important;font-size: 16px;font-family: dotomM"
										        onclick="searchPostNumber()">우편번호 찾기
										</button>
										<button type="button" class="btn bg-white text-black-50 border-2 p-1 pe-2 ps-2"
										        style="border-color: #90a4ae!important;font-size: 16px;font-family: dotomM">
											기본주소
										</button>
									</div>
									<div class="mt-2">
										<input class="form-wrapper__input form-control w-50 text-black-50"
										       id="basicAddr" type="text" name="basicAddr"
										       style="font-size: 16px;font-family: dotomM" readonly required>
									</div>
									<div class="mt-2">
										<input class="form-wrapper__input form-control w-50 text-black-50"
										       id="detailAddr" type="text" name="detailAddr"
										       style="font-size: 16px;font-family: dotomM" placeholder="상세주소를 입력하세요."
										       required>
									</div>
									<label class="form-wrapper__label d-none" for="extraAddr">참고항목</label>
									<input id="extraAddr" class="form-wrapper__input d-none" type="text"
									       placeholder="참고항목을 입력하세요.">
								</td>
							</tr>
							<tr class="border-0">
								<th scope="row" class="text-center align-middle" style="background-color: #eeeeee">
									&nbsp;&nbsp;휴대전화
								</th>
								<td class="d-flex">
									<select class="form-select text-black-50" name="tel1" style="width: 8%; font-family: dotomM">
										<option value="010" selected>
											010
										</option>
										<option value="017">
											011
										</option>
										<option value="017">
											016
										</option>
										<option value="017">
											017
										</option>
										<option value="019">
											019
										</option>
									</select>
									<div class="align-self-center d-flex me-2 ms-2 text-black-50"
									     style="font-size: 16px; font-family: dotomM">
										-
									</div>
									<input class="form-control text-black-50" name="tel2" style="width: 8%; font-family: dotomM"
									       value="${member.tel.substring(3,7)}">
									<div class="align-self-center d-flex me-2 ms-2 text-black-50"
									     style="font-size: 16px; font-family: dotomM">
										-
									</div>
									<input class="form-control text-black-50" name="tel3" style="width: 8%; font-family: dotomM"
									       value="${member.tel.substring(7,11)}">
								</td>
							</tr>
							<tr class="border-0">
								<th scope="row" class="text-center align-middle pt-2 pb-2"
								    style="background-color: #eeeeee">&nbsp;&nbsp;배송희망일
								</th>
								<td>
									<div class="mb-2" style="width: 15%!important;">
										<div class="row form-group">
											<div class="input-group date" id="datepicker">
												<input class="form-control text-black-50 " name="receiptDate" type="text" id="receipt_date"
												       style="font-size: 16px; font-family: dotomM">
												<span class="input-group-append">
                                                            <span class="input-group-text bg-white d-block border-0">
                                                                <i class="fa fa-calendar fs-4 pt-1 text-hanagreen"></i>
                                                            </span>
												</span>
											</div>
										</div>
									</div>
									<div class="ms-1 text-black-50 mb-2" style="font-size: 16px;font-family: dotomM">
										<i class="fa-solid fa-exclamation text-hanared"></i>&nbsp;신청일 기준 3영업일 ~ 15영업일
										이내로 선택 가능합니다.
									</div>
									<div class="ms-1 text-black-50" style="font-size: 16px;font-family: dotomM">
										<i class="fa-solid fa-exclamation text-hanared"></i>&nbsp;배송 희망일이 임시공휴일로 지정 시
										익영업일에 배송됩니다.
									</div>
								</td>
							</tr>
							</tbody>
						</table>
						<div class="container-fluid bg-white mt-3 mb-5">
								<span class="float-start text-light" style="text-align: left">
									배송비<br>
									- 무료 ~ 고객부담(3,000원)<br>
									- (USD 600 달러 상당액 이상 환전 시 면제)<br>
									<br>
									배송 지역<br>
									- 전국 (단, 일부 도서산간지역 등 우체국 배송이 불가한 지역은 제외)<br>
									<br>
									외화수령<br>
									- 본인 수령만 가능(대리인 수령 불가, 신청금액과 권종 및 매수 확인 후 수령 가능)<br>
									- 외화 수령 시 본인 신분증 및 환전 메시지(SMS) 필요
								</span>
							<button class="btn bg-hanagreen text-white float-end" style="width: 100px; height: 50px" type="submit">신청하기
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
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/script.jsp"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    $('#datepicker').datepicker({
        format: 'yyyy-mm-dd', //데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
        startDate: '+3d',
        endDate: '+15d',
        autoclose: true,
        title: '배송희망일',
        todayHighlight: true,
        language: "ko",
    });

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

    function calculation_total() {
        let sum = 0;
        $(".selectGroup").each(function(){
            // sum += $(this).id * $(this).text();
            sum += $(this).attr('id') * $(this).val()
        });
        $('#sum').val(sum.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","))
    }
</script>
</body>
</html>
