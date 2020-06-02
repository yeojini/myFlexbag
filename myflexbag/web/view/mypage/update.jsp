<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.div_del{
	margin : 30px auto 10px auto; 
	padding : 10px;
	border : 1px dotted #888888;
}
</style>
<script>
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	function goPopup() {
		var pop = window.open("view/user/jusoPopup.jsp", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");
	};

	function jusoCallBack(roadFullAddr) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.	
		document.getElementById("userAddr").value = roadFullAddr;
	};

	function formChk(){
		var userId = $('#userId').val();
	    if (userId == 'sample') {
	    	alert("'sample'계정은 수정할 수 없습니다.")
	    	return false;
	    }
	    if (userId == 'admin') {
	    	alert("'admin'계정은 수정할 수 없습니다.")
	    	return false;
	    }
	    
		var form = document.userInfo;

		if (!form.pwd.value) {
			alert("비밀번호를 입력하세요.");
			form.pwd.focus();
			return false;
		}
		
		if (form.pwd.value.length < 4||form.pwd.value.length>12) {
				alert("비밀번호를 4~12자까지 입력해주세요.")
				form.pwd.focus();
				return false;
			}

		// 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
		if (form.pwd.value != form.pwdchk.value) {
			alert("비밀번호를 동일하게 입력하세요.");
			form.pwdchk.focus();
			return false;
		}

		if (!form.uname.value) {
			alert("이름을 입력하세요.");
			form.uname.focus();
			return false;
		}

		if (!form.birthdate.value) {
			alert("날짜를 입력하세요.");
			form.birthdate.focus();
			return false;
		}

		if (!form.email.value) {
			alert("메일 주소를 입력하세요.");
			form.email.focus();
			return false;
		}

		if (!form.phone.value) {
			alert("전화번호를 입력하세요.");
			form.phone.focus();
			return false;
		}

		if (isNaN(form.phone.value)) {
			alert("전화번호는 - 제외한 숫자만 입력해주세요.");
			form.phone.focus();
			return false;
		}

		if (!form.address.value) {
			alert("주소를 입력하세요.");
			return false;
		}
		
		var c = confirm("수정하시겠습니까?");
		if(c==true){
			return true;
		}else{
			return false;
		}
		
	};




$(document).ready(function(){
	
	$("#delBtn").click(function(){
		var id = $('#userId').val();
	    var pwd = $('#inputPwd').val();
	    if(pwd=="") {
	    	alert("비밀번호를 입력하세요");
	    	$('#inputPwd').focus();
	    	return;
	    }	
	    else{ 
	    	
	    	 $.ajax({
			        url:"delChk.mc",
			            type:"post",
			            data :{
			               id : id,
			               pwd : pwd
			            },
			            success:function(data){
			               if(data){
			                   var confirmval = confirm("정말 탈퇴하시겠습니까?");
			                   if (confirmval){
			                	   $("#delForm").attr("action","del.mc");
			                	   $("#delForm").submit();
			                   }
			               }
			               else{
			                  alert("비밀번호를 확인해주세요");
			                  return;
			               }
			            }
			 });
	    }
	});
})


</script>
<h1>회원 정보 수정</h1>
<div class="centermain">
	<form action="uupdateimpl.mc" name=userInfo method="post" onsubmit="return formChk();">
		
		<label for="id">ID</label> 
		<div class="div_text">
		<input type="text" name=userid value=${user.userid } readonly="readonly" placeholder="ID"> <br>
		</div>
		
		<input	type="hidden" name=birthdate value=${user.birthdate }> 
		<input type="hidden" name=gender value=${user.gender }>
		<input	type="hidden" name=uno value=${user.uno }>
		
		<label for="password">PASSWORD</label> 
		<div class="div_text">
		<input type="password" name="pwd" placeholder="비밀번호"><br>
		</div>
		
		<label for="passwordconfirm">PASSWORD CONFIRM</label>
		<div class="div_text">
		<input type="password" name="pwdchk" placeholder="비밀번호 확인"><br>
		</div>
		
		<label for="name">NAME</label>
		<div class="div_text">
		<input type="text" name=uname value=${user.uname } readonly="readonly" placeholder="이름">
		</div>
		
		<label for="phonenum">PHONE NUMBER</label>
		<div class=div_text>
		<input type="tel" name="phone" value="${user.phone}" placeholder="핸드폰 번호"><br>
		</div>
		
		<label for="email">E-MAIL</label>
		<div class=div_text>
		<input type="email" name="email" value="${user.email}" placeholder="이메일"><br>
		</div>
		
		<label for="address">주소</label>
		<div class=div_text>
		<input type="text" name="address" value="${user.address }" id="userAddr" readonly style="margin-bottom:0.5em;" placeholder="주소"><br> 	
		<button type="button" onclick="goPopup()">주소검색</button>
		<br><br>
		</div>
		<input class="btn" type="submit" value="UPDATE" style="
				display: inline-block; padding: 6px 12px; margin-bottom: 0.1em;
				font-size: 14px;
				font-weight: normal;
				line-height: 1.42857143;
				text-align: center;
				white-space: nowrap;
				vertical-align: middle;
				-ms-touch-action: manipulation;
				touch-action: manipulation;
				cursor: pointer;
				-webkit-user-select: none;
				-moz-user-select: none;
				-ms-user-select: none;
				user-select: none;
				background-image: none;
				background-color: #1F50B5;
				border: 1px solid transparent;
				border-radius: 2px;
				color:white;
		">
		<input class="btn" type="button" value="CANCEL" onclick="mypage()"><br>
		<br><br><br><br><br>
		</form>
		<div class ="div_del" style="display:inline-block; width:70%;">
		<form method="post" name="delForm" id="delForm">
			<input type="hidden" name=userid value=${user.userid } id="userId"> 
			<input type="password" name="pwd" id = "inputPwd" required placeholder="비밀번호">
			<input type = "submit" id="delBtn" value="회원탈퇴">
		</form>
		</div>
</div>

