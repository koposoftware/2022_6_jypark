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
						<jsp:include page="../include/sidebar.jsp" />
						<a href="#" class="btn btn-lg bg-white border-0 btn-lg-square back-to-top"><i
								class="bi bi-arrow-up text-hanagreen"></i></a>
						<div class="content">
							<jsp:include page="../include/spinner.jsp" />
							<jsp:include page="../include/navbar.jsp" />
							<div class="ms-5 fs-5" style="color: #bdbdbd">모임통장 / <strong
									style="color: #000000">멤버정보</strong></div>
							<div class="container-fluid pt-4 px-4">
								<div class="row g-4">
									<c:forEach items="${accountList}" var="account" varStatus="count">
										<c:if test="${fn:length(account.prtcpList) > 1}">
											<div class="col-sm-12 col-md-6 col-xl-4">
												<div class="h-100 bg-white rounded p-4 box">
													<div class="d-flex w-100">
														<h7 class="mb-0 text-black-50" style="font-family: hana">
															${account.accountNo}</h7>
														<div style="margin-left: auto">
															<i class="fa-solid fa-ellipsis-vertical"></i>
														</div>
													</div>
													<div class="d-flex align-items-center justify-content-between mb-2">
														<h4 class="mb-0 text-black-50" style="font-family: hanaM">
															${account.alias}</h4>
													</div>
													<hr>
													<div class="d-flex align-items-center w-100 row">
														<div class="col-12">
															<span class="me-5">모임시작일</span>
															<span>
																<c:out
																	value="${fn:substring(account.openDate, 0, 10)}" />
															</span>
														</div>
														<div class="col-12">
															<span class="me-5">모임태그</span>
															<c:if test="${count.index eq 0}">
																<span class="ps-3">입출금통장</span>
															</c:if>
															<c:if test="${count.index != 0}">
																<span class="ps-3">여행모임통장</span>
															</c:if>
														</div>
													</div>
													<hr class="">
													<div class="d-flex align-items-center w-100 row">
														<div class="col-12">
															<span class="me-4"><i class="fa-solid fa-flag"></i></i>
																모임주</span>
															<span class="float-end">${account.prtcpList[0].name}</span>
														</div>
														<div class="col-12 mt-1">
															<span class="me-4"><i class="fa-solid fa-person fs-5"></i>
																모임멤버</span>
															<span
																class="float-end">${fn:length(account.prtcpList)}명</span>
														</div>
														<div class="row align-items-center">
															<div class="col me-4"><i class="fa-solid fa-bell"></i> 관련알림
															</div>
															<div
																class="col-md-3 offset-md-3 form-check form-switch me-2">
																<input type="checkbox"
																	class="form-check-input fs-3 ms-3" checked>
															</div>
														</div>
													</div>
													<hr>
													<div class="align-items-center bg-hanasilver rounded-3">
														<h6 class="text-white ps-2 pt-2">참여멤버</h6>
														<div class="w-100 ms-3 text-white pb-3">
															<c:forEach items="${account.prtcpList}" var="member">
																${member.name}
															</c:forEach>
														</div>
													</div>
													<div class="d-flex text-center pt-3">
														<div class="w-100 align-items-center">
															<a href="#">
																<button
																	class="btn form-control text-white kakao-link-btn bg-hanagreen w-100"
																	id="kakao-link-btn" style="width: 49%">모임통장 나가기
																</button>
															</a>
														</div>
													</div>
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
						Kakao.init('key');
						Kakao.Link.createScrapButton({
							container: '#kakao-link-btn',
							requestUrl: 'url',
							templateId: id,
							templateArgs: {
								PROFILE: '${loginMember.name}',
								DESC: '${loginMember.name}님이 환전원큐 모임통장에 초대하였습니다.',
								TITLE: '모임통장 참여알림'
							}
						});
					</script>
					<jsp:include page="../include/script.jsp" />
				</body>

				</html>