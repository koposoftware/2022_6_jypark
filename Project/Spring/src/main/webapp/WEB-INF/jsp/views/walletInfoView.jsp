<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd H:mm:ss");
%>
<html>
<head>
	<title>환전원큐</title>
	<jsp:include page="../include/link.jsp"/>
	<style>
        body {
            font-family: hanaM;
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
		<div class="ms-5 fs-5" style="color: #bdbdbd">환전지갑 / <strong style="color: #000000">환전내역</strong></div>
		<div class="container-fluid pt-4 px-4">
			<div class="row g-4 p-2">
				<div class="col-sm-12 col-xl-12 p-0" style=" background-color: #eceff1">
					<div class="d-flex">
						<div class="col-5 bg-white border-5 border-top box p-4 rounded"
						     style="border-color: #008485 !important; max-height: 200px;">
							<div class="d-flex mt-3 justify-content-between">
								<span class="fs-5 text-black-50" style="font-family: dotom">
									${loginMember.name}님 보유금액
								</span>
								<span class="fs-6 text-hanasilver pt-1" style="font-family: dotom">
									<%= sf.format(nowTime) %> 고시환율 기준
								</span>
							</div>
							<div class="mt-3 fs-5" style="color:#494949; font-family: hanaM">
								USD 환산
							</div>
							<div class="fs-3" id="usd_rate" value="">
							</div>
						</div>
						<div class="col-7 p-3 ms-0 d-flex row" id="radio_Group" style="background-color: #eceff1">
							<c:forEach items="${walletAccountList}" var="walletAccount" varStatus="status">
								<c:choose>
									<c:when test="${status.index eq 0}">
										<div class="border border-4 p-2 rounded box mb-2 bg-white col-3 me-3"
										     style="border-color: #e0e0e0 !important;">
											<div class="form-check">
												<input class="form-check-input mt-2" type="radio"
												       name="flexRadioDefault" id="${walletAccount.walletNo}"
												       autocomplete="off" value="${walletAccount.walletNo}" checked>
												<label class="form-check-label fs-6 text-black-50 w-100"
												       for="${walletAccount.walletNo}" style="font-family: hanaM">
													<div>
														<div class="border-bottom text-black-50 fs-5"
														     style="font-family: hanaM">
															지갑${status.index + 1}
														</div>
														<div class="mt-3" style="font-family: hanaM">
															지갑번호
														</div>
														<div>
																${walletAccount.walletNo.substring(0, 3)}-${walletAccount.walletNo.substring(3,9)}-${walletAccount.walletNo.substring(9,14)}
														</div>
														<div class="mt-2" style="font-family: hanaM">
															연동계좌&nbsp;<i class="fa-solid fa-link text-hanagreen fa-fade"
															             style="--fa-animation-duration: 2s"></i>
														</div>
														<div class="pb-1">
																${walletAccount.accountAlias}
														</div>
													</div>
												</label>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="border border-4 p-2 rounded box mb-2 bg-white col-3 me-3"
										     style="border-color: #e0e0e0 !important;">
											<div class="form-check">
												<input class="form-check-input mt-2" type="radio"
												       name="flexRadioDefault" id="${walletAccount.walletNo}"
												       value="${walletAccount.walletNo}">
												<label class="form-check-label fs-6 text-black-50 w-100"
												       for="${walletAccount.walletNo}" style="font-family: hanaM">
													<div class="border-bottom text-black-50 fs-5"
													     style="font-family: hanaM">
														지갑${status.index + 1}
													</div>
													<div class="mt-3" style="font-family: hanaM">
														지갑번호
													</div>
													<div>
															${walletAccount.walletNo.substring(0, 3)}-${walletAccount.walletNo.substring(3,9)}-${walletAccount.walletNo.substring(9,14)}
													</div>
													<div class="mt-2" style="font-family: hanaM">
														연동계좌&nbsp;<i class="fa-solid fa-link text-hanagreen fa-fade"
														             style="--fa-animation-duration: 2s"></i>
													</div>
													<div class="pb-1">
															${walletAccount.accountAlias}
													</div>
												</label>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="col-12 d-flex p-0" style="background-color: #eceff1; border-radius: 10px 10px 0px 0px">
					<button id="hold_history" type="button"
					        class="col-4 text-center border-0 pt-3 pb-3 fs-5 bg-hanagreen"
					        style="font-family: hanaM; color: #ffffff; border-radius: 10px 0px 0px 0px"
					        onclick="click_hold_history()">
						전체내역
					</button>
					<button id="hold_ccy" type="button" class="col-4 text-center border-0 pt-3 pb-3 fs-5"
					        style="font-family: hanaM; color: #8d8d8d" onclick="click_hold_ccy()">
						통화별 보유내역
					</button>
					<button id="exchange_reservation" type="button" class="col-4 text-center border-0 pt-3 pb-3 fs-5"
					        style="font-family: hanaM; color: #8d8d8d; border-radius: 0px 10px 0px 0px"
					        onclick="click_exchange_reservation()">
						예약내역
					</button>
				</div>
				<div class="col-12 bg-white mt-0 mb-4 pb-4" id="div_hold_history"
				     style="min-height: 350px; border-radius: 0px 0px 10px 10px">

				</div>
				<div class="col-12 bg-white mt-0 mb-4 d-none" id="div_hold_ccy"
				     style="min-height: 350px; border-radius: 0px 0px 10px 10px">
				</div>
				<div class="col-12 bg-white mt-0 mb-4 d-none" id="div_exchange_res"
				     style="min-height: 350px; border-radius: 0px 0px 10px 10px">

				</div>
<%--				예약신청을 위한 숨겨진 form--%>
				<form class="d-none" id="deliveryForm" action="/postDeliveryForm" method="post">
					<input type="text" id="delivery_walletNo" name="walletNo" value="">
					<input type="text" id="delivery_ccyCode" name="ccyCode" value="">
				</form>
			</div>
		</div>
	</div>
</div>
<%-- 계좌선택 Modal--%>
<div class="modal fade " id="chooseAccount" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header p-3">
				<h5 class="modal-title text-dark text-center fs-3 ms-3" style="font-family: dotomM">&nbsp;환전하기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				<br>
			</div>
			<div class="modal-body mt-0">
				<div class="col-12 p-4 pt-0">
					<div>
						<div class="mb-3 fs-5 text-center" style="color: #424242; font-family: hanaM">
							입금하실 계좌를 선택하세요.
						</div>
						<div class="col-12 border-5 border-top d-flex pt-4" style="border-color: #008485 !important;">
							<div class="col-5 row text-center">
								<div id="m_sellContryFlag">

								</div>
								<div class="mt-1 text-black-50" id="m_sellContryNm" style="font-family: hanaM">

								</div>
								<div id="m_sellAmount" style="color: #616161;font-family: hanaM">

								</div>
							</div>
							<div class="col-2">
								<i class="fa-solid fa-angles-right fa-fade fs-1 text-hanagreen"
								   style="--fa-animation-duration: 2s"></i>
							</div>
							<div class="col-5 row text-center">
								<div id="m_buyContryFlag">

								</div>
								<div class="mt-1 text-black-50" id="m_buyContryNm" style="font-family: hanaM">

								</div>
								<div id="m_buyAmount" style="color: #616161;font-family: hanaM">

								</div>
							</div>
						</div>
						<div class="col-12 text-center rounded mt-4 pt-2 pb-2 d-flex" style="background-color: #eeeeee">
							<div class="col-6 row m-0">
								<div style="font-family: hanaM">
									적용환율
								</div>
								<div style="font-family: hanaM">
									우대율
								</div>
							</div>
							<div class="col-6 row m-0">
								<div id="m_apply_ExcRate" style="font-family: hanaM">

								</div>
								<div id="m_event_spreadRate" style="font-family: hanaM">

								</div>
							</div>
						</div>
						<hr>
						<div class="col-12 d-flex justify-content-between mb-2">
							<div class="text-black-50 fs-6" style="font-family: hanaM">
								입금은행
							</div>
							<div class="col-8 ps-2">
								환전원큐 계좌 입금
							</div>
						</div>
						<div class="col-12 d-flex justify-content-between mb-1">
							<div class="text-black-50 fs-6 pt-2" style="font-family: hanaM">
								입금계좌
							</div>
							<div class="col-8">
								<select class="form-select w-100" id="select_account" onchange="choiceAccount()">
									<option selected disabled>
										계좌를 선택하세요.
									</option>
									<c:forEach items="${accountList}" var="account">
										<option accountNo="${account.accountNo}" balance="${account.balance}">
												${account.accountNo}(${account.alias})
										</option>
									</c:forEach>
								</select>
								<div class="text-end text-hanagreen mt-1" id="accountBalance">
								</div>
							</div>
						</div>
						<div class="col-12 d-flex justify-content-between">
							<div class="text-black-50 fs-6" style="font-family: hanaM">
								예금주명
							</div>
							<div class="col-8 ps-2" id="ownerId" style="font-family: hanaM">

							</div>
						</div>
						<hr>
						<div class="col-12 text-danger mb-4 d-flex">
							<div class="ms-2 pt-1" style="width: 10px; height: 10px">
								<i class="fa-solid fa-exclamation fa-fade"></i>
							</div>
							<div>
								원화로 재환전 거래시에는 현찰파실때 환율이 적용됩니다.
							</div>
						</div>
					</div>
					<div class="d-flex w-100 justify-content-center">
						<form action="/exchangeProcess" method="post">
							<button type="button" class="btn bg-hanasilver text-white me-2 p-2"
							        style="width: 100px; font-family: hanaM"
							        data-bs-dismiss="modal">
								이전
							</button>
							<input class="d-none" id="walletNo" name="walletNo" type="text" value="">
							<input class="d-none" id="accountNo" name="accountNo" type="text" value="">
							<input class="d-none" id="sellCcyCode" name="sellCcyCode" type="text" value="">
							<input class="d-none" id="sellCntryKrNm" name="sellCntryKrNm" type="text" value="">
							<input class="d-none" id="sellAmount" name="sellAmount" type="number" value="">
							<input class="d-none" id="buyCcyCode" name="buyCcyCode" type="text" value="">
							<input class="d-none" id="buyAmount" name="buyAmount" type="number" value="">
							<input class="d-none" id="buyCntryKrNm" name="buyCntryKrNm" type="text" value="">
							<input class="d-none" id="applyExchangeRate" name="applyExchangeRate" type="number"
							       value="">
							<input class="d-none" id="eventSpreadRate" name="eventSpreadRate" type="number" value="">
							<button type="submit" class="btn bg-hanagreen text-white p-2"
							        style="width: 100px; font-family: hanaM">
								환전하기
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/script.jsp"/>
<script>
    window.onload = function () {
        ajax_hold_history();
        ajax_hold_currency();
        ajax_exc_reservation();
    }

    const hold_history = document.getElementById('hold_history');
    const hold_ccy = document.getElementById('hold_ccy');
    const exchange_reservation = document.getElementById('exchange_reservation');

    const div_hold_history = document.getElementById('div_hold_history');
    const div_hold_ccy = document.getElementById('div_hold_ccy');
    const div_exchange_res = document.getElementById('div_exchange_res');

    function click_hold_history() {
        hold_history.classList.add('bg-hanagreen')
        hold_ccy.classList.remove('bg-hanagreen');
        exchange_reservation.classList.remove('bg-hanagreen');
        hold_history.style.color = '#ffffff'
        hold_ccy.style.color = '#8d8d8d'
        exchange_reservation.style.color = '#8d8d8d'
        div_hold_history.classList.remove('d-none');
        div_hold_ccy.classList.add('d-none');
        div_exchange_res.classList.add('d-none');
    }

    function click_hold_ccy() {
        hold_history.classList.remove('bg-hanagreen')
        hold_ccy.classList.add('bg-hanagreen');
        exchange_reservation.classList.remove('bg-hanagreen');
        hold_history.style.color = '#8d8d8d'
        hold_ccy.style.color = '#ffffff'
        exchange_reservation.style.color = '#8d8d8d'
        div_hold_history.classList.add('d-none');
        div_hold_ccy.classList.remove('d-none');
        div_exchange_res.classList.add('d-none');
    }

    function click_exchange_reservation() {
        hold_history.classList.remove('bg-hanagreen')
        hold_ccy.classList.remove('bg-hanagreen');
        exchange_reservation.classList.add('bg-hanagreen');
        hold_history.style.color = '#8d8d8d'
        hold_ccy.style.color = '#8d8d8d'
        exchange_reservation.style.color = '#ffffff'
        div_hold_history.classList.add('d-none');
        div_hold_ccy.classList.add('d-none');
        div_exchange_res.classList.remove('d-none');
    }

    $(document).on('click', '#radio_Group', function () {
        ajax_hold_history();
        ajax_hold_currency();
        ajax_exc_reservation();
        let r_walletNo = $('#radio_Group input:radio:checked').val();
        document.getElementById('delivery_walletNo').setAttribute('value', r_walletNo);
    })

    function choiceAccount() {
        let selectAccountNo = $('#select_account > option:selected').attr('accountNo').replaceAll('-', '');
        document.getElementById('accountNo').setAttribute('value', selectAccountNo);
        document.getElementById('ownerId').innerText += ''
        document.getElementById('ownerId').innerText += '박하나'
    }

    function ajax_hold_history() {
        let r_walletNo = $('#radio_Group input:radio:checked').val();
        $.ajax({
            url: "/getExcHistory",
            type: "Post",
            data: {
                walletNo: r_walletNo
            },
            success: function (data) {
                if (data.length == 0) {
                    change_hold_history(0);
                } else {
                    change_hold_history(data);
                }
            }
        })
    }

    function change_hold_history(data) {
        $('#div_hold_history').empty();
        if (data == 0) {
            $('#div_hold_history').append('<div class="fs-3 w-100 h-100 text-black-50" style="display: flex; align-items: center; justify-content: center; font-family: hanaM">보유내역이 없습니다.</div>');
        } else {
            let str = ''
            str += '<table class="table border-0 table-hover text-end mt-3 border-top">'
            str += '<colgroup><col width=20%><col width=20%><col width=20%><col width=20%><col width=20%></colgroup>'
            str += '<thead>'
            str += '<tr class="fs-5 text-black-50">'
            str += '<th class="text-center border-1 border-start-0" style="background-color: #eceff1; border-color: #c7c7c7; font-family: hanaM;">환전 신청일</th>'
            str += '<th class="text-center border-1" style="font-family: hanaM;background-color: #eceff1; border-color: #c7c7c7">환전금액 </th>'
            str += '<th class="text-center border-1" style="font-family: hanaM;background-color: #eceff1; border-color: #c7c7c7">수령/거래 정보</th>'
            str += '<th class="text-center border-1" style="font-family:hanaM;background-color: #eceff1; border-color: #c7c7c7">결제방법</th>'
            str += '<th class="text-center border-1 border-end-0" style="font-family:hanaM; background-color: #eceff1; border-color: #c7c7c7">상태</th>'
            str += '</tr>'
            str += '</thead>'
            str += '<tbody>'
            data.forEach(function (history) {
                if(history.state == 'D') {
                    str += '<tr class="border-1 border-start-0 border-end-0 text-center bg-white" style="border-color: #c7c7c7">'
                    str += '<td class="text-hanagreen border-1 border-start-0 text-black-50 fs-5 align-middle" style="border-color: #c7c7c7;font-family: hanaM">'
                    str += history.exchangeDate.toString().substring(0, 11)
                    str += '</td>'
                    str += '<td class="border-1 text-dark align-middle fs-5 text-black-50" style="font-family: hanaM; border-color: #c7c7c7">'
                    str += '<img src="/resources/flag/flag_' + history.buyCcyCode + '.png" style="height: 20px">&nbsp;&nbsp;' + history.buyCcyCode
                    str += '<div class="text-hanagreen mt-1 fs-6" style="font-family: hanaM">'
                    str += history.buyAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
                    str += '</div>'
                    str += '</td>'
                    str += '<td class="border-1 text-black-50 align-middle" style="border-color: #c7c7c7; font-family: hanaM">'
                    str += '-'
                    str += '</td>'
                    str += '<td class="border-1 align-middle" style="border-color: #c7c7c7; font-family: hanaM; color: #616161">'
                    str += '당행계좌 출금'
                    str += '</td>'
                    str += '<td class="text-black-50 align-middle" style="font-family: hanaM">'
                    str += '수령정보 미등록'
                    str += '</td>'
                    str += '</tr>'
                }
                if(history.state == 'W'){
                    str += '<tr class="border-1 border-start-0 border-end-0 text-center" style="border-color: #c7c7c7;background-color: #f5f5f5;">'
                    str += '<td class="text-hanagreen border-1 border-start-0 text-black-50 fs-5 align-middle" style="border-color: #c7c7c7;font-family: hanaM">'
                    str += history.exchangeDate.toString().substring(0, 11)
                    str += '</td>'
                    str += '<td class="border-1 text-dark align-middle fs-5 text-black-50" style="font-family: hanaM; border-color: #c7c7c7">'
                    str += '<img src="/resources/flag/flag_' + history.buyCcyCode + '.png" style="height: 20px">&nbsp;&nbsp;' + history.buyCcyCode
                    str += '<div class="text-hanagreen mt-1 fs-6" style="font-family: hanaM">'
                    str += history.buyAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
                    str += '</div>'
                    str += '</td>'
                    str += '<td class="border-1 text-black-50 align-middle" style="border-color: #c7c7c7; font-family: hanaM">'
                    str += '원화로 재환전'
                    str += '</td>'
                    str += '<td class="border-1 align-middle" style="border-color: #c7c7c7; font-family: hanaM; color: #616161">'
                    str += '당행계좌 출금'
                    str += '</td>'
                    str += '<td class="text-black-50 align-middle" style="font-family: hanaM">'
                    str += '거래완료'
                    str += '</td>'
                    str += '</tr>'
                }
                if(history.state == 'C'){
                    str += '<tr class="border-1 border-start-0 bg-white border-end-0 text-center" style="background-color: #f5f5f5;">'
                    str += '<td class="text-hanagreen border-1 border-start-0 text-black-50 fs-5 align-middle" style="border-color: #c7c7c7;font-family: hanaM">'
                    str += history.exchangeDate.toString().substring(0, 11)
                    str += '</td>'
                    str += '<td class="border-1 text-dark align-middle fs-5 text-black-50" style="font-family: hanaM; border-color: #c7c7c7">'
                    str += '<img src="/resources/flag/flag_' + history.buyCcyCode + '.png" style="height: 20px">&nbsp;&nbsp;' + history.buyCcyCode
                    str += '<div class="text-hanagreen mt-1 fs-6" style="font-family: hanaM">'
                    str += history.buyAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
                    str += '</div>'
                    str += '</td>'
                    str += '<td class="border-1 text-black-50 align-middle" style="border-color: #c7c7c7; font-family: hanaM">'
                    str += '외화배달신청<br>2022-11-28 배달 예정'
                    str += '</td>'
                    str += '<td class="border-1 align-middle" style="border-color: #c7c7c7; font-family: hanaM; color: #616161">'
                    str += '당행계좌 출금'
                    str += '</td>'
                    str += '<td class="text-black-50 align-middle" style="font-family: hanaM">'
                    str += '수령정보 등록 완료'
                    str += '</td>'
                    str += '</tr>'
                }
            })
            str += '</tbody>'
            str += '</table>'
            str += '<div class="d-flex w-100 justify-content-center mb-4">'
            str += '<button class="btn text-white p-2 mt-3 fs-5 pe-4 ps-4 me-4" style="background-color: #558b2f">'
            str += '<i class="fa-solid fa-truck"></i>&nbsp;외화배달신청'
            str += '</button>'
            str += '<button class="btn bg-hanagreen text-white p-2 mt-3 fs-5 pe-4 ps-4">'
            str += '원화로 재환전'
            str += '</button>'
            str += '</div>'
            $('#div_hold_history').append(str);
        }
    }

    function ajax_hold_currency() {
        let r_walletNo = $('#radio_Group input:radio:checked').val();
        $.ajax({
            url: "/getHoldCurrency",
            type: "Post",
            data: {
                walletNo: r_walletNo
            },
            success: function (data) {
                if (data.length == 0) {
                    change_hold_ccy(0);
                    change_usd_rate(0);
                } else {
                    change_hold_ccy(data);
                    change_usd_rate(data);
                }
            }
        })
    }

    function change_hold_ccy(data) {
        div_hold_ccy.innerHTML = ''
        if (data == 0) {
            $('#div_hold_ccy').append('<div class="fs-3 w-100 h-100 text-black-50" style="display: flex; align-items: center; justify-content: center; font-family: hanaM">통화별 보유내역이 없습니다.</div>')
        } else {
            let str = ''
            str += '<div id="currency_Group">'
            data.forEach(function (currency) {
                    str += '<div class ="form-check form-control bg-white mt-3 pt-3 pb-3 w-100">'
                    str += '<input class="form-check-input fs-5 ms-1" type="radio" name="flexRadioCcy" id="currency.ccyCode" onchange="check_ccy()" autocomplete="off" value="' + currency.ccyCode + '" value2="' + currency.walletNo + '">'
                    str += '<label class="form-check-label fs-5 text-dark d-flex" for="currency.ccyCode" style="font-family: hanaM">'
                    str += '<div class="col-2 me-5 ms-5 text-black-50" style="font-family: hanaM">'
                    str += '<img src="/resources/flag/flag_' + currency.ccyCode + '.png" style="height: 30px">&nbsp;&nbsp;'
                    str += currency.contryKrNm + '&nbsp;'
                    str += currency.ccyCode
                    str += '</div>'
                    str += '<div class="col-3 text-hanagreen">'
                    str += currency.balance.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",")
                    str += '</div>'
                    str += exchange_yield(currency)
                    str += '</label>'
                    str += '</div>'
                }
            )
            str += '</div>'
            str += '<div class="d-flex w-100 justify-content-center mb-4">'
            str += '<button class="btn text-white p-2 mt-3 fs-5 pe-4 ps-4 me-4" type="submit" form="deliveryForm" style="background-color: #558b2f">'
            str += '<i class="fa-solid fa-truck"></i>&nbsp;외화배달신청'
            str += '</button>'
            str += '<button class="btn bg-hanagreen text-white p-2 mt-3 fs-5 pe-4 ps-4" data-bs-toggle="modal" data-bs-target="#chooseAccount">'
            str += '원화로 재환전'
            str += '</button>'
            str += '</div>'
            $('#div_hold_ccy').append(str)
        }
    }

    function exchange_yield(currency) {
        var str = '';
        $.ajax({
            url: "/calculaterYield",
            type: "Post",
            data: {
                walletNo: currency.walletNo,
                ccyCode: currency.ccyCode
            },
            async: false,
            success: function (resultList) {
                let diff;
                if (currency.ccyCode == "JPY") {
                    diff = (resultList[1] * currency.balance / 100).toFixed(0);
                } else {
                    diff = (resultList[1] * currency.balance).toFixed(0);
                }
                if (resultList[0] < 0) {
                    str += '<div class="col-3" style="color: #616161">'
                    str += '<i class="fa-solid fa-down-long" style="color: #448aff"></i> ' + resultList[0].toFixed(2) + '% (' + diff.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + '원)';
                    str += '</div>'
                } else {
                    str += '<div class="col-3" style="color: #616161">'
                    str += '<i class="fa-solid fa-up-long" style="color: #f44335!important;"></i> +' + resultList[0].toFixed(2) + '% (+' + diff.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + '원)';
                    str += '</div>'
                }
            },
        })
        return str;
    }

    //미화환산율 변경경
    function change_usd_rate(data) {
        $('#usd_rate').empty();
        if (data == 0) {
            $('#usd_rate').append('0.00');
        } else {
            $('#usd_rate').append(data[0].usdTotal.toFixed(2));
        }
    }

    function check_ccy() {
        let r_walletNo = $("input[name=flexRadioCcy]").attr("value2");
        let r_ccyCode = $('#currency_Group input:radio:checked').val();
        $.ajax({
            url: "/getHistoryData",
            type: "Post",
            data: {
                walletNo: r_walletNo,
                sellCcyCode: r_ccyCode,
                buyCcyCode: "KRW",
            },
            success: function (data) {
                $('#m_sellContryFlag').empty();
                $('#m_buyContryFlag').empty();
                $('#m_sellContryNm').empty();
                $('#m_buyContryNm').empty();
                $('#m_sellAmount').empty();
                $('#m_buyAmount').empty();
                $('#m_apply_ExcRate').empty();
                $('#m_event_spreadRate').empty();
                $('#m_sellContryFlag').append('<img src="/resources/flag/flag_' + data.sellCcyCode + '.png" style="height: 30px">')
                $('#m_buyContryFlag').append('<img src="/resources/flag/flag_KRW.png" style="height: 30px">')
                $('#m_sellContryNm').append(data.buyCcyCode + ' ' + data.sellCcyCode)
                $('#m_buyContryNm').append('원화 ' + 'KRW(원)')
                $('#m_sellAmount').append(data.sellAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","))
                $('#m_buyAmount').append(data.buyAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","))
                $('#m_apply_ExcRate').append(data.applyExchangeRate.toFixed(2) + ' 원')
                $('#m_event_spreadRate').append(data.eventSpreadRate + '%');
                document.getElementById('walletNo').setAttribute('value', data.walletNo);
                document.getElementById('sellCcyCode').setAttribute('value', data.sellCcyCode);
                document.getElementById('sellCntryKrNm').setAttribute('value', data.buyCcyCode);
                document.getElementById('sellAmount').setAttribute('value', data.sellAmount);
                document.getElementById('buyCcyCode').setAttribute('value', 'KRW');
                document.getElementById('buyAmount').setAttribute('value', data.buyAmount);
                document.getElementById('buyCntryKrNm').setAttribute('value', '대한민국');
                document.getElementById('applyExchangeRate').setAttribute('value', data.applyExchangeRate);
                document.getElementById('eventSpreadRate').setAttribute('value', data.eventSpreadRate);
                document.getElementById('delivery_ccyCode').setAttribute('value', data.sellCcyCode);
            }
        })
    }

    function ajax_exc_reservation() {
        let r_walletNo = $('#radio_Group input:radio:checked').val();
        $.ajax({
            url: "/getExcReservationList",
            type: "Post",
            data: {
                walletNo: r_walletNo
            },
            success: function (data) {
                if(data.length == 0) {
                    change_exchange_res(0);
                } else {
                    change_exchange_res(data);
                }
            }
        })
    }

    function change_exchange_res(data) {
        $('#div_exchange_res').empty();
        if (data == 0) {
            $('#div_exchange_res').append('<div class="fs-3 w-100 h-100 text-black-50" style="display: flex; align-items: center; justify-content: center; font-family: hanaM">예약 내역이 없습니다.</div>')
        } else {
            let str = ''
            str += '<table class="table border-0 table-hover text-end mt-3 border-top">'
            str += '<colgroup><col width=15%><col width=10%><col width=15%><col width=10%><col width=10%><col width=15%><col width=10%><col width=15%></colgroup>'
            str += '<thead>'
            str += '<tr class="fs-6 text-black-50">'
            str += '<th class="text-center border-1 border-start-0" style="background-color: #eceff1; border-color: #c7c7c7; font-family: hanaM;">예약 번호</th>'
            str += '<th class="text-center border-1" style="font-family: hanaM;background-color: #eceff1; border-color: #c7c7c7">예약 만료일</th>'
            str += '<th class="text-center border-1" style="font-family: hanaM;background-color: #eceff1; border-color: #c7c7c7">구매 예약 수량</th>'
            str += '<th class="text-center border-1" style="font-family: hanaM;background-color: #eceff1; border-color: #c7c7c7">구매 예약 환율</th>'
            str += '<th class="text-center border-1" style="font-family:hanaM;background-color: #eceff1; border-color: #c7c7c7">총 구매량</th>'
            str += '<th class="text-center border-1" style="font-family:hanaM;background-color: #eceff1; border-color: #c7c7c7">결제 계좌</th>'
            str += '<th class="text-center border-1" style="font-family:hanaM;background-color: #eceff1; border-color: #c7c7c7">알림 여부</th>'
            str += '<th class="text-center border-1 border-end-0" style="font-family:hanaM; background-color: #eceff1; border-color: #c7c7c7">상태</th>'
            str += '</tr>'
            str += '</thead>'
            str += '<tbody>'
            data.forEach(function (reservation) {
                if(reservation.state == 'D') {
                    str += '<tr class="border-1 border-start-0 border-end-0 text-center bg-white" style="border-color: #c7c7c7">'
                    str += '<td class="text-hanagreen border-1 border-start-0 text-black-50 fs-5 align-middle" style="border-color: #c7c7c7;font-family: hanaM">'
                    str += reservation.reservationNo;
                    str += '</td>'
                    str += '<td class="border-1 text-black-50 fs-5 align-middle" style="border-color: #c7c7c7; font-family: hanaM">'
                    str += reservation.expirationDate.toString().substring(0, 11)
                    str += '</td>'
                    str += '<td class="border-1 text-dark align-middle fs-5 text-black-50" style="font-family: hanaM; border-color: #c7c7c7">'
                    str += '<img src="/resources/flag/flag_' + reservation.ccyCode + '.png" style="height: 20px">&nbsp;&nbsp;' + reservation.ccyCode
                    str += '<div class="text-hanagreen mt-1 fs-6" style="font-family: hanaM">'
                    str += reservation.targetBuyAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
                    str += '</div>'
                    str += '</td>'
                    str += '<td class="border-1 text-black-50 align-middle fs-5" style="border-color: #c7c7c7; font-family: hanaM">'
                    str += reservation.targetBuyRate.toFixed(2);
                    str += '</td>'
                    str += '<td class="border-1 align-middle fs-5" style="border-color: #c7c7c7; font-family: hanaM; color: #616161">'
                    str += reservation.exchangeAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
                    str += '</td>'
                    str += '<td class="border-1 text-black-50 align-middle fs-5" style="border-color: #c7c7c7; font-family: hanaM">'
                    str += reservation.accountNo;
                    str += '</td>'
                    str += '<td class="border-1 text-black-50 align-middle fs-5" style="border-color: #c7c7c7; font-family: hanaM">'
                    str += reservation.alarm;
                    str += '</td>'
                    str += '<td class="align-middle text-hanagreen" style="font-family: hanaM">'
                    str += '거래 진행 중'
                    str += '</td>'
                    str += '</tr>'
                }
                if(reservation.state == 'C') {
                    str += '<tr class="border-1 border-start-0 border-end-0 text-center" style="border-color: #c7c7c7; background-color: #f5f5f5;">'
                    str += '<td class="text-hanagreen border-1 border-start-0 text-black-50 fs-5 align-middle" style="border-color: #c7c7c7;font-family: hanaM">'
                    str += reservation.reservationNo;
                    str += '</td>'
                    str += '<td class="border-1 text-black-50 fs-5 align-middle" style="border-color: #c7c7c7; font-family: hanaM">'
                    str += reservation.expirationDate.toString().substring(0, 11)
                    str += '</td>'
                    str += '<td class="border-1 text-dark align-middle fs-5 text-black-50" style="font-family: hanaM; border-color: #c7c7c7">'
                    str += '<img src="/resources/flag/flag_' + reservation.ccyCode + '.png" style="height: 20px">&nbsp;&nbsp;' + reservation.ccyCode
                    str += '<div class="text-hanagreen mt-1 fs-6" style="font-family: hanaM">'
                    str += reservation.targetBuyAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
                    str += '</div>'
                    str += '</td>'
                    str += '<td class="border-1 text-black-50 align-middle fs-5" style="border-color: #c7c7c7; font-family: hanaM">'
                    str += reservation.targetBuyRate.toFixed(2);
                    str += '</td>'
                    str += '<td class="border-1 align-middle fs-5" style="border-color: #c7c7c7; font-family: hanaM; color: #616161">'
                    str += reservation.exchangeAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
                    str += '</td>'
                    str += '<td class="border-1 text-black-50 align-middle fs-5" style="border-color: #c7c7c7; font-family: hanaM">'
                    str += reservation.accountNo;
                    str += '</td>'
                    str += '<td class="border-1 text-black-50 align-middle fs-5" style="border-color: #c7c7c7; font-family: hanaM">'
                    str += reservation.alarm;
                    str += '</td>'
                    str += '<td class="align-middle text-black-50" style="font-family: hanaM">'
                    str += '거래완료'
                    str += '</td>'
                    str += '</tr>'
                }
            })
            str += '</tbody>'
            str += '</table>'
            $('#div_exchange_res').append(str);
        }
    }
</script>
</body>
</html>