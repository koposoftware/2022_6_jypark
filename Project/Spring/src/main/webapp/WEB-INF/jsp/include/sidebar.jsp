<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar pb-3">
	<nav class="navbar navbar-dark" style="background-color: #f5f5f5">
		<div class="container-fluid justify-content-center mt-3 mb-4">
			<a href="account" class="navbar-brand">
				<h4 style="color: #008485"><i class="fa fa-user-edit"></i> 환전원큐</h4>
			</a>
		</div>
		<div class="d-flex container-fluid mb-4">
			<div class="bg-success rounded-circle border border-2 border-white p-1 ms-2"></div>
			<div class="ms-0">
				<h7 class="text-light"><strong style="font-family: hanaM">${loginMember.name}</strong>님 안녕하세요.</h7>
				<br>
				<h8 class="text-light" id="mySessionTime">로그아웃 남은 시간 --:--</h8>
			</div>
		</div>
		<div class="navbar-nav w-100">
			<div class="container-fluid ps-4 h-100 fs-6 mb-3">
				<strong>모임통장</strong>
			</div>
			<a href="/account" class="nav-item nav-link"><i
					class="ms-3 fa-solid fa-money-check-dollar me-2 box"></i>나의통장</a>
			<a href="/transactionHistory" class="nav-item nav-link"><i
					class="ms-3 fa-solid fa-money-check-dollar me-2 box"></i>거래내역</a>
			<a href="/accountMember" class="nav-item nav-link"><i
					class="ms-3 fa-solid fa-money-check-dollar me-2 box"></i>멤버정보</a>

			<div class="container-fluid ps-4 h-100 fs-6 border-3 mt-4 mb-3">
				<strong>여행계획</strong>
			</div>
			<a href="/myTravelInfo" class="nav-item nav-link"><i class="ms-3 fa-solid fa-wallet me-2 box"></i>나의여행계획</a>
			<a href="/recommendTravel" class="nav-item nav-link"><i class="ms-3 fa-solid fa-wallet me-2 box"></i>여행추천정보</a>

			<div class="container-fluid ps-4 h-100 fs-6 border-3 mt-4 mb-3">
				<strong>환전지갑</strong>
			</div>
			<a href="/exchange" class="nav-item nav-link"><i class="ms-3 fa-solid fa-wallet me-2 box"></i>환전하기</a>
			<a href="/walletInfo" class="nav-item nav-link"><i class="ms-3 fa-solid fa-wallet me-2 box"></i>환전내역</a>
			<a href="/excReservation" class="nav-item nav-link"><i class="ms-3 fa-solid fa-wallet me-2 box"></i>환전예약</a>
			<a href="/exchangeRateInfo" class="nav-item nav-link"><i
					class="ms-3 fa-solid fa-wallet me-2 box"></i>환율정보</a>
			<div class="container-fluid ps-4 h-100 fs-6 border-3 mt-4 mb-3" style="min-height: 50px">
			</div>
		</div>
	</nav>
</div>