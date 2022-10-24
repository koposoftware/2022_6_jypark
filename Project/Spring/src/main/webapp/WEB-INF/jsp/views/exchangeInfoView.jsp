<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
	<title>환전원큐</title>
	<jsp:include page="../include/link.jsp"/>
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

        .form-control:focus {
            outline: none !important;
            box-shadow: none !important;
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
		<div class="ms-5 fs-5" style="color: #bdbdbd">환전지갑 / <strong style="color: #000000">환율정보</strong></div>
		<div class="container-fluid pt-4 px-4 mt-4">
			<div class="row g-4">
				<div class="col-sm-12 col-md-12 col-xl-12 row">
					<div class="ms-1 fs-4 mb-2 text-black-50"><i
							class="fa-solid fa-calculator text-hanagreen"></i>&nbsp;환율 계산기(매매기준율 기준)
					</div>
					<div class="bg-white box col-12 p-5 d-flex rounded mb-3 row ms-1"
					     style="padding-top: 20px!important;">
						<div class="fs-4 p-0 mb-2 text-black-50"
						     style="font-family: Helvetica; font-weight: bolder">
							원달러 미국 USD
						</div>

						<div class="row w-100 p-0">
							<div class="col-8 border border-2 rounded" style="border-color: #c7c7c7 !important;">
								<div id="exchangeChart">
								</div>
							</div>
							<div class="col-3 row ms-3">
								<div class="mb-3" style="border-color: #c7c7c7 !important;">
									<select class="form-select border border-bottom-0 border-2 rounded text-dark"
									        style="border-color: #c7c7c7!important; background-color: #f5f5f5;border-radius: 0px !important;font-family: hana"
									        onchange="changeFirstCountry()" id="selectFirst">
										<option value="원" value2="1" selected>
											대한민국 KRW
										</option>
										<c:forEach items="${excRateList}" var="excRate">
											<c:choose>
												<c:when test="${excRate.ccyCode eq 'USD'}">
													<option value="${excRate.ccyKrName}" value2="${excRate.basicRate}"
													        selected>
															${excRate.cntryKrNm}&nbsp;${excRate.ccyCode}
													</option>
												</c:when>
												<c:otherwise>
													<option value="${excRate.ccyKrName}" value2="${excRate.basicRate}">
															${excRate.cntryKrNm}&nbsp;${excRate.ccyCode}
													</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
									<div id="inputFirstContainer" class="border border-2"
									     style="border-color: #c7c7c7!important;">
										<input class="form-control border-0 text-dark fs-5" type="text" value="1"
										       style="text-align: right; font-family: hanaM"
										       onkeyup="javascript:keyUpFirstAmount(this)" id="inputFirst"
										       maxlength="19">
										<div class="text-black-50"
										     style="text-align: right; padding-right: 10px; padding-bottom: 5px"
										     id="excFirst">
											1 달러
										</div>
									</div>
								</div>
								<i class="fa-solid fa-equals text-center fs-1"></i>
								<div class="mt-3" style="border-color: #c7c7c7 !important;">
									<select class="form-select border border-bottom-0 border-2 rounded text-dark"
									        style="border-color: #c7c7c7!important; background-color: #f5f5f5;border-radius: 0px !important;font-family: hana"
									        onchange="changeSecondCountry()"
									        id="selectSecond">
										<option value="원" value2="1" selected>
											대한민국 KRW
										</option>
										<c:forEach items="${excRateList}" var="excRate">
											<option value="${excRate.ccyKrName}" value2="${excRate.basicRate}">
													${excRate.cntryKrNm}&nbsp;${excRate.ccyCode}
											</option>
										</c:forEach>
									</select>
									<div id="inputSecondContainer" class="border border-2"
									     style="border-color: #c7c7c7!important;">
										<c:forEach items="${excRateList}" var="excRate">
											<c:if test="${excRate.ccyCode eq 'USD'}">
												<input class="form-control border-0 text-dark fs-5"
												       value="${String.format("%.2f",excRate.basicRate)}"
												       value2="${excRate.basicRate}"
												       onkeyup="javascript:keyUpSecondAmount(this)"
												       type="text"
												       style="text-align: right; font-family: hanaM" ; id="inputSecond"
												       maxlength="19">
												<div class="text-primary"
												     style="text-align: right; padding-right: 10px; padding-bottom: 5px"
												     id="excSecond">
														${excRate.basicRate} 원
												</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-12 col-md-12 col-xl-12 mt-3">
				<div class="ms-1 fs-4 mb-2 text-black-50"><i
						class="fa-solid fa-money-bill-1-wave text-hanagreen fa-shake"
						style="--fa-animation-duration: 20s;"></i>&nbsp;환전고시 환율&nbsp;
				</div>
				<div class="bg-white rounded p-4 row box mb-4">
					<div class="mb-2">
						<div class="fs-6" style="font-family: hana; text-align: right">
							기준일시 : ${excRateList[0].renewalRate}
						</div>
					</div>
					<table class="table border-0 table-hover text-end me-2 border-top">
						<caption class="mt-3">유의사항<br>
							2014.3.4 이후 중국 위안화 환율은 홍콩시장에서 거래되는 위안화 환율(CNH)을 고시합니다.
						</caption>
						<colgroup>
							<col width=15%>
							<col width=15%>
							<col width=15%>
							<col width=15%>
							<col width=15%>
							<col width=12.5%>
							<col width=12.5%>
						</colgroup>
						<thead>
						<tr>
							<th class="text-center border-1 border-start-0 text-dark h-100 align-middle"
							    style="background-color: #eceff1; border-color: #c7c7c7; font-family: hanaM;"
							    rowspan="2">통화명
							</th>
							<th class="text-center border-1 text-dark"
							    style="font-family: hanaM;background-color: #eceff1; border-color: #c7c7c7"
							    colspan="2">현찰
							</th>
							<th class="text-center border-1 text-dark"
							    style="font-family: hanaM;background-color: #eceff1; border-color: #c7c7c7"
							    colspan="2">송금
							</th>
							<th class="text-center border-1 text-dark h-100 align-middle"
							    style="font-family:hanaM;background-color: #eceff1; border-color: #c7c7c7"
							    rowspan="2">매매 기준율
							</th>
							<th class="text-center border-1 border-end-0 text-dark h-100 align-middle"
							    style="font-family:hanaM; background-color: #eceff1; border-color: #c7c7c7" rowspan="2">
								미화 환산율
							</th>
						</tr>
						<tr>
							<th class="text-center border-1 text-dark"
							    style="font-family: hanaM; background-color: #eceff1; border-color: #c7c7c7">사실
								때
							</th>
							<th class="text-center border-1 text-dark"
							    style="font-family: hanaM; background-color: #eceff1; border-color: #c7c7c7">파실
								때
							</th>
							<th class="text-center border-1 text-dark"
							    style="font-family: hanaM; background-color: #eceff1; border-color: #c7c7c7">
								보내실 때
							</th>
							<th class="text-center border-1 text-dark"
							    style="font-family: hanaM; background-color: #eceff1; border-color: #c7c7c7">
								받으실 때
							</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${excRateList}" var="excRate">
							<tr class="border-1 border-start-0 border-end-0" style="border-color: #c7c7c7">
								<td class="text-start text-hanagreen border-1 border-start-0 text-dark"
								    style="border-color: #c7c7c7">${excRate.cntryKrNm}&nbsp;${excRate.ccyCode}</td>
								<td class="border-1 text-dark" style="font-family: hana; border-color: #c7c7c7">
									<fmt:formatNumber
											pattern="0.00" value="${excRate.buyExcRate}"/></td>
								<td class="border-1 text-dark" style="border-color: #c7c7c7"><fmt:formatNumber
										pattern="0.00" value="${excRate.sellExcRate}"/></td>
								<td class="border-1 text-dark" style="border-color: #c7c7c7"><fmt:formatNumber
										pattern="0.00"
										value="${excRate.sendExcRate}"/></td>
								<td class="border-1 text-dark" style="border-color: #c7c7c7"><fmt:formatNumber
										pattern="0.00"
										value="${excRate.recExcRate}"/></td>
								<td class="border-1 text-dark" style="border-color: #c7c7c7; background-color: #e1f5fe">
									<fmt:formatNumber pattern="0.00"
									                  value="${excRate.basicRate}"/></td>
								<td class="text-dark"><fmt:formatNumber pattern="0.00" value="${excRate.usdRate}"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/script.jsp"/>
<script>
    const date = new Date();

    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    const day = date.getDate();
    let today = year.toString() + ("00" + month.toString()).slice(-2) + ("00" + day.toString()).slice(-2)
    let basicRate = []
    let renewalRate = []
    $.ajax({
        url: 'getExcRate',
        type: 'Get',
        data: {
            ccyCode: 'USD',
            nowDate: today,
        },
        success: function (data) {
            for (let i = 0; i < data.length; i++) {
                basicRate.push(data[i].basicRate)
                renewalRate.push(data[i].renewalRate)
            }
            basicRate.push(${excRateList[0].basicRate})
            renewalRate.push('${excRateList[0].renewalRate.substring(5,11).toString()}')
            let margin = basicRate[basicRate.length - 1] - basicRate[basicRate.length - 2]
            margin = Math.abs(margin)
            let per = (basicRate[basicRate.length - 1] - basicRate[basicRate.length - 2]) / basicRate[basicRate.length - 1] * 100
            var options = {
                series: [{
                    name: "원달러",
                    // 환율 값
                    data: basicRate
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
                    text: '<fmt:formatNumber value="${excRateList[0].basicRate}" pattern=".00"/> 원',
                    align: 'left',
                    offsetX: 0,
                    offsetY: 0,
                    style: {
                        fontSize: '30px',
                    }
                },
                subtitle: {
                    text: subTitle(per, margin),
                    align: 'left',
                    offsetX: 0,
                    offsetY: 40,
                    style: {
                        fontSize: '20px',
                        color: color(per),
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
                    min: 1250,
                    max: 1500,
                    tickAmount: 5,
                },
                legend: {
                    horizontalAlign: 'left'
                }
            };

            var chart = new ApexCharts(document.querySelector("#exchangeChart"), options);
            chart.render();
        }
    })

    function subTitle(per, margin) {
        if (per < 0)
            return '전일대비 ▼' + margin.toFixed(2) + ' (' + per.toFixed(2) + '%)'
        else
            return '전일대비 ▲' + margin.toFixed(2) + ' (+' + per.toFixed(2) + '%)'
    }

    function color(per) {
        if (per < 0)
            return '#0000FF'
        else
            return '#f44336'
    }
</script>
</body>
</html>
