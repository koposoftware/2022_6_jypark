<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
	<title>환전원큐</title>
	<link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
	<link href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
	<jsp:include page="../include/link.jsp"/>
	<style>
        img {
            border: 2px solid #bdbdbd;
        }

        img:hover {
            transform: scale(1.05);
            transition: 0.5s;
            box-shadow: 0px 0px 15px #8d8d8d;
            border: none;
        }

        .nav-tabs button {
            font-size: 18px;
            color: #616161 !important;
            background-color: #e0e0e0 !important;
            border: none !important;
        }

        .nav-tabs .active {
            font-size: 18px;
            font-family: hanaM;
            color: #008485 !important;
            background-color: white !important;
        }

        .tab-content .show {
            color: black !important;
            background-color: white !important;
        }

        #demo-wrapper {
            max-width: 1000px;
            margin: 0 auto;
            height: 560px;
            background: white;
        }

        #map-box {
            width: 80%;
            float: left;
        }

        #container {
            height: 500px;
        }

        #side-box {
            float: right;
            width: 16%;
            margin: 100px 1% 0;
            padding-left: 1%;
            border-left: 1px solid silver;
            display: none;
        }

        #info-box {
            margin-top: 10px;
        }

        .or-view-as {
            margin: 0.5em 0;
        }

        #up {
            line-height: 30px;
            height: 30px;
            max-width: 400px;
            margin: 0 auto;
        }

        #up a {
            cursor: pointer;
            padding-left: 40px;
        }

        #chkDataLabels {
            display: inline;
        }

        .selector {
            height: 40px;
            max-width: 400px;
            margin: 0 auto;
            position: relative;
        }

        .selector .prev-next {
            position: absolute;
            padding: 0 10px;
            font-size: 30px;
            line-height: 20px;
            background: white;
            font-weight: bold;
            color: #999;
            top: -2px;
            display: none;
            border: none;
        }

        .selector .custom-combobox {
            display: block;
            position: absolute;
            left: 40px;
            right: 65px;
        }

        .selector .custom-combobox .custom-combobox-input {
            position: absolute;
            font-size: 14px;
            color: silver;
            border-radius: 3px 0 0 3px;
            height: 32px;
            display: block;
            background: url("https://www.highcharts.com/samples/graphics/search.png") 5px 8px no-repeat white;
            padding: 1px 5px 1px 30px;
            width: 100%;
            box-sizing: border-box;
        }

        .selector .custom-combobox .ui-autocomplete-input:focus {
            color: black;
        }

        .selector .custom-combobox .ui-autocomplete-input.valid {
            color: black;
        }

        .selector .custom-combobox-toggle {
            position: absolute;
            display: block;
            right: -32px;
            border-radius: 0 3px 3px 0;
            height: 32px;
            width: 32px;
        }

        .selector #btn-next-map {
            right: -12px;
        }

        .ui-autocomplete {
            max-height: 500px;
            overflow: auto;
        }

        .ui-autocomplete .option-header {
            font-style: italic;
            font-weight: bold;
            margin: 5px 0;
            font-size: 1.1em;
            color: gray;
        }

        .loading {
            margin-top: 10em;
            text-align: center;
            color: gray;
        }

        .ui-button-icon-only .ui-button-text {
            height: 26px;
            padding: 0 !important;
            background: white;
        }

        #info-box .button {
            border: none;
            border-radius: 3px;
            background: #a4edba;
            padding: 5px;
            color: black;
            text-decoration: none;
            font-size: 12px;
            white-space: nowrap;
            cursor: pointer;
            margin: 0 3px;
            line-height: 30px;
        }

        @media (max-width: 768px) {
            #demo-wrapper {
                width: auto;
                height: auto;
            }

            #map-box {
                width: auto;
                float: none;
            }

            #container {
                height: 310px;
            }

            #side-box {
                float: none;
                width: auto;
                margin-top: 0;
                border-left: none;
                border-top: 1px solid silver;
            }

            .highcharts-grid{
	            display: none !important;
            }
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
		<div class="ms-5 fs-5" style="color: #bdbdbd">여행계획 / <strong style="color: #000000">여행추천정보</strong></div>
		<div class="container-fluid pt-4 px-5">
			<div class="row g-4">
				<nav>
					<div class="nav nav-tabs border-0" id="nav-tab" role="tablist">
						<button class="nav-link active me-2" style="border-radius: 7px 7px 0 0" id="nav-home-tab"
						        data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab"
						        aria-controls="nav-home" aria-selected="true">목표 여행지 순위
						</button>
						<button class="nav-link me-2" style="border-radius: 7px 7px 0 0" id="nav-profile-tab"
						        data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab"
						        aria-controls="nav-profile" aria-selected="false">환율별 여행지 순위
						</button>
						<button class="nav-link" style="border-radius: 7px 7px 0 0" id="nav-contact-tab"
						        data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab"
						        aria-controls="nav-contact" aria-selected="false">20대 남/여 여행지 순위
						</button>
					</div>
				</nav>
				<div class="tab-content mt-0 col-12" id="nav-tabContent">
					<div class="tab-pane fade show active bg-white p-4 box"
					     style="min-height: 300px; border-radius: 0 15px 15px 15px" id="nav-home" role="tabpanel"
					     aria-labelledby="nav-home-tab">
						<div class="row row-cols-1 row-cols-md-5 g-4">
						<c:forEach items="${targetRanking}" var="target" varStatus="status">
							<c:if test="${status.index < 5}">
								<div class="col">
									<div class="card">
										<img src="/resources/img/${target.countryNm}.jpg" class="card-img-top" style="height: 150px" alt="...">
										<div class="card-body">
											<c:if test="${status.index == 0}">
												<h5 class="card-title rounded-circle" style="color: #D5A11E"><i class="fa-solid fa-medal"></i> ${target.countryKrNm}</h5>
												<hr>
												<p class="card-text mb-0 text-black-50" style="font-family: hanaM">여행계획정보</p>
												<p class="card-text mb-0" style="font-family: hanaM">평균 여행기간 5일</p>
												<p class="card-text mb-0" style="font-size:15px;font-family: hanaM">38%의 손님이 여행계획 지정</p>
											</c:if>
											<c:if test="${status.index == 1}">
												<h5 class="card-title rounded-circle" style="color: #A3A3A3"><i class="fa-solid fa-medal"></i> ${target.countryKrNm}</h5>
												<hr>
												<p class="card-text mb-0 text-black-50" style="font-family: hanaM">여행계획정보</p>
												<p class="card-text mb-0" style="font-family: hanaM">평균 여행기간 4일</p>
												<p class="card-text mb-0" style="font-size:15px;font-family: hanaM">24%의 손님이 여행계획 지정</p>
											</c:if>
											<c:if test="${status.index == 2}">
												<h5 class="card-title rounded-circle" style="color: #CD7F32"><i class="fa-solid fa-medal"></i> ${target.countryKrNm}</h5>
												<hr>
												<p class="card-text mb-0 text-black-50" style="font-family: hanaM">여행계획정보</p>
												<p class="card-text mb-0" style="font-family: hanaM">평균 여행기간 5일</p>
												<p class="card-text mb-0" style="font-size:15px;font-family: hanaM">18%의 손님이 여행계획 지정</p>
											</c:if>
											<c:if test="${status.index == 3}">
												<h5 class="card-title text-dark rounded-circle">${status.index + 1}위 ${target.countryKrNm}</h5>
												<hr>
												<p class="card-text mb-0 text-black-50" style="font-family: hanaM">여행계획정보</p>
												<p class="card-text mb-0" style="font-family: hanaM">평균 여행기간 7일</p>
												<p class="card-text mb-0" style="font-size:15px;font-family: hanaM">13%의 손님이 여행계획 지정</p>
											</c:if>
											<c:if test="${status.index == 4}">
												<h5 class="card-title text-dark rounded-circle">${status.index + 1}위 ${target.countryKrNm}</h5>
												<hr>
												<p class="card-text mb-0 text-black-50" style="font-family: hanaM">여행계획정보</p>
												<p class="card-text mb-0" style="font-family: hanaM">평균 여행기간 12일</p>
												<p class="card-text mb-0" style="font-size:15px;font-family: hanaM">7%의 손님이 여행계획 지정</p>
											</c:if>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
						</div>
					</div>
					<div class="tab-pane fade bg-white p-4 box"
					     style="min-height: 300px; border-radius: 0 15px 15px 15px" id="nav-profile" role="tabpanel"
					     aria-labelledby="nav-profile-tab">
						<div class="row row-cols-1 row-cols-md-5 g-4">
							<c:forEach items="${excRateRanking}" var="excRate" varStatus="status">
								<c:if test="${status.index < 5}">
									<div class="col">
										<div class="card">
											<img src="/resources/img/${excRate.ccyCode}.jpg" class="card-img-top" style="height: 150px" alt="...">
											<div class="card-body">
												<c:if test="${status.index == 0}">
													<h5 class="card-title rounded-circle" style="color: #D5A11E"><i class="fa-solid fa-medal"></i> ${excRate.cntryKrNm}</h5>
												</c:if>
												<c:if test="${status.index == 1}">
													<h5 class="card-title rounded-circle" style="color: #A3A3A3"><i class="fa-solid fa-medal"></i> ${excRate.cntryKrNm}</h5>
												</c:if>
												<c:if test="${status.index == 2}">
													<h5 class="card-title rounded-circle" style="color: #CD7F32"><i class="fa-solid fa-medal"></i> ${excRate.cntryKrNm}</h5>
												</c:if>
												<c:if test="${status.index > 2}">
													<h5 class="card-title text-dark rounded-circle">${status.index + 1}위 ${excRate.cntryKrNm}</h5>
												</c:if>
												<hr>
												<p class="card-text mb-0 text-black-50" style="font-family: hanaM">환율정보</p>
												<p class="card-text mb-0 text-black-50" style="font-family: hanaM">${excRate.ccyCode}</p>
												<p class="card-text mb-0" style="font-family: hanaM">매매기준율 ${excRate.basicRate} <br>(USD ${excRate.usdRate})</p>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="tab-pane fade bg-white p-4 box"
					     style="min-height: 300px; border-radius: 0 15px 15px 15px" id="nav-contact" role="tabpanel"
					     aria-labelledby="nav-contact-tab"></div>
				</div>
				<div class="col-12">
					<div class="text-center fs-3 text-black-50 mb-0" style="font-family: hanaM;">
						9월의 추천 여행지
						<lord-icon
								src="https://cdn.lordicon.com/mdgrhyca.json"
								trigger="loop"
								delay="2000"
								stroke="80"
								colors="primary:#ffca28"
								style="width:40px;height:40px; margin-bottom: 5px">
						</lord-icon>
					</div>
					<div id="carouselExampleControlsNoTouching" class="carousel slide" data-bs-touch="false">
						<div class="carousel-inner">
							<div class="carousel-item active d-flex pt-3 pb-3 justify-content-center" id="carousel">
								<figure class="text-center me-4">
									<img src="/resources/img/swiss.jpg" class="rounded-circle"
									     style="width: 124px; height: 124px" alt="...">
									<figcaption class="mt-2 row">
										<span class="fs-5 text-dark" style="font-family: hanaM">
											스위스
										</span>
										<span class="text-black-50" style="font-family: hanaL">
											<i class="fa-solid fa-heart text-hanared"></i> 7,249
										</span>
									</figcaption>
								</figure>
								<figure class="text-center me-4">
									<img src="/resources/img/bangkok.jpg" class="rounded-circle"
									     style="width: 124px; height: 124px" alt="...">
									<figcaption class="mt-2 row">
										<span class="fs-5 text-dark" style="font-family: hanaM">
											방콕
										</span>
										<span class="text-black-50" style="font-family: hanaL">
											<i class="fa-solid fa-heart text-hanared"></i> 10,522
										</span>
									</figcaption>
								</figure>
								<figure class="text-center me-4">
									<img src="/resources/img/france.jpg" class="rounded-circle"
									     style="width: 124px; height: 124px" alt="...">
									<figcaption class="mt-2 row">
										<span class="fs-5 text-dark" style="font-family: hanaM">
											프랑스
										</span>
										<span class="text-black-50" style="font-family: hanaL">
											<i class="fa-solid fa-heart text-hanared"></i> 5,692
										</span>
									</figcaption>
								</figure>
								<figure class="text-center me-4">
									<img src="/resources/img/korea.jpg" class="rounded-circle"
									     style="width: 124px; height: 124px;" alt="...">
									<figcaption class="mt-2 row">
										<span class="fs-5 text-dark" style="font-family: hanaM">
											한국
										</span>
										<span class="text-black-50" style="font-family: hanaL">
											<i class="fa-solid fa-heart text-hanared"></i> 21,330
										</span>
									</figcaption>
								</figure>
								<figure class="text-center me-4">
									<img src="/resources/img/hungary.jpg" class="rounded-circle"
									     style="width: 124px; height: 124px" alt="...">
									<figcaption class="mt-2 row">
										<span class="fs-5 text-dark" style="font-family: hanaM">
											헝가리
										</span>
										<span class="text-black-50" style="font-family: hanaL">
											<i class="fa-solid fa-heart text-hanared"></i> 4,299
										</span>
									</figcaption>
								</figure>
								<figure class="text-center me-3">
									<img src="/resources/img/japan.jpg" class="rounded-circle"
									     style="width: 124px; height: 124px" alt="...">
									<figcaption class="mt-2 row">
										<span class="fs-5 text-dark" style="font-family: hanaM">
											일본
										</span>
										<span class="text-black-50" style="font-family: hanaL">
											<i class="fa-solid fa-heart text-hanared"></i> 6,451
										</span>
									</figcaption>
								</figure>
								<figure class="text-center">
									<img src="/resources/img/italy.jpg" class="rounded-circle"
									     style="width: 124px; height: 124px" alt="...">
									<figcaption class="mt-2 row">
										<span class="fs-5 text-dark" style="font-family: hanaM">
											이탈리아
										</span>
										<span class="text-black-50" style="font-family: hanaL">
											<i class="fa-solid fa-heart text-hanared"></i> 12,805
										</span>
									</figcaption>
								</figure>
							</div>
						</div>
						<button class="carousel-control-prev" type="button"
						        data-bs-target="#carouselExampleControlsNoTouching" data-bs-slide="prev">
							<span class="carousel-control-prev-icon rounded-circle bg-dark mb-5"
							      style="opacity: 1; margin-left: -130px"
							      aria-hidden="true"></span>
							<span class="visually-hidden ">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
						        data-bs-target="#carouselExampleControlsNoTouching" data-bs-slide="next">
							<span class="carousel-control-next-icon rounded-circle bg-dark mb-5"
							      style="opacity: 1; margin-right: -130px"
							      aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
				</div>

				<div class="col-sm-12 col-xl-12 mb-4">
					<div class="h-100 bg-white rounded p-4 box">
						<div class="d-flex w-100">
							<h5 class="mb-0 text-dark">해외국가 여행경보</h5>
						</div>
						<div class="form-control ms-2 mt-3">
							<h6 class="text-black-50 fs-5">여행경보란?</h6>
							우리 국민이 스스로의 안전을 위하여 합리적으로 판단하고 위험에 사전 대비할 수 있도록 우리 국민의 거주·체류 및 방문에 주의가 요구되는 국가(지역)의 위험 수준을 알리고 <br>
							그에 따른 행동요령을 안내합니다.
						</div>
						<div class="w-100" id="demo-wrapper">
							<div id="map-box">
								<div id="up"></div>
								<div class="selector">
									<button id="btn-prev-map" class="prev-next" aria-label="Previous map"><i
											class="fa fa-angle-left"></i></button>
									<!-- Note: jQuery UI combobox should be replaced with an accessible widget -->
									<select aria-label="Select a map to display" id="mapDropdown"
									        class="ui-widget combobox"></select>
									<button id="btn-next-map" class="prev-next" aria-label="Next map"><i
											class="fa fa-angle-right"></i></button>
								</div>
								<div id="container"></div>
							</div>
							<div id="side-box">
								<input type="checkbox" id="chkDataLabels" checked='checked' style="width: 15px; height: 15px"/>
								<label for="chkDataLabels">국가이름표시</label>
								<div class="row" id="info-box">
									<h5 class="text-dark mb-2" style="font-family: hanaM">여행경보단계</h5>
									<div class="mb-1 d-flex" style="font-family: hanaL">
										1단계(여행유의)
										<div class="mt-1 ms-1" style="border: 0px solid black;background-color: #2d67b9; width: 15px;height: 15px"></div>
									</div>
									<div class="mb-1 d-flex" style="font-family: hanaL">
										2단계(여행자제)
										<div class="mt-1 ms-1" style="border: 0px solid black;background-color: #f3c553; width: 15px;height: 15px"></div>
									</div>
									<div class="mb-1 d-flex" style="font-family: hanaL">
										3단계(출국권고)
										<div class="mt-1 ms-1" style="border: 0px solid black;background-color: #b83723; width: 15px;height: 15px"></div>
									</div>
									<div class="mb-1 d-flex" style="font-family: hanaL">
										4단계(여행금지)
										<div class="mt-1 ms-1" style="border: 0px solid black;background-color: #292929; width: 15px;height: 15px"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/script.jsp"/>
<script src="https://code.highcharts.com/maps/highmaps.js"></script>
<script src="https://code.highcharts.com/mapdata/index.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.js"></script>
<script src="https://www.highcharts.com/samples/static/jquery.combobox.js"></script>
<script>
    var country_eng_nm = [];
    var country_nm = [];
    var alarm_lvl = [];
    var xhr = new XMLHttpRequest();
    var url = 'http://apis.data.go.kr/1262000/TravelAlarmService2/getTravelAlarmList2'; /*URL*/
    var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'EW%2BSR6nTiH5M5iQtJNX2Qn4%2BLQchYHdtfxgNFBfi91aFbOYcKA4TpbpMjcG%2FCGu0n5bMwQTh9axtDO4D4k8CNw%3D%3D'; /*Service Key*/
    queryParams += '&' + encodeURIComponent('returnType') + '=' + encodeURIComponent('JSON'); /**/
    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('197'); /**/
    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
    xhr.open('GET', url + queryParams, false);
    xhr.onreadystatechange = function () {
        if (this.readyState == 4) {
            var object = JSON.parse(this.responseText);
            for (var i = 0; i < 197; i++) {
                country_eng_nm.push(object.data[i].country_eng_nm)
                country_nm.push(object.data[i].country_nm)
                alarm_lvl.push(object.data[i].alarm_lvl)
            }
        }
    };
    xhr.send('');
    /**
     * This is a complicated demo of Highcharts Maps, not intended to get you up to
     * speed quickly, but to show off some basic maps and features in one single
     * place. For the basic demo, check out
     * https://www.highcharts.com/maps/demo/geojson instead.
     *
     * @todo
     * - Remove jQuery where not necessary
     */

// Base path to maps
    const baseMapPath = 'https://code.highcharts.com/mapdata/';

    let showDataLabels = true, // Switch for data labels enabled/disabled
        mapCount = 0,
        mapOptions = '';
	let colorsList = []
    // Populate dropdown menus and turn into jQuery UI widgets
    $.each(Highcharts.mapDataIndex, (mapGroup, maps) => {
        if (mapGroup !== 'version') {
            mapOptions += '<option class="option-header">' + mapGroup + '</option>';
            $.each(maps, (desc, path) => {
                for(var i = 0; i < 197; i++) {
                    if(country_eng_nm[i].toLowerCase() == desc.toLowerCase()) {
                        mapOptions += '<option value="' + path + '">' + country_nm[i] + '</option>';
                        mapCount += 1;
                    }
                }
            });
        }
    });


    const searchText = '국가를 검색하세요.';
    mapOptions = '<option value="custom/world.js">' + searchText + '</option>' + mapOptions;
    $("#mapDropdown").append(mapOptions).combobox();

    // Change map when item selected in dropdown
    $("#mapDropdown").on('change', async function () {
        const $selectedItem = $('option:selected', this),
            mapDesc = $selectedItem.text(),
            mapKey = this.value.slice(0, -3),
            svgPath = baseMapPath + mapKey + '.svg',
            geojsonPath = baseMapPath + mapKey + '.geo.json',
            topojsonPath = baseMapPath + mapKey + '.topo.json',
            javascriptPath = baseMapPath + this.value,
            isHeader = $selectedItem.hasClass('option-header');
        // Dim or highlight search box

        if (mapDesc === searchText || isHeader) {
            $('.custom-combobox-input').removeClass('valid');
            location.hash = '';
        } else {
            $('.custom-combobox-input').addClass('valid');
            location.hash = mapKey;
        }

        if (isHeader) {
            return false;
        }

        // Show loading
        if (Highcharts.charts[0]) {
            Highcharts.charts[0].showLoading(
                '<i class="fa fa-spinner fa-spin fa-2x"></i>'
            );
        }

        // Load the map
        let filesize = '';
        const mapData = await fetch(topojsonPath)
            .then(response => {
                const size = response.headers.get('content-length');
                if (size) {
                    filesize = Math.round(size / 1024) + ' kB';
                }
                return response.json();
            })
            .catch(e => console.log('Error', e));

        if (!mapData) {
            if (Highcharts.charts[0]) {
                Highcharts.charts[0].showLoading(
                    '<i class="fa fa-frown"></i> Map not found'
                );
            }
            return;
        }

        // Generate non-random data for the map
        const data = mapData.objects.default.geometries.map((g, value) => ({
            key: g.properties['hc-key'],
            value
        }));

        // Show arrows the first time a real map is shown
        if (mapDesc !== searchText) {
            $('.selector .prev-next').show();
            $('#side-box').show();
        }
        $('#side-box').show();
        // Is there a layer above this?
        const match = mapKey
            .match(/^(countries\/[a-z]{2}\/[a-z]{2})-[a-z0-9]+-all$/);
        let parent;
        if (/^countries\/[a-z]{2}\/[a-z]{2}-all$/.test(mapKey)) { // country
            parent = {
                desc: 'World',
                key: 'custom/world'
            };
        } else if (match) { // admin1
            parent = {
                desc: $('option[value="' + match[1] + '-all.js"]').text(),
                key: match[1] + '-all'
            };
        }

        $('#up').html('');
        if (parent) {
            $('#up').append(
                $('<a><i class="fa fa-angle-up"></i> ' + parent.desc + '</a>')
                    .attr({
                        title: parent.key
                    })
                    .on('click', function () {
                        $('#mapDropdown').val(parent.key + '.js').trigger('change');
                    })
            );
        }

        const formatter = function () {
            if(mapKey === 'custom/world' ||
                mapKey === 'countries/us/us-all') {
                for(var i = 0; i < 197; i++) {
                    if(country_eng_nm[i].toLowerCase() == this.point.properties['name'].toLowerCase())
                        return country_nm[i]
                }
            } else {
                return this.point.name;
            }
        };

        // On point click, look for a detailed map to drill into
        const onPointClick = function () {
            const key = this.key;
            $('#mapDropdown option').each(function () {
                if (this.value === 'countries/' + key.substr(0, 2) + '/' + key + '-all.js') {
                    $('#mapDropdown').val(this.value).trigger('change');
                }
            });
        };
        // Instantiate chart
        Highcharts.mapChart('container', {
            chart: {
                map: mapData,
	            width: 800,
	            height: 500,
	            round: 10
            },

            title: {
                text: null
            },
            accessibility: {
                series: {
                    descriptionFormat: '{series.name}, map with {series.points.length} areas.',
                    pointDescriptionEnabledThreshold: 50
                }
            },
            mapNavigation: {
                enabled: true,
                buttonOptions: {
                    alignTo: 'spacingBox',
                    x: 10
                }
            },
            colorAxis: {
                min: 0,
                stops: [
                    [1, '#292929'],
                    [2, '#f3c553'],
                    [3, '#b83723'],
                    [4, '#2d67b9'],
                ],
	            max: 4,
            },
            legend: {
                layout: 'vertical',
                align: 'left',
                verticalAlign: 'bottom'
            },
            series: [{
                data,
                joinBy: ['hc-key', 'key'],
                name: '여행경보',
                allowPointSelect: true,
	            // colors: colorsList,
                states: {
                    select: {
                        color: '#a4edba',
                        borderColor: 'black',
                        dashStyle: 'shortdot'
                    }
                },
                dataLabels: {
                    enabled: showDataLabels,
                    formatter,
                    style: {
                        fontWeight: 100,
                        fontSize: '14px',
	                    // 글자색
	                    color: '#000000',
                        textOutline: 'none'
                    }
                },
                point: {
                    events: {
                        click: onPointClick
                    }
                }
            }, {
                type: 'mapline',
                name: "Lines",
                accessibility: {
                    enabled: false
                },
                data: Highcharts.geojson(mapData, 'mapline'),
                /*
				data: [{
					geometry: mapData.objects.default['hc-recommended-mapview'].insets[0].geoBounds
				}],
				// */
                showInLegend: false,
                enableMouseTracking: false
            }]
        });
        console.timeEnd('map');

        showDataLabels = $("#chkDataLabels").prop('checked');
    });

    // Toggle data labels - Note: Reloads map with new random data
    $("#chkDataLabels").on('change', function () {
        showDataLabels = $("#chkDataLabels").prop('checked');
        $("#mapDropdown").trigger('change');
    });

    // Switch to previous map on button click
    $("#btn-prev-map").on('click', function () {
        $("#mapDropdown option:selected")
            .prev("option")
            .prop("selected", true)
            .trigger('change');
    });

    // Switch to next map on button click
    $("#btn-next-map").on('click', function () {
        $("#mapDropdown option:selected")
            .next("option")
            .prop("selected", true)
            .trigger('change');
    });

    // Trigger change event to load map on startup
    if (location.hash) {
        $('#mapDropdown').val(location.hash.substr(1) + '.js');
    }
    $('#mapDropdown').trigger('change');
</script>
</body>
</html>