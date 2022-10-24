<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
							<div class="ms-5 fs-5" style="color: #bdbdbd">모임통장 / <strong
									style="color: #000000">나의통장</strong></div>
							<div class="container-fluid pt-4 px-4" id="myAccount">
								<div class="row g-4">
									<div class="col-sm-12 col-md-12 col-xl-12 d-flex justify-content-between">
										<a class="d-flex h-50 text-white rounded-3 p-4 align-items-center justify-content-center bg-hanagreen"
											href="#" style="width: 49%" onclick="show_myAccount()">
											<div>
												나의 통장
											</div>
										</a>
										<a class="d-flex h-50 text-white rounded-3 p-4 align-items-center justify-content-center bg-hanasilver"
											href="#" style="width: 49%" id="meetingBar" onclick="show_prtcpAccount()">
											<div>
												모임 통장
											</div>
										</a>
									</div>
									<c:forEach items="${accountList}" var="account" varStatus="count">
										<c:if test="${fn:length(account.prtcpList) == 1}">
											<div class="col-sm-12 col-md-6 col-xl-4">
												<div class="h-100 bg-white rounded p-4 box">
													<div class="d-flex w-100">
														<h5 class="mb-0 text-black-50" style="font-family: hanaM">
															${account.alias}</h5>
														<div style="margin-left: auto">
															<c:choose>
																<c:when test="${count.index % 3 eq 0}">
																	<i class="fa-solid fa-heart fa-2x"
																		style="color: #E90061"></i>
																</c:when>
																<c:when test="${count.index % 3 eq 1}">
																	<i class="fa-solid fa-users fa-2x"></i>
																</c:when>
																<c:when test="${count.index % 3 eq 2}">
																	<i class="fa-solid fa-plane fa-2x"
																		style="color: #008485; opacity: 0.6"></i>
																</c:when>
															</c:choose>
														</div>
													</div>
													<div class="d-flex align-items-center justify-content-between mb-2">
														<h6 class="mb-0 text-black-50" style="font-family: hana">
															${account.accountNo}</h6>
													</div>
													<div class="d-flex align-items-center py-3">
														<div class="w-100 ms-3">
															<h2 class="text-center text-black-50">
																<fmt:formatNumber value="${account.balance}"
																	pattern="#,###" />원
															</h2>
														</div>
													</div>
													<c:if test="${account.ownerId == loginMember.id}">
														<div class="d-flex text-center pt-3">
															<div class="w-100 align-items-center">
																<a href="transfer">
																	<button
																		class="btn form-control text-white bg-hanagreen"
																		style="width: 49%">이체
																	</button>
																</a>
																<a href="#">
																	<button href=""
																		class="btn form-control text-white kakao-link-btn bg-hanasilver"
																		onclick="shareKaKao('${account.accountNo}')"
																		style="width: 49%">
																		친구초대
																	</button>
																</a>
															</div>
														</div>
													</c:if>
												</div>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</div>
							<div class="container-fluid pt-4 px-4" id="openAccount">
								<div class="row g-4">
									<div class="col-sm-12 col-md-12 col-xl-12">
										<a href="/openAccount">
											<div class="d-flex h-50 rounded-3 p-4 align-items-center justify-content-center box"
												style="background-color: white">
												<i class="fa-solid fa-circle-plus fs-3 pe-4 text-hanagreen"></i>
												<span class="fs-5 text-black-50"></span>
											</div>
										</a>
									</div>
								</div>
							</div>
							<div class="container-fluid pt-4 px-4 mb-5 d-none" id="joinAccount">
								<div class="row g-4">
									<div class="col-sm-12 col-md-12 col-xl-12 d-flex justify-content-between">
										<a class="d-flex h-50 text-white rounded-3 p-4 align-items-center justify-content-center bg-hanagreen"
											href="#" style="width: 49%" id="myAccountBar" onclick="show_myAccount()">
											<div>
												나의 통장
											</div>
										</a>
										<a class="d-flex h-50 text-white rounded-3 p-4 align-items-center justify-content-center bg-hanagreen"
											href="#" style="width: 49%" onclick="show_prtcpAccount()">
											<div>
												모임 통장
											</div>
										</a>
									</div>
									<c:forEach items="${accountList}" var="account" varStatus="count">
										<c:if test="${fn:length(account.prtcpList) > 1}">
											<div class="col-sm-12 col-md-6 col-xl-4">
												<div class="h-100 bg-white rounded p-4 box">
													<div class="d-flex w-100">
														<h5 class="mb-0 text-black-50" style="font-family: hanaM">
															${account.alias}</h5>
														<div style="margin-left: auto">
															<c:choose>
																<c:when test="${count.index % 3 eq 0}">
																	<i class="fa-solid fa-heart fa-2x"
																		style="color: #E90061"></i>
																</c:when>
																<c:when test="${count.index % 3 eq 1}">
																	<i class="fa-solid fa-users fa-2x"></i>
																</c:when>
																<c:when test="${count.index % 3 eq 2}">
																	<i class="fa-solid fa-plane fa-2x"
																		style="color: #008485; opacity: 0.6"></i>
																</c:when>
															</c:choose>
														</div>
													</div>
													<div class="d-flex align-items-center justify-content-between mb-2">
														<h6 class="mb-0 text-black-50" style="font-family: hana">
															${account.accountNo}</h6>
													</div>
													<div class="d-flex align-items-center py-3">
														<div class="w-100 ms-3">
															<h2 class="text-center text-black-50">
																<fmt:formatNumber value="${account.balance}"
																	pattern="#,###" />원
															</h2>
														</div>
													</div>
													<c:if test="${account.ownerId == loginMember.id}">
														<div class="d-flex text-center pt-3">
															<div class="w-100 align-items-center">
																<a href="transfer">
																	<button
																		class="btn form-control text-white bg-hanagreen"
																		style="width: 49%">이체
																	</button>
																</a>
																<a href="#">
																	<button href=""
																		class="btn form-control text-white kakao-link-btn bg-hanasilver"
																		onclick="shareKaKao('${account.accountNo}')"
																		style="width: 49%">
																		친구초대
																	</button>
																</a>
															</div>
														</div>
													</c:if>
												</div>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
					<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
					<script>
						function shareKaKao(accountNo) {
							if (!Kakao.isInitialized()) {
								Kakao.init('key');
							}
							Kakao.Link.sendScrap({
								requestUrl: 'http://localhost:8090/',
								templateId: id,
								templateArgs: {
									ACCOUNTNO: accountNo,
									OWNERNAME: '${loginMember.name}',
									PROFILE: '${loginMember.name}',
									DESC: '${loginMember.name}님이 환전원큐 모임통장에 초대하였습니다.',
									TITLE: '모임통장 참여알림'
								}
							});
						}

						function show_prtcpAccount() {
							const joinAccount_show = document.getElementById('joinAccount');
							const myAccount_none = document.getElementById('myAccount');
							const openAccount_none = document.getElementById('openAccount');
							const myAccountBar = document.getElementById('myAccountBar');
							const meetingBar = document.getElementById('meetingBar');
							myAccount_none.classList.add('d-none');
							openAccount_none.classList.add('d-none');
							joinAccount_show.classList.remove('d-none');
							myAccountBar.classList.replace('bg-hanagreen', 'bg-hanasilver');
							meetingBar.classList.replace('bg-hanasilver', 'bg-hanagreen');
						}

						function show_myAccount() {
							const joinAccount_show = document.getElementById('joinAccount');
							const myAccount_none = document.getElementById('myAccount');
							const openAccount_none = document.getElementById('openAccount');
							const myAccountBar = document.getElementById('myAccountBar');
							const meetingBar = document.getElementById('meetingBar');
							myAccount_none.classList.remove('d-none');
							openAccount_none.classList.remove('d-none');
							joinAccount_show.classList.add('d-none');
							myAccountBar.classList.replace('bg-hanasilver', 'bg-hanagreen');
							meetingBar.classList.replace('bg-hanagreen', 'bg-hanasilver');
						}
					</script>
					<jsp:include page="../include/script.jsp" />
				</body>

				</html>