<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand navbar-dark sticky-top px-4 py-0 pt-3 pb-3 me-1 ms-1" style="background-color: #f5f5f5">
	<div class="navbar-nav align-items-center ms-auto">
		<div class="d-flex align-items-center justify-content-center" style="white-space: nowrap">
			<span class="text-black-50">로그아웃</span>
			<a href="/logout" class="nav-link ms-2">
				<i class="fa-solid fa-right-from-bracket me-2 text-black-50 bg-white box"></i>
			</a>
		</div>
		<a href="#" class="sidebar-toggler flex-shrink-0 box" style="background-color: white">
			<i class="fa-solid fa-up-right-and-down-left-from-center text-black-50"></i>
		</a>
		<input class="form-control ms-2 bg-white border-0 box" type="search" placeholder="검색어를 입력하세요." aria-label="Search" id="search">
		<div class="nav-item dropdown">
			<a href="#" class="nav-link" data-bs-toggle="dropdown">
				<i id="mypagebar" class="fa-solid fa-bars text-black-50 bg-white box"></i>
			</a>
			<div class="dropdown-menu dropdown-menu-end border-0" style="background-color: white">
				<a href="#" class="dropdown-item text-black-50">서비스계획중</a>
				<a href="#" class="dropdown-item text-black-50">서비스계획중</a>
				<a href="#" class="dropdown-item text-black-50">서비스계획중</a>
			</div>
		</div>
	</div>
</nav>