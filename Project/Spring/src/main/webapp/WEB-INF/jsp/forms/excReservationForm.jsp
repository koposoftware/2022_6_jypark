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
	<style>
        input::-webkit-inner-spin-button {
            appearance: none;
            -moz-appearance: none;
            -webkit-appearance: none;
        }

        .form-control {
            border-color: #bdbdbd !important;
        }

        .form-select {
            border-color: #bdbdbd !important;
        }

        .form-select:focus {
            outline: none !important;
            box-shadow: none !important;
        }

        .btn:hover {

        }

	</style>
</head>
<body>
<div class="container-fluid position-relative d-flex p-0">
	<jsp:include page="../include/sidebar.jsp"/>
	<a href="#" class="btn btn-lg bg-white border-0 btn-lg-square back-to-top"><i
			class="bi bi-arrow-up text-hanagreen"></i></a>
	<div class="content">
		<jsp:include page="../include/spinner.jsp"/>
		<jsp:include page="../include/navbar.jsp"/>
		<div class="ms-5 fs-5" style="color: #bdbdbd">환전지갑 / <strong style="color: #000000">환전예약</strong></div>
		<div class="container-fluid pt-4 px-4">
			<div class="col-sm-12 col-md-12 col-xl-12 mt-3">
				<div class="bg-white rounded p-4 row box mb-4 pe-5 ps-5">
					<div class="fs-2 mt-2 mb-4 text-black-50" style="font-family: dotomM;">
						환전예약
					</div>
					<hr>
					<div class="col-12">
						<div class="col-12 d-flex">
							<div class="fs-5 me-3 pt-1" style="color:#616161;width:10% !important;font-family: hanaM">
								지갑선택
							</div>
							<select class="form-select w-50 fs-6 text-black-50 me-3" id="walletList"
							        onchange="change_wallet_no(this)"
							        style="width: 20%!important; font-family: hanaM">
								<option disabled selected>
									지갑을 선택하세요.
								</option>
								<c:forEach items="${walletAccountList}" var="walletAccount">
									<option value="${walletAccount.walletNo}"
									        accountAlias="${walletAccount.accountAlias}">
											${walletAccount.walletNo}
									</option>
								</c:forEach>
							</select>
							<div class="d-none text-hanagreen fs-5 h-100 pt-1" id="accountAlias" style="font-family: dotomM">
							</div>
						</div>
						<div class="col-12 d-flex mt-2">
							<div class="fs-5 me-3 pt-1" style="color: #616161;width:10% !important;font-family: hanaM">
								예약하실 통화
							</div>
							<select class="form-select w-50 fs-6 text-black-50" id="ccyList" onchange="change_ccyCode()"
							        style="width: 20%!important; font-family: hanaM">
								<option disabled selected>
									통화를 선택하세요.
								</option>
								<c:forEach items="${spreadList}" var="spread">
									<option ccyCode="${spread.ccyCode}" eventspread="${spread.eventSpreadRate}">
											${spread.cntryNmKr} ${spread.ccyCode}
									</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 fs-2 text-black-50 mt-3 "
						     style="border-radius: 20px;display: flex; align-items:center; justify-content:center; min-height: 400px; background-color: #f5f5f5; font-family: dotomM">
							<div class="w-100 text-center" id="exchangeChart" style="color: #b0bec5;font-family: hanaM; ">
								통화를 선택해주세요.
							</div>
						</div>
						<div class="col-12 text-danger d-none" id="exchangeChartSub">
							* 3개월 환율변동 추이는 구매시 환율의 그래프입니다.
						</div>
						<div class="col-12 d-flex mt-4 p-0">
							<div class="fs-5 me-2" style="color: #616161;font-family: hanaM">
								구매 목표 환율
							</div>
							<input class="form-control text-black-50 me-4 fs-5 p-1" type="number" id="target_buy_rate"
							       placeholder=""
							       style="width: 10%!important; height: 80%!important; padding-left: 5px!important; font-family: hanaM">
							<div class="fs-5 me-2" style="color: #616161;font-family: hanaM">
								구매 희망 수량
							</div>
							<input class="form-control text-black-50 me-4 fs-5 p-1" type="number" id="target_buy_amount"
							       placeholder=""
							       style="width: 10%!important; height: 80%!important; padding-left: 5px!important; font-family: hanaM">
							<button class="btn text-white fs-6 pe-2 ps-2" type="button" style="background-color: #78909c;font-family: dotomM"
							        onclick="click_calculate_btn()"> 계산하기
							</button>
						</div>
						<div class="col-12 text-danger mb-2">
							* 구매목표환율은 우대율이 적용된 가격입니다.
						</div>
						<hr>
						<div class="d-none" id="reserveDiv">
							<div class="col-12 d-flex justify-content-center">
								<div class="col-6 fs-4 text-center text-white rounded mt-3 row p-4"
								     style="min-height: 150px; background-color: #f5f5f5; font-family: hanaM">
									<div class="col-12 d-flex mt-1">
										<div class="col-3 text-center me-5 fs-5" style="color: #494949;font-family: dotomM">
											우대율
										</div>
										<div class="col-7 text-end text-hanagreen fs-5" id="eventspread"
										     style="font-family: hanaM">

										</div>
									</div>
									<div class="col-12 d-flex mt-1">
										<div class="col-3 text-center me-5 fs-5" style="color: #494949;font-family: dotomM">
											적용환율
										</div>
										<div class="col-7 text-end text-hanagreen fs-5" id="r_target_buy_rate"
										     style="font-family: hanaM">

										</div>
									</div>
									<div class="col-12 d-flex mt-1">
										<div class="col-3 text-center me-5 fs-5" style="color: #494949;font-family: dotomM">
											예상금액
										</div>
										<div class="col-7 text-end text-hanagreen fs-5" id="r_expected_won"
										     style="font-family: hanaM">
										</div>
									</div>
								</div>
								<div class="col-6 text-black-50 rounded mt-3 row p-4 ps-5"
								     style="min-height: 150px; font-family: hanaM">
									<div class="col-12 d-flex fs-5 text-black-50">
										<div class="text-black-50 me-2 pt-1" style="font-family: hanaM">
											환전예약 만료일
										</div>
										<form>
											<div class="row form-group">
												<div class="input-group date" id="datepicker">
													<input type="text" class="form-control w-25" id="expiration_date" onchange="change_expdate()">
													<span class="input-group-append">
                                                            <span class="input-group-text bg-white d-block border border-2"
                                                                  style="border-color: #bdbdbd !important;">
                                                                <i class="fa fa-calendar fs-4"></i>
                                                            </span>
													</span>
												</div>
											</div>
										</form>
									</div>
									<div class="text-danger fs-6">
										* 환전예약 만료일은 예약 시점으로부터 최대 1년까지 설정 가능합니다.
									</div>
									<div class="mt-2 d-flex">
										<div class="fs-5 pt-3" style="font-family: dotomM">
											<i class="fa-solid fa-bell text-hanagreen fa-shake"></i> 환전완료 메세지 알림
										</div>
										<div class="form-check form-switch pt-1" style="padding-left: 5px!important;">
											<input type="checkbox" id="input_alarm" class="form-check-input fs-2 ms-1" value="N" onchange="change_alarm(this)">
										</div>
									</div>
								</div>
							</div>
							<div class="d-flex mt-4 mb-3">
								<div class="fs-5 me-3 pt-1"
								     style="color: #616161;width:10% !important;font-family: hanaM">
									출금 계좌선택
								</div>
								<select class="form-select w-50 fs-6 text-black-50" id="accountList" onchange="change_account()"
								        style="width: 30%!important; font-family: hanaM">
									<option disabled selected>
										계좌를 선택하세요.
									</option>
									<c:forEach items="${accountList}" var="account">
										<option value="${account.accountNo}">
												${account.alias} (${account.accountNo})
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="d-flex mt-2">
								<div class="fs-5 me-3 pt-1"
								     style="color: #616161;width:10% !important;font-family: hanaM">
									출금 비밀번호
								</div>
								<input class="form-control fs-6" type="password" placeholder="* * * *"
								       style="width: 10%!important; padding: 0!important; padding-left: 10px!important;">
							</div>
							<hr>
							<textarea class="w-100 form-control bg-white mt-3 mb-2" cols="10" rows="20"
							          style="color: #494949;resize: none" readonly>
								<jsp:include page="../terms/joinAccount.jsp"/>
						</textarea>
							<div class="col-12 d-flex rounded-3 p-2 align-items-center form-control bg-white justify-content-between mb-4 fs-5 pt-3 pb-3" style="color: #494949;">
								<span class="fs-6" style="color: #494949; font-family: dotomM">약관에 동의하시겠습니까?</span>
								<input class="me-3" type="checkbox" id="checkbox1" style="width: 20px; height: 20px">
							</div>
							<form action="/excReservationProcess" method="post">
								<div class="text-center">
									<input class="d-none" id="accountNo" name="accountNo" type="text" value="">
									<input class="d-none" id="walletNo" name="walletNo" type="text" value="">
									<input class="d-none" id="ccyCode" name="ccyCode" type="text" value="">
									<input class="d-none" id="targetBuyRate" name="targetBuyRate" type="number" value="">
									<input class="d-none" id="targetBuyAmount" name="targetBuyAmount" type="number" value="">
									<input class="d-none" id="expirationDate" name="expirationDate" type="text" value="">
									<input class="d-none" id="alarm" name="alarm" type="text" value="N">
									<button class="btn bg-white fs-4" type="submit"
									        style="border: 4px #78909c solid!important; color: #616161;border-radius: 20px;width: 200px; height: 50px;font-family: dotomM">
										예약하기
									</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/script.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>
<script>
    $('#datepicker').datepicker({
        format: 'yyyy-mm-dd', //데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
        endDate: '+1y',
        autoclose: true,
        title: '환전예약 만료일',
        todayHighlight: true,
        language: "ko",
    });

    function change_wallet_no() {
        const accountAliasDiv = document.getElementById('accountAlias');
        let accountAlias = $('#walletList > option:selected').attr('accountAlias');
        let walletNo = $('#walletList > option:selected').attr('value');
        $('#accountAlias').empty();
        $('#accountAlias').append('연동계좌 : ' + accountAlias);
        accountAliasDiv.classList.remove('d-none');
        document.getElementById('walletNo').setAttribute('value', walletNo);
    }

    function change_ccyCode() {
        let ccyCode = $('#ccyList > option:selected').attr('ccyCode');
        document.getElementById('ccyCode').setAttribute('value', ccyCode);
        renderChart(ccyCode);
    }

    function renderChart(ccyCode) {
        const date = new Date();
        const year = date.getFullYear();
        const month = date.getMonth() + 1;
        const day = date.getDate();
        let today = year.toString() + ("00" + month.toString()).slice(-2) + ("00" + day.toString()).slice(-2)
        let buyExcRate = []
        let renewalRate = []
        const exchangeChartSubDiv = document.getElementById('exchangeChartSub');
        exchangeChartSubDiv.classList.remove('d-none');
        $.ajax({
            url: '/getExcRate',
            type: 'Get',
            data: {
                ccyCode: ccyCode,
                nowDate: today,
            },
            success: function (data) {
                for (let i = 0; i < data.length; i++) {
                    buyExcRate.push(data[i].buyExcRate)
                    renewalRate.push(data[i].renewalRate)
                }
                var options = {
                    series: [{
                        name: ccyCode,
                        data: buyExcRate
                    }],
                    chart: {
                        defaultLocale: 'kr',
                        type: 'area',
                        height: 350,
                        zoom: {
                            enabled: false
                        },
                        locales: [{
                            name: 'kr',
                            options: {
                                months: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                                days: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                                shortDays: ['일', '월', '화', '수', '목', '금', '토']
                            }
                        }],
                    },
                    dataLabels: {
                        enabled: false
                    },
                    stroke: {
                        curve: 'straight'
                    },

                    title: {
                        text: '3개월 환율 변동 추이',
                        align: 'left',
                        offsetX: 0,
                        offsetY: 0,
                        style: {
                            fontSize: '25px',
                            color: '#008485'
                        }
                    },
                    subtitle: {
                        text: ' 최저(' + Math.min.apply(null, buyExcRate).toFixed(2) + ')  최고(' + Math.max.apply(null, buyExcRate).toFixed(2) + ')',
                        align: 'left',
                        offsetX: 0,
                        offsetY: 40,
                        style: {
                            fontSize: '20px',
                        }
                    },
                    labels: renewalRate,
                    xaxis: {
                        labels: {
                            // type: 'datetime',
                            style: {
                                fontSize: '10px',
                            },
                            rotate: 0,
                        },
                        tickAmount: 5,
                    },
                    tooltip: {
                        x: {
                            format: 'yyyyMMdd'
                        }
                    },
                    yaxis: {
                        opposite: true,
                        min: minValue(buyExcRate),
                        max: maxValue(buyExcRate),
                        tickAmount: 4,
                    },
                    legend: {
                        horizontalAlign: 'left'
                    },
                };
                $('#exchangeChart').empty();
                var chart = new ApexCharts(document.querySelector("#exchangeChart"), options);
                chart.render();
            }
        })
    }

    function maxValue(buyExcRate) {
        let maxValue = 0;
        for (let i = 0; i < buyExcRate.length; i++) {
            if (buyExcRate[i] > maxValue)
                maxValue = buyExcRate[i];
        }
        return maxValue + (maxValue * 1 / 100)
    }

    function minValue(buyExcRate) {
        let minValue = buyExcRate[0];
        for (let i = 0; i < buyExcRate.length; i++) {
            if (buyExcRate[i] < minValue)
                minValue = buyExcRate[i];
        }
        return minValue - (minValue * 1 / 100)
    }

    function click_calculate_btn() {
        const reserveDiv = document.getElementById('reserveDiv');
        reserveDiv.classList.remove('d-none');
        let eventspread = $('#ccyList > option:selected').attr('eventspread');
        let ccyCode = $('#ccyList > option:selected').attr('ccyCode');

        let target_buy_rate = $('#target_buy_rate').val()
        let target_buy_amount = $('#target_buy_amount').val()
        $('#eventspread').empty();
        $('#eventspread').append(eventspread + '%');
        $('#r_target_buy_rate').empty();
        $('#r_target_buy_rate').append(target_buy_rate);
        if(ccyCode == "JPY") {
            $('#r_expected_won').empty();
            $('#r_expected_won').append((target_buy_rate * target_buy_amount / 100).toFixed(0).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + ' 원' + '<div class="fs-6 text-hanared justify-content-end" id="r_target_buy_amount" style="font-family: hanaM"></div>');
        } else {
            $('#r_expected_won').empty();
            $('#r_expected_won').append((target_buy_rate * target_buy_amount).toFixed(0).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + ' 원' + '<div class="fs-6 text-hanared justify-content-end" id="r_target_buy_amount" style="font-family: hanaM"></div>');
        }
        $('#r_target_buy_amount').empty();
        $('#r_target_buy_amount').append('( ' + ccyCode + ' ' + target_buy_amount + ' )');
        document.getElementById('targetBuyAmount').setAttribute('value', target_buy_amount);
        document.getElementById('targetBuyRate').setAttribute('value', target_buy_rate);
    }

    function change_account() {
        let accountNo = $('#accountList > option:selected').attr('value');
        document.getElementById('accountNo').setAttribute('value', accountNo.replaceAll("-", ""));
    }

    function change_expdate() {
        let expirationDate = $('#expiration_date').val();
        document.getElementById('expirationDate').setAttribute('value', expirationDate);
    }

    function change_alarm(type) {
        if(type.checked)
            document.getElementById('alarm').setAttribute('value', 'Y');
	    else
            document.getElementById('alarm').setAttribute('value', 'N');
    }
</script>
</body>
</html>
