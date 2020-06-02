<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>

</style>

<nav class="woocommerce-pagination">
	<ul class="page-numbers">

		<!-- '<<' 이전 페이지 노출 여부 -->
		<c:if test="${pagenext.prev }">
			<li><a href="${base }?page=${pagenext.startPage -1}">&laquo;</a></li>
		</c:if>

		<!-- 페이지 번호 나열 -->
		<c:forEach begin="${pagenext.startPage }" end="${pagenext.endPage }"
			var="idx">
			<li <c:out value="${pagenext.page == idx ? 'class=active' : ''}"/>>
				<a href="${base }?page=${idx}">${idx }</a>
			</li>
		</c:forEach>

		<!-- '>>' 다음 페이지 버튼 노출 여부 -->
		<c:if test="${pagenext.next && pagenext.endPage >0 }">
			<li><a href="${base }?page=${pagenext.endPage +1 }">&raquo;</a></li>
		</c:if>

	</ul>
</nav>