<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<title>환전원큐</title>
	<jsp:include page="../include/link.jsp"/>
	<style>
        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .form-select:focus {
            box-shadow: none !important;
        }

        input:focus {
            outline: none !important;
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
		<div class="container-fluid pt-4 px-4">
			<div class="row g-4 p-2">
				<div class="col-sm-12 col-xl-12 bg-white p-0">
					<div class="d-flex">
						<div class="col-6 bg-white border-5 border-top box p-4 "
						     style="border-color: #008485 !important;min-height: 300px">
							<div class="d-flex mt-3">
								<span class="fs-5 text-black-50" style="font-family: dotom">
									환전할 통화 선택 및 금액을 입력하세요.
								</span>
							</div>
							<div class="d-flex p-0 mt-3">
								<div class="d-flex w-100 border border-2 rounded"
								     style="border-color: #c7c7c7 !important;">
									<select class="fs-6 p-2 m-0 form-select border-0 text-dark"
									        id="selectCcyCode" onchange="changeBuyInfo()"
									        style="font-family: dotomM; width: 40%">
										<c:forEach items="${spreadList}" var="spread">
											<c:forEach items="${excRateList}" var="excRate">
												<c:if test="${spread.ccyCode eq excRate.ccyCode}">
													<option value="${spread.ccyCode}" value2="${excRate.buyExcRate}"
													        value3="${excRate.basicRate}"
													        value4="${spread.eventSpreadRate}"
															value5="${spread.cntryNmKr}"
															value6="${spread.exchangeMinAmount}">
															${spread.cntryNmKr}&nbsp;${spread.ccyCode}
													</option>
												</c:if>
											</c:forEach>
										</c:forEach>
									</select>
									<input class="text-end fs-5 p-2 border-0 border-start" id="buy_amount"
									       type="number"
									       placeholder="${spreadList[0].exchangeMinAmount} 이상" maxlength="10"
									       style="width: 60%">
								</div>
								<button class="border border-2 ms-2 rounded p-2" onclick="calculation()"
								        style="background-color: #e0f7fa; width: 80px; border-color: #b2ebf2 !important; font-family: hanaM; color: #80deea">
									계산
								</button>
							</div>
							<div class="form-control mt-3 text-dark" id="eventSpreadRate" style="font-family: hana">
								<img src="/resources/flag/flag_USD.png">&nbsp;우대율&nbsp;${spreadList[0].eventSpreadRate}%
							</div>
							<div class="text-dark mt-5">
								- 신청인 본인만 외화를 찾으실 수 있습니다.<br>
								- 차트영역의 환율정보와 실제 거래시점의 환율정보는 다를 수 있습니다.<br>
								- 공항에서 외화수령은 인천국제공항에서만 가능합니다.(제 1,2 여객터미널 영업점 및 환전소)
							</div>
						</div>
						<div class="col-6 p-3" style="background-color: #eceff1">
							<div id="exchangeChart">
							</div>
						</div>
					</div>
					<div class="col-12 p-3 pt-4 d-flex d-none" id="calculationDiv" style="background-color: #eceff1">
						<div class="col-3 p-3 ps-4 border-top border-bottom">
							<hr class="mb-1 rounded"
							    style="background-color: #008485; width: 15%; height: 5px; opacity: 1">
							<div class="fs-5 text-dark">
								결제금액(원)
							</div>
							<div class="fs-4 text-hanagreen" id="sell_amount" style="opacity: 1; font-family: hana">
								-
							</div>
						</div>
						<div class="col-3 p-3 ps-5 border-top border-bottom">
							<div class="d-flex justify-content-between w-100 mt-4">
								<div class="fs-5 text-dark">
									적용환율
								</div>
								<div class="me-3 fs-5 text-dark" id="buyExcRate" style="font-family: hanaM">
									-
								</div>
							</div>
							<div class="d-flex justify-content-between mt-1">
								<div class="fs-5 text-dark">
									우대율
								</div>
								<div class="me-3 fs-5 text-dark" id="eventSpreadRate02" style="font-family: hanaM">
									90%
								</div>
							</div>
							<div class="justify-content-end me-2 mt-2">
								<button class="btn bg-hanagreen text-white float-end text-center p-2"
								        data-bs-toggle="modal"
								        data-bs-target="#chooseAccount">다음&nbsp;<i
										class="fa-solid fa-chevron-right"></i></button>
							</div>
						</div>
					</div>
				</div>
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
				<div class="col-12 p-4">
					<div>
						<div class="mb-3 fs-5" style="color: #424242; font-family: hanaM">
							결제정보를 입력하세요.
						</div>
						<div class="d-flex justify-content-between mb-2">
							<div class="text-black-50 fs-6" style="font-family: hanaM">
								환전신청금액
							</div>
							<div class="text-dark fs-6" id="modal_buy_amount" style="font-family: hanaM">
								미국 USD 10
							</div>
						</div>
						<div class="d-flex justify-content-between mb-2">
							<div class="text-black-50 fs-6" style="font-family: hanaM">
								결제하실 금액(원)
							</div>
							<div class="text-hanagreen fs-6" id="modal_sell_amount" style="font-family: hanaM">
								14358
							</div>
						</div>
						<div class="d-flex justify-content-between mb-2">
							<div class="text-black-50 fs-6" style="font-family: hanaM">
								결제방법
							</div>
							<div class="text-dark fs-6" style="font-family: hanaM">
								환전원큐 계좌 출금
							</div>
						</div>
						<hr>
					</div>
					<div class="mt-5 mb-5 col">
						<div class="col-12 d-flex justify-content-between mb-3">
							<div class="text-black-50 fs-6 mb-4" style="font-family: hanaM">
								지갑선택
							</div>
							<div class="col-8">
								<select class="form-select w-100" id="select_wallet" onchange="choiceWallet()">
									<option selected disabled>
										지갑을 선택하세요.
									</option>
									<c:forEach items="${walletAccountList}" var="wallet">
										<option walletNo="${wallet.walletNo}" accountAlias="${wallet.accountAlias}"
										        accountNo="${wallet.accountNo}">
												${wallet.walletNo}
										</option>
									</c:forEach>
								</select>
								<div class="text-end text-hanagreen mt-1" id="accountAlias">
								</div>
							</div>
						</div>
						<div class="col-12 d-flex justify-content-between mb-3">
							<div class="text-black-50 fs-6 mb-4" style="font-family: hanaM">
								출금계좌
							</div>
							<div class="col-8">
								<select class="form-select w-100" id="select_account" onchange="choiceAccount()">
									<option selected disabled>
										계좌를 선택하세요.
									</option>
									<c:forEach items="${accountList}" var="account">
										<option accountNo="${account.accountNo}" balance="${account.balance}">
												${account.alias} (${account.accountNo})
										</option>
									</c:forEach>
								</select>
								<div class="text-end text-hanagreen mt-1" id="accountBalance">
								</div>
							</div>
						</div>
						<div class="col-12 d-flex justify-content-between">
							<div class="text-black-50 fs-6" style="font-family: hanaM">
								비밀번호
							</div>
							<div class="col-8">
								<input class="form-control w-100" type="password" placeholder="****" maxlength="4">
							</div>
						</div>
						<hr>
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
							<input class="d-none" id="applyExchangeRate" name="applyExchangeRate" type="number" value="">
							<input class="d-none" id="eventSpreadRate01" name="eventSpreadRate" type="number" value="">
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
    renderChart('USD')

    // Chart
    function renderChart(ccyCode) {
        const date = new Date();
        const year = date.getFullYear();
        const month = date.getMonth() + 1;
        const day = date.getDate();
        let today = year.toString() + ("00" + month.toString()).slice(-2) + ("00" + day.toString()).slice(-2)
        let buyExcRate = []
        let renewalRate = []
        let selectBuyExcRate = $('#selectCcyCode > option:selected').attr('value2');
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
                        // 환율 값
                        data: buyExcRate
                    }],
                    chart: {
                        defaultLocale: 'kr',
                        type: 'area',
                        height: 300,
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
                        text: '현찰 사실 때',
                        align: 'left',
                        offsetX: 0,
                        offsetY: 0,
                        style: {
                            fontSize: '25px',
                            color: '#008485'
                        }
                    },
                    subtitle: {
                        text: selectBuyExcRate + '원',
                        align: 'left',
                        offsetX: 0,
                        offsetY: 40,
                        style: {
                            fontSize: '30px',
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
                    }
                };
                var chart = new ApexCharts(document.querySelector("#exchangeChart"), options);
                chart.render();
            }
        })
    }

    // 통화를 선택시 변경 함수
    function changeBuyInfo() {
        let selectCcyCode = $('#selectCcyCode > option:selected').attr('value');
        let img_src = "<img src='/resources/flag/flag_" + selectCcyCode + ".png'>"
        $.ajax({
            url: '/getSpreadInfo',
            type: 'GET',
            data: {
                ccyCode: selectCcyCode,
            },
            success: function (data) {
                const calculationDiv = document.getElementById('calculationDiv');
                calculationDiv.classList.add('d-none');
                $('#eventSpreadRate').empty();
                $('#eventSpreadRate').append(img_src + ' 우대율 ' + data.eventSpreadRate + '%');
                $('#eventSpreadRate02').empty();
                $('#eventSpreadRate02').append(data.eventSpreadRate + '%')
                $("#buy_amount").val('');
                $("#buy_amount").attr("placeholder", data.exchangeMinAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + ' 이상');
                $("#exchangeChart").empty();
                renderChart(data.ccyCode)
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

    // 계산버튼 누를시 변경 함수
    function calculation() {
        let minAmount = $('#selectCcyCode > option:selected').attr('value6');
        if($('#buy_amount').val() < minAmount) {
            if ($('#buy_amount').val() == 0) {
                alert('금액을 입력해주세요.')
                return
            }
            alert("구매 가능한 최소 단위는 " + minAmount + "입니다.")
        }
        // 통화코드
        let ccyCode = $('#selectCcyCode > option:selected').attr('value');
        let img_src = "<img src='/resources/flag/flag_" + ccyCode + ".png' style='height: 20px'>"
        // 현찰 사실때 환율
        let selectBuyExcRate = $('#selectCcyCode > option:selected').attr('value2');
        // 매매기준율
        let basicRate = $('#selectCcyCode > option:selected').attr('value3');
        // 우대율
        let eventSpreadRate = $('#selectCcyCode > option:selected').attr('value4');
        // 구매할 통화량
        let buyAmount = $('#buy_amount').val();
        // 우대율 적용 구매 환율
        let buyExcRate = ((1.75 * (100 - eventSpreadRate) / 100 * basicRate / 100) + parseFloat(basicRate)).toFixed(2);
	    // 구매통화_한글
	    let buyCntryKrNm = $('#selectCcyCode > option:selected').attr('value5');
        // 결제금액(원)
        let sellAmount = buyAmount * buyExcRate;
        if (ccyCode == 'JPY')
            sellAmount = sellAmount / 100
        // 소수점버림
        sellAmount = Math.floor(sellAmount);

        // 결제금액(원)
        $('#sell_amount').empty();
        $('#sell_amount').append(sellAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + ' 원')
        // 적용환율
        $('#buyExcRate').empty();
        $('#buyExcRate').append(buyExcRate.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + ' 원')
        // 모달 구매금액
        $('#modal_buy_amount').empty();
        $('#modal_buy_amount').append(img_src + " " + ccyCode + " " + buyAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","))
        // 모달 판매 금액
        $('#modal_sell_amount').empty();
        $('#modal_sell_amount').append(sellAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + ' 원')

        document.getElementById('sellCcyCode').setAttribute('value', 'KRW')
	    document.getElementById('sellCntryKrNm').setAttribute('value', '대한민국')
        document.getElementById('sellAmount').setAttribute('value', sellAmount)
        document.getElementById('buyCcyCode').setAttribute('value', ccyCode)
        document.getElementById('buyAmount').setAttribute('value', buyAmount)
        document.getElementById('buyCntryKrNm').setAttribute('value', buyCntryKrNm)
        document.getElementById('applyExchangeRate').setAttribute('value', buyExcRate)
        document.getElementById('eventSpreadRate01').setAttribute('value', eventSpreadRate)

        const calculationDiv = document.getElementById('calculationDiv');
        calculationDiv.classList.remove('d-none');
    }

    function choiceWallet() {
        let accountAlias = $('#select_wallet > option:selected').attr('accountAlias');
        let walletNo = $('#select_wallet > option:selected').attr('walletNo');
        document.getElementById('walletNo').setAttribute('value', walletNo)
        $('#accountAlias').empty();
        $('#accountAlias').append('연동계좌 : ' + accountAlias);
    }

    function choiceAccount() {
        let accountBalance = $('#select_account > option:selected').attr('balance');
        let accountNo = $('#select_account > option:selected').attr('accountNo');
        document.getElementById('accountNo').setAttribute('value', accountNo.replaceAll("-", ""))
        $('#accountBalance').empty();
        $('#accountBalance').append('계좌잔액 : ' + accountBalance.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + ' 원');
    }
</script>
</body>
</html>