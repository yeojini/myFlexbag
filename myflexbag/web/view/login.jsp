<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
function loginBtnClicked() {
	var inputId = $('#inputId').val();
	var inputPwd = $('#inputPwd').val();
	if(inputId == ""){
		$('#msg').html("<p style='color:red'>아이디를 입력해주세요</p>");
        $("#inputId").focus();
        return;
	}
	 if (inputPwd == "") {
		 $('#msg').html("<p style='color:red'>비밀번호를 입력해주세요.</p>");
		 $("#inputPwd").focus();
		 return;
    }
	$.ajax({
		url : "login.mc",
		type : "post",
		data : {
			'inputId' : inputId,
			'inputPwd' : inputPwd
		},
		success : function(data) {
			if (data) {
				window.location.href = 'main.mc';
			} else {
				$('#msg').html("<p style='color:red'>로그인에 실패하였습니다! 아이디와 비밀번호를 확인해주세요.</p>");
			}
		}
	})
}

</script>

<div class=centermain>
	<form>

		<label for="ID">ID</label>
		<div class=div_text>
			<input type="text" id="inputId" placeholder="ID"
				style="margin-bottom: 0.5em;"><br>
		</div>

		<label for="PASSWORD">PASSWORD</label>
		<div class=div_text>
			<input type="password" id = "inputPwd" placeholder="비밀번호">
		</div>
		<div class = div_text id = "msg">
		</div>
		<div class=div_text>
			<input type="button" onclick="loginBtnClicked();" value="LOGIN"><br>
		</div>

	</form>
	<br>
	<br>
	<br> <label for="registermsg">회원이 아니신가요?</label><br>
	<div class=div_text>
		<a href="uadd.mc"><button type="button">REGISTER</button></a>
	</div>
</div>

