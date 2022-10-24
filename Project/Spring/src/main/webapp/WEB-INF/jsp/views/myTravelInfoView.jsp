<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <html>

                <head>
                    <title>환전원큐</title>
                    <jsp:include page="../include/link.jsp" />
                </head>

                <body>
                    <div class="container-fluid position-relative d-flex p-0">
                        <jsp:include page="../include/spinner.jsp" />
                        <jsp:include page="../include/sidebar.jsp" />
                        <a href="#" class="btn btn-lg bg-white border-0 btn-lg-square back-to-top"><i
                                class="bi bi-arrow-up text-hanagreen"></i></a>
                        <div class="content">
                            <jsp:include page="../include/navbar.jsp" />
                            <div class="ms-5 fs-5" style="color: #bdbdbd">여행계획 / <strong
                                    style="color: #000000">나의여행계획</strong></div>
                            <div class="container-fluid pt-4 px-4 me-4">
                                <div class="row g-4">
                                    <div class="col-sm-12 col-md-12 col-xl-12">
                                        <select class="form-select border-1 box" name="withdrawAccountNo"
                                            id="selectAccountForm" onchange="changeAccountInfo()"
                                            style="height: 55px; width: 75%">
                                            <c:forEach items="${accountList}" var="account">
                                                <option value="${account.accountNo}"
                                                    memberNum="${fn:length(account.prtcpList)}">${account.accountNo}
                                                    [${account.alias}]
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-sm-12 col-xl-4" data-aos="flip-left" data-aos-duration="1000">
                                        <div class="h-100 bg-white rounded p-4 box">
                                            <div class="d-flex w-100">
                                                <h5 class="mb-0 text-black-50" id="alias"></h5>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-between mb-2">
                                                <h6 class="mb-0 text-black-50" id="accountNo"></h6>
                                            </div>
                                            <div class="d-flex align-items-center py-3 mt-4">
                                                <div class="w-100 ms-3">
                                                    <h2 class="text-center text-black-50" id="balance"></h2>
                                                </div>
                                            </div>
                                            <div class="d-flex text-center pt-3">
                                                <div class="w-100 align-items-center">
                                                    <a href="transfer">
                                                        <button class="btn form-control text-white bg-hanagreen"
                                                            style="width: 100%">이체내역
                                                        </button>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-xl-8" id="nonePlanInfo">
                                        <div class="bg-white rounded p-4 row align-items-center box"
                                            style="min-height: 280px">
                                            <div class="col justify-content-center text-center">
                                                <h4 class="text-black-50 mb-3">여행계획을 설정해주세요.</h4>
                                                <button type="button" class="btn text-white p-2" data-bs-toggle="modal"
                                                    data-bs-target="#exampleModal" data-bs-whatever=""
                                                    style="background-color: #008485; width: 25%;">설정하기
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-xl-8 d-none" id="existPlanInfo">
                                        <div class="bg-white text-center rounded p-4 row" style="min-height: 230px">
                                            <div class="form-floating col-5 mb-2">
                                                <input class="form-control bg-white" id="countryNm" name="countryNm"
                                                    value="" placeholder="여행국가" readonly>
                                                <label for="countryNm">&nbsp;&nbsp;&nbsp;여행국가</label>
                                            </div>
                                            <div class="form-floating col-3 mb-2">
                                                <input class="form-control bg-white" id="warningAlarm"
                                                    name="warningAlarm" value="" placeholder="여행경보" readonly>
                                                <label for="warningAlarm">&nbsp;&nbsp;&nbsp;여행경보</label>
                                            </div>
                                            <div class="form-floating col-1 mb-2 d-none pt-1" id="siren-black">
                                                <img class="filter-orange size-m"
                                                    src="/resources/icon/siren-icon-black.png"
                                                    style="width: 40px; height: 40px;" />
                                            </div>
                                            <div class="form-floating col-1 mb-2 d-none pt-1" id="siren-red">
                                                <img class="filter-orange size-m"
                                                    src="/resources/icon/siren-icon-red.png"
                                                    style="width: 40px; height: 40px;" />
                                            </div>
                                            <div class="form-floating col-1 mb-2 d-none pt-1" id="siren-orange">
                                                <img class="filter-orange size-m"
                                                    src="/resources/icon/siren-icon-orange.png"
                                                    style="width: 40px; height: 40px;" />
                                            </div>
                                            <div class="form-floating col-1 mb-2 pt-1 d-none" id="siren-blue">
                                                <img class="filter-orange size-m"
                                                    src="/resources/icon/siren-icon-blue.png"
                                                    style="width: 40px; height: 40px;" />
                                            </div>
                                            <div class="col-12 mb-2 form-control">
                                                <img class="filter-orange size-m pb-1"
                                                    src="/resources/icon/siren-icon-blue.png"
                                                    style="width: 15px; height: 17px;" /> 남색경보(여행유의)&nbsp;&nbsp;&nbsp;
                                                <img class="filter-orange size-m pb-1"
                                                    src="/resources/icon/siren-icon-orange.png"
                                                    style="width: 15px; height: 17px;" /> 황색경보(여행자제)&nbsp;&nbsp;&nbsp;
                                                <img class="filter-orange size-m pb-1"
                                                    src="/resources/icon/siren-icon-red.png"
                                                    style="width: 15px; height: 17px;" /> 적색경보(철수권고)&nbsp;&nbsp;&nbsp;
                                                <img class="filter-orange size-m pb-1"
                                                    src="/resources/icon/siren-icon-black.png"
                                                    style="width: 15px; height: 17px;" /> 흑색경보(여행금지)&nbsp;&nbsp;&nbsp;
                                            </div>
                                            <div class="form-floating col-6 mb-2">
                                                <input class="form-control bg-white" id="e_dDate" name="e_dDate"
                                                    value="" placeholder="출국예정일" readonly>
                                                <label for="e_dDate">&nbsp;&nbsp;&nbsp;출국예정일</label>
                                            </div>
                                            <div class="form-floating col-6 mb-2">
                                                <input class="form-control bg-white" id="e_eDate" name="e_eDate"
                                                    value="" placeholder="입국예정일" readonly>
                                                <label for="e_eDate">&nbsp;&nbsp;&nbsp;입국예정일</label>
                                            </div>
                                            <div class="form-floating col-12">
                                                <input class="form-control bg-white" id="memberNo" name="memberNo"
                                                    value="" placeholder="참여/목표 인원 수" readonly>
                                                <label for="memberNo">&nbsp;&nbsp;&nbsp;참여 / 목표 (인원 수)</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-md-12 col-xl-12 d-none" id="progress">
                                        <div class="ms-1 fs-4 mb-2 text-black-50">목표달성 <i
                                                class="fa-solid fa-person-running fa-fade"></i>
                                        </div>
                                        <div class="bg-white rounded p-4 row text-center box">
                                            <div class="form-floating col-3 mb-2">
                                                <input class="form-control bg-white" id="p_balance" name="p_balance"
                                                    value="" placeholder="현재금액" readonly>
                                                <label for="p_balance">&nbsp;&nbsp;&nbsp;현재금액</label>
                                            </div>
                                            <div class="form-floating col-3 mb-2">
                                                <input class="form-control bg-white" id="p_targetAmount"
                                                    name="p_targetAmount" value="" placeholder="목표금액" readonly>
                                                <label for="p_targetAmount">&nbsp;&nbsp;&nbsp;목표금액</label>
                                            </div>
                                            <div class="form-floating col-3 mb-2">
                                                <input class="form-control bg-white text-primary" id="margin"
                                                    name="margin" value="" placeholder="남은금액" readonly>
                                                <label for="p_targetAmount">&nbsp;&nbsp;&nbsp;남은금액</label>
                                            </div>
                                            <div class="form-floating col-3 mb-2">
                                                <input class="form-control bg-white" id="month_amount"
                                                    name="month_amount" value="" placeholder="n/1" readonly>
                                                <label for="p_targetAmount">&nbsp;&nbsp;&nbsp;이번달 MY 목표</label>
                                            </div>
                                            <div class="form-floating col-12 mt-3">
                                                <div class="progress" style="height: 50px;">
                                                    <div class="progress-bar progress-bar-striped bg-hanagreen progress-bar-animated fs-5"
                                                        id="progressBar" role="progressbar" aria-valuenow="25"
                                                        aria-valuemin="0" aria-valuemax="100">

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-md-12 col-xl-12 mb-4 d-none" id="memberState">
                                        <div class="ms-1 fs-4 mb-2 text-black-50">멤버별 현황</div>
                                        <div class="bg-white rounded row text-center box">
                                            <div class="col-12 mt-3 ms-2">
                                                <div class="form-control text-center w-25 fs-5 h-100"
                                                    id="m_targetAmount">

                                                </div>
                                            </div>
                                            <div class="col d-flex">
                                                <div class="col-3" id="chart1"></div>
                                                <div class="col-3" id="chart2"></div>
                                                <div class="col-3" id="chart3"></div>
                                                <div class="col-3" id="chart4"></div>
                                            </div>
                                            <div class="d-flex text-center" id="totalAmount">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%------------ Modal Start ----------------%>
                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                            aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                <div class="modal-content bg-white border-0 shadow" style="border-radius: 15px">
                                    <div class="modal-header border-bottom-0 mt-4">
                                        <h4 class="modal-title text-black-50 w-100 text-center" id="exampleModalLabel">
                                        </h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="container-fluid">
                                            <div class="form-floating mb-3"
                                                style="border: 10px; border-color: #008485;">
                                                <select class="form-select border-2" name="countryCode" id="countryList"
                                                    style="padding: 10px;">

                                                </select>
                                            </div>
                                            <div class="form-floating mb-3 col-12" id="dateCheck">
                                                <input class="form-control text-light" type="text" id="date"
                                                    placeholder="여행일자" name="departureDate" maxlength="15" value="" />
                                                <label for="date">&nbsp;여행일자</label>
                                            </div>
                                            <div class="row d-none" id="dateShow">
                                                <div class="form-floating mb-2" style="width: 45%">
                                                    <input class="form-control text-light bg-white" type="text"
                                                        id="dDate" placeholder="출국예정일" name="departureDate"
                                                        maxlength="15" disabled value="" />
                                                    <label for="dDate">&nbsp;&nbsp;&nbsp;출국예정일</label>
                                                </div>
                                                <div class="form-floating mb-2" style="width: 45%">
                                                    <input class="form-control text-light bg-white" type="text"
                                                        id="eDate" placeholder="입국예정일" name="entryDate" maxlength="15"
                                                        disabled value="" />
                                                    <label for="eDate">&nbsp;&nbsp;&nbsp;입국예정일</label>
                                                </div>
                                                <div class="d-flex mb-2" style="width: 10%">
                                                    <box-icon type='solid' size="lg" name='calendar' class="mt-3">
                                                    </box-icon>
                                                </div>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control text-light" type="number"
                                                    placeholder="목표금액설정" name="targetAmount" id="targetAmount"
                                                    maxlength="15">
                                                <label for="targetAmount">&nbsp;목표금액설정</label>
                                            </div>
                                            <div class="form-floating mb-3"
                                                style="border: 10px; border-color: #008485;">
                                                <select class="form-select border-2" id="prtcpMemberNum"
                                                    name="prtcpMemberNum" style="padding: 10px;">
                                                    <option>&nbsp;참여인원수</option>
                                                    <c:forEach begin="1" end="20" var="count">
                                                        <option value="${count}">&nbsp;&nbsp;${count}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="container-fluid w-100 pb-5 text-center">
                                        <button type="submit" class="btn bg-hanagreen p-2 fs-6 text-white"
                                            onclick="insertTravelPlan()" style="width: 49%">저장하기
                                        </button>
                                        <button type="button" class="btn bg-hanasilver p-2 fs-6 text-white"
                                            style="width: 49%" data-bs-dismiss="modal">취소
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%------------ Modal End ----------------%>
                            <jsp:include page="../include/script.jsp" />
                            <script>
                                AOS.init();
                                $(document).ready(function () {
                                    changeAccountInfo();
                                    countryAjax();
                                })

                                var exampleModal = document.getElementById('exampleModal');
                                exampleModal.addEventListener('show.bs.modal', function (event) {
                                    // Button that triggered the modal
                                    var button = event.relatedTarget
                                    // Extract info from data-bs-* attributes
                                    var recipient = button.getAttribute('data-bs-whatever')
                                    // If necessary, you could initiate an AJAX request here
                                    // and then do the updating in a callback.
                                    //
                                    // Update the modal's content.
                                    var modalTitle = exampleModal.querySelector('.modal-title')
                                    var modalBodyInput = exampleModal.querySelector('.modal-body input')

                                    modalTitle.textContent = '여행정보설정' + recipient
                                    modalBodyInput.value = recipient
                                })

                                $(function () {
                                    let today = new Date();
                                    let year = today.getFullYear();
                                    let month = today.getMonth() + 1;
                                    let day = today.getDate();
                                    $('#date').daterangepicker({
                                        "locale": {
                                            "format": "YYYY-MM-DD",
                                            "separator": " ~ ",
                                            "applyLabel": "확인",
                                            "cancelLabel": "취소",
                                            "fromLabel": "From",
                                            "toLabel": "To",
                                            "customRangeLabel": "Custom",
                                            "weekLabel": "W",
                                            "daysOfWeek": ["월", "화", "수", "목", "금", "토", "일"],
                                            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                                            "firstDay": 1
                                        },
                                        "startDate": year + '-' + (month - 1) + '-' + day,
                                        "endDate": year + '-' + month + '-' + day,
                                        "drops": "down"
                                    }, function (start, end, label) {
                                        const date_check = document.getElementById('dateCheck');
                                        date_check.classList.add('d-none');
                                        const date_show = document.getElementById('dateShow');
                                        date_show.classList.remove('d-none');
                                        $("#dDate").attr('value', start.format('YYYY-MM-DD'));
                                        $("#eDate").attr('value', end.format('YYYY-MM-DD'));
                                        console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
                                    });
                                });

                                function changeAccountInfo() {
                                    var selectAccountNo = $('#selectAccountForm > option:selected').attr('value');
                                    selectAccountNo = selectAccountNo.replace(/-/g, "");
                                    $('#alias').empty();
                                    $('#accountNo').empty();
                                    $('#balance').empty();
                                    <c:forEach items="${accountList}" var="account">
                                        if (selectAccountNo == "${account.accountNo.replace('-', "")}") {
                                            $('#alias').append("${account.alias}");
                                        $('#accountNo').append("${account.accountNo}");
                                        $('#balance').append("<fmt:formatNumber
                                            value="${account.balance}"
                                            pattern="#,###" />원");
        }
                                    </c:forEach>
                                    changeTravelPlan();
                                }

                                function countryAjax() {
                                    var xhr = new XMLHttpRequest();
                                    var url = 'http://apis.data.go.kr/1262000/TravelAlarmService2/getTravelAlarmList2'; /*URL*/
                                    var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'key'; /*Service Key*/
                                    queryParams += '&' + encodeURIComponent('returnType') + '=' + encodeURIComponent('JSON'); /**/
                                    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('197'); /**/
                                    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
                                    xhr.open('GET', url + queryParams);
                                    xhr.onreadystatechange = function () {
                                        if (this.readyState == 4) {
                                            var object = JSON.parse(this.responseText);
                                            var option = '';
                                            option += '<option>&nbsp;국가선택</option>'
                                            for (var i = 0; i < 197; i++) {
                                                if (object.data[i].country_nm == '미합중국') {
                                                    option += '<option value=\"' + object.data[i].country_iso_alp2 + '\" value2=\"' + object.data[i].alarm_lvl + '\">&nbsp;';
                                                    option += '미국';
                                                    option += "</option>";
                                                } else {
                                                    option += '<option value=\"' + object.data[i].country_iso_alp2 + '\" value2=\"' + object.data[i].alarm_lvl + '\">&nbsp;';
                                                    option += object.data[i].country_nm;
                                                    option += "</option>";
                                                }
                                            }
                                            $('#countryList').append(option);
                                        }
                                    };
                                    xhr.send('');
                                }

                                function insertTravelPlan() {
                                    var accountNo = $('#selectAccountForm > option:selected').attr("value");
                                    accountNo = accountNo.replaceAll("-", "");
                                    var countryCode = $("#countryList > option:selected").attr("value");
                                    var departureDate = $("#date").val();
                                    var targetAmount = $('#targetAmount').val();
                                    var prtcpMemberNum = $("#prtcpMemberNum > option:selected").attr("value");
                                    $.ajax({
                                        url: 'travelPlanProcess',
                                        type: 'POST',
                                        data: {
                                            accountNo: accountNo,
                                            countryCode: countryCode,
                                            departureDate: departureDate,
                                            targetAmount: targetAmount,
                                            prtcpMemberNum: prtcpMemberNum
                                        },
                                        success: function () {
                                            $('#exampleModal').modal('hide');
                                            changeTravelPlan();

                                        }
                                    })
                                }

                                function changeTravelPlan() {
                                    var accountNo = $('#selectAccountForm > option:selected').attr("value");
                                    accountNo = accountNo.replaceAll("-", "");
                                    var balance = document.getElementById('balance').innerText;
                                    var progressBar = document.querySelector("#progressBar");
                                    $.ajax({
                                        url: 'getTravelPlan',
                                        type: 'POST',
                                        data: {
                                            accountNo: accountNo,
                                        },
                                        success: function (data) {
                                            if (data) {
                                                const none_plan_info = document.getElementById('nonePlanInfo');
                                                none_plan_info.classList.add('d-none');
                                                const exist_plan_info = document.getElementById('existPlanInfo');
                                                exist_plan_info.classList.remove('d-none');
                                                const progress = document.getElementById('progress');
                                                progress.classList.remove('d-none');
                                                const memberState = document.getElementById('memberState');
                                                memberState.classList.remove('d-none');
                                                $('input[name=r_targetAmount]').attr('value', data.targetAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + '원');

                                                var countryInfo = getCountryNmAndAlarm(data.countryCode);
                                                var today = new Date();
                                                var month = today.getMonth() + 1;
                                                var departureMonth = data.departureDate.toString().substring(5, 7);

                                                // 현재금액/목표금액
                                                $('#progressBar').empty();
                                                var i_balance = parseInt(balance.replaceAll(",", ""));
                                                var targetAmount = parseInt(data.targetAmount);
                                                var per = (i_balance / targetAmount) * 100;
                                                var prtcpMemberNum = $('#selectAccountForm > option:selected').attr("memberNum");
                                                $('input[name=p_balance]').attr('value', balance);
                                                $('input[name=p_targetAmount]').attr('value', data.targetAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + '원');
                                                if (i_balance >= targetAmount) {
                                                    $('input[name=margin]').attr('value', '목표달성');
                                                } else {
                                                    $('input[name=margin]').attr('value', (targetAmount - i_balance).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + '원');
                                                }
                                                $('input[name=e_dDate]').attr('value', data.departureDate.toString().substring(0, 10));
                                                $('input[name=e_eDate]').attr('value', data.entryDate.toString().substring(0, 10));
                                                $('input[name=memberNo]').attr('value', prtcpMemberNum + '명 / ' + data.prtcpMemberNum + '명');
                                                if (i_balance >= targetAmount) {
                                                    $('input[name=month_amount]').attr('value', '목표달성');
                                                } else {
                                                    let goal = (((targetAmount) / data.prtcpMemberNum) / (departureMonth - month + 1));
                                                    if (goal > 0) {
                                                        $('input[name=month_amount]').attr('value', (goal.toFixed(0)).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + '원');
                                                    } else {
                                                        $('input[name=month_amount]').attr('value', '목표달성');
                                                    }
                                                }
                                                progressBar.style.width = per + '%';
                                                progressBar.append(per.toFixed(1) + '%');
                                                getMemberDepositList(departureMonth, prtcpMemberNum, targetAmount);
                                            } else {
                                                const none_plan_info = document.getElementById('nonePlanInfo');
                                                none_plan_info.classList.remove('d-none');
                                                const exist_plan_info = document.getElementById('existPlanInfo');
                                                exist_plan_info.classList.add('d-none');
                                                const progress = document.getElementById('progress');
                                                progress.classList.add('d-none');
                                                const memberState = document.getElementById('memberState');
                                                memberState.classList.add('d-none');
                                            }
                                        }
                                    })

                                    function getCountryNmAndAlarm(countryCode) {
                                        var xhr = new XMLHttpRequest();
                                        var url = 'http://apis.data.go.kr/1262000/TravelAlarmService2/getTravelAlarmList2'; /*URL*/
                                        var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'EW%2BSR6nTiH5M5iQtJNX2Qn4%2BLQchYHdtfxgNFBfi91aFbOYcKA4TpbpMjcG%2FCGu0n5bMwQTh9axtDO4D4k8CNw%3D%3D'; /*Service Key*/
                                        queryParams += '&' + encodeURIComponent('returnType') + '=' + encodeURIComponent('JSON'); /**/
                                        queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('197'); /**/
                                        queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
                                        xhr.open('GET', url + queryParams);
                                        xhr.onreadystatechange = function () {
                                            if (this.readyState == 4) {
                                                var object = JSON.parse(this.responseText);
                                                for (var i = 0; i < 197; i++) {
                                                    if (object.data[i].country_iso_alp2 == countryCode) {
                                                        // var siren = exampleModal.querySelector('.siren');
                                                        // siren.classList.remove("d-none");
                                                        if (object.data[i].alarm_lvl == "1") {
                                                            $('input[name=warningAlarm]').attr('value', '남색경보');
                                                            document.getElementById('siren-black').classList.add('d-none');
                                                            document.getElementById('siren-red').classList.add('d-none');
                                                            document.getElementById('siren-orange').classList.add('d-none');
                                                            document.getElementById('siren-blue').classList.remove('d-none');
                                                        }
                                                        if (object.data[i].alarm_lvl == "2") {
                                                            $('input[name=warningAlarm]').attr('value', '황색경보');
                                                            document.getElementById('siren-black').classList.add('d-none');
                                                            document.getElementById('siren-red').classList.add('d-none');
                                                            document.getElementById('siren-orange').classList.remove('d-none');
                                                            document.getElementById('siren-blue').classList.add('d-none');
                                                        }
                                                        if (object.data[i].alarm_lvl == "3") {
                                                            $('input[name=warningAlarm]').attr('value', '적색경보');
                                                            document.getElementById('siren-black').classList.add('d-none');
                                                            document.getElementById('siren-red').classList.remove('d-none');
                                                            document.getElementById('siren-orange').classList.add('d-none');
                                                            document.getElementById('siren-blue').classList.add('d-none');
                                                        }
                                                        if (object.data[i].alarm_lvl == "4") {
                                                            $('input[name=warningAlarm]').attr('value', '흑색경보');
                                                            document.getElementById('siren-black').classList.remove('d-none');
                                                            document.getElementById('siren-red').classList.add('d-none');
                                                            document.getElementById('siren-orange').classList.add('d-none');
                                                            document.getElementById('siren-blue').classList.add('d-none');
                                                        }
                                                        $('input[name=countryNm]').attr('value', object.data[i].country_nm);
                                                        return;
                                                    }
                                                }
                                            }
                                        };
                                        xhr.send('');
                                    }

                                    function getMemberDepositList(departureMonth, prtcpMemberNum, targetAmount) {
                                        var accountNo = $('#selectAccountForm > option:selected').attr("value");
                                        accountNo = accountNo.replaceAll("-", "");
                                        $.ajax({
                                            url: 'getMemberDepositList',
                                            type: 'POST',
                                            data: {
                                                accountNo: accountNo,
                                            },
                                            success: function (data) {
                                                $('#totalAmount').empty();
                                                if (data.length == 0) {
                                                    let str = '';

                                                    str += '<div class="fs-3 w-100 h-100 text-black-50" style="display: flex; align-items: center; justify-content: center;min-height: 300px; font-family: hanaM">'
                                                    str += '멤버별 입금 현황이 없습니다.'
                                                    str == '</div>'
                                                    $('#totalAmount').append(str);
                                                } else {
                                                    var chartId = '#chart';
                                                    var count = 0;
                                                    var today = new Date();
                                                    var period = departureMonth - today.getMonth() + 1
                                                    var amountForpeople = (targetAmount / prtcpMemberNum).toFixed(0)
                                                    $('#m_targetAmount').empty()
                                                    $('#m_targetAmount').append('멤버별 목표금액 > ' + amountForpeople.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + '원')
                                                    $('#memberDepositAmount').empty();
                                                    $(data).each(function () {
                                                        count++;
                                                        chartId = chartId.substring(0, 6) + count;
                                                        var options = {
                                                            series: [(this.totalAmount / amountForpeople * 100).toFixed(0)],
                                                            chart: {
                                                                width: '100%',
                                                                height: 300,
                                                                type: 'radialBar',
                                                                offsetY: 30,
                                                            },
                                                            fill: {
                                                                colors: ['#008485']
                                                            },
                                                            plotOptions: {
                                                                radialBar: {
                                                                    hollow: {
                                                                        size: '60%',
                                                                    },
                                                                    dataLabels: {
                                                                        show: true,
                                                                        name: {
                                                                            // offsetY: 140,
                                                                            show: true,
                                                                            fontSize: '24px',
                                                                        },
                                                                        value: {
                                                                            show: true,
                                                                            fontSize: '17px',
                                                                        },
                                                                    },
                                                                },
                                                            },
                                                            marginBottom: 0,
                                                            colors: ['#6C7293'],
                                                            labels: [this.transferName],
                                                        };

                                                        var chart = new ApexCharts(document.querySelector(chartId), options);
                                                        chart.render();
                                                        let str = '';
                                                        str += '<div class="col-3 form-control w-25 fs-5 mb-3 bg-white border-0">';
                                                        str += this.totalAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + '원'
                                                        str += '</div>'
                                                        $('#totalAmount').append(str);
                                                    })
                                                }
                                            }
                                        })
                                    }

                                }
                            </script>
                </body>

                </html>