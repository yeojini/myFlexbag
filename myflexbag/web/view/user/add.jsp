<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>

	// 주소검색 팝업 호출
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do) 호출
	function goPopup() {
		var pop = window.open("view/user/jusoPopup.jsp", "pop", "width=570,height=420, scrollbars=yes, resizable=yes");
	};

	// 팝업페이지에서 주소입력 정보를 받아, 현 페이지에 정보를 등록
	function jusoCallBack(roadFullAddr) {
		document.getElementById("userAddr").value = roadFullAddr;
	};
	
	var idFlag = false;
	var pwdFlag = false;
	var pwdChkFlag = false;
	var nameFlag = false;
	var genderFlag = false;
	var phoneFlag = false;
	var emailFlag = false;
	var addrFlag = false;
	
	function showErrorMsg(oMsg,msg){
		var result = "<p style ='color:red'>"+msg+"</p>";
		oMsg.html(result);
	}
	
	function showSuccessMsg(oMsg,msg){
		var result = "<p style='color:blue'>"+msg+"</p>";
		oMsg.html(result);
	}
	
	function hideMsg(oMsg){
		oMsg.html("");
	}
	
	function setFocusToInputObject(oInput){
		oInput.focus();
	}
	
	function checkId(){
		if(idFlag) return true;
		var inputId = $("#inputId").val();
		var oMsg = $("#idMsg");
		var oInput =$("#inputId");
		if(inputId==""){
			showErrorMsg(oMsg,"필수 정보입니다.");
			setFocusToInputObject(oInput);
			return false;
		}
		var isID = /[a-z0-9]{5,11}$/;
		if(!isID.test(inputId)){ 
			showErrorMsg(oMsg,"5~11자의 영문 소문자, 숫자만 사용 가능합니다.");
			setFocusToInputObject(oInput);
			return false;
		}
		idFlag = false;
		$.ajax({
			url : "idChk.mc",
			type : "post",
			data : {
				'inputId' : inputId
			},
			success : function(data) {
				if (data) {
					showSuccessMsg(oMsg,"사용 가능한 아이디입니다.");
					idFlag = true;
				} else {
					showErrorMsg(oMsg,"중복된 아이디 입니다.");
					setFocusToInputObject(oInput);
				}
			}
		});
		return true;
	}
	
	function checkPwd(){
		if(pwdFlag) return true;
		
		var inputPwd = $('#inputPwd').val();
		var oMsg = $('#pwdChkMsg');
		var oInput =$('#inputPwd');
		
		if(inputPwd==""){
			showErrorMsg(oMsg,"필수 정보입니다.");
			setFocusToInputObject(oInput);
			return false;
		}

		var isValidPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/
		if(!isValidPwd.test(inputPwd)){ 
			showErrorMsg(oMsg,"비밀번호는 8자리 이상의 특수문자, 대소문자, 숫자의 조합입니다.");
			setFocusToInputObject(oInput);
			return false;
		}else{
			showSuccessMsg(oMsg,"사용 가능한 비밀번호 입니다.");
			pwdFlag = true;
		}
	}
	
	function checkPwdChk(){
		if(pwdChkFlag) return true;
		
		var inputPwdChk = $('#inputPwdChk').val();
		var inputPwd = $('#inputPwd').val();
		var oMsg = $('#pwdConfirmMsg');
		var oInput = $('#inputPwdChk');
		
		if(inputPwdChk==""){
			showErrorMsg(oMsg,"필수 정보입니다.");
			setFocusToInputObject(oInput);
			return false;
		}
		
		if(inputPwdChk != inputPwd){
			showErrorMsg(oMsg,"비밀번호가 일치하지 않습니다.");
			setFocusToInputObject(oInput);
			return false;
		}else{
			showSuccessMsg(oMsg,"비밀번호가 일치합니다.")
			pwdChkFlag = true;
			return true;
		}
	}
	
	function checkName(){
		if(nameFlag) return true;
		var inputName = $('#inputName').val();
		var oMsg = $('#nameMsg');
		var oInput = $('#inputName');
		
		if(inputName==""){
			showErrorMsg(oMsg,"필수 정보입니다.");
			setFocusToInputObject(oInput);
			return false;
		}
		var isValidName =  /^[가-힣]{2,4}$/;
		if(!isValidName.test(inputName)){
			showErrorMsg(oMsg,"적합한 이름 형식이 아닙니다.");
			setFocusToInputObject(oInput);
			return false;
		}else{
			nameFlag=true;
			hideMsg(oMsg);
			return true;
		}
	}
	
	function checkGender(){
		if(genderFlag) return true;
		var oMsg = $('#genderMsg');
		if  (!$(":input:radio[name=gender]:checked").val()){
			genderFlag = false;
			showErrorMsg(oMsg,"필수 정보입니다.");
			return false;
		} else {
			genderFlag = true;
			hideMsg(oMsg);
		}
	}
	
	function checkPhone(){
		if(phoneFlag) return true;
		var inputPhone = $('#inputPhone').val();
		var oMsg = $('#phoneMsg');
		var oInput = $('#inputPhone');
		
		if(inputPhone==""){
			showErrorMsg(oMsg,"필수 정보입니다.");
			setFocusToInputObject(oInput);
			return false;
		}
		var isValidNumber = /^[0-9]*$/; 
		if(!isValidNumber.test(inputPhone)){
			showErrorMsg(oMsg,"숫자만 입력해 주세요.");
			setFocusToInputObject(oInput);
			return false;
		}else{
			phoneFlag=true;
			hideMsg(oMsg);
			return true;
		}
	}

	
	function checkEmail(){
		if(emailFlag) return true;
		var inputEmail = $('#inputEmail').val();
		var oMsg = $('#emailMsg');
		var oInput = $('#inputEmail');
		
		if(inputEmail==""){
			showErrorMsg(oMsg,"필수 정보입니다.");
			setFocusToInputObject(oInput);
			return false;
		}
		var isValidEmail = 
			/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(!isValidEmail.test(inputEmail)){
			showErrorMsg(oMsg,"적합한 이메일 형식이 아닙니다.");
			setFocusToInputObject(oInput);
			return false;
		}else{
			showSuccessMsg(oMsg,"사용 가능한 이메일입니다.");
			emailFlag=true;
			return true;
		}
	}
	
	function checkAddr(){
		if(addrFlag) return true;
		var inputAddr = $('#userAddr').val();
		console.log(inputAddr);
		var oMsg = $('#addrMsg');
		var oInput = $('#userAddr');
		
		if(inputAddr==""){
			showErrorMsg(oMsg,"필수 정보입니다.");
			setFocusToInputObject(oInput);
			return false;
		}
		else
		{
			showSuccessMsg(oMsg,"");
			addrFlag=true;
			return true;
		}
	}

	$(document).ready(function(){
		$('#inputId').blur(function() {
			idFlag = false;
			checkId();
		});
		$('#inputPwd').blur(function() {
			pwdFlag = false;
			checkPwd();
		});
		$('#inputPwdChk').keyup(function() {
			pwdChkFlag = false;
			checkPwdChk();
		});
		$('#inputPhone').blur(function() {
			phoneFlag=false;
			checkPhone();
		});
		$('#inputName').blur(function() {
			nameFlag=false;
			checkName();
		});
		$("input:radio[name=gender]").click(function(){
			genderFlag = true;
			hideMsg($('#genderMsg'));
		})
		$('#inputEmail').blur(function(){
			emailFlag=false;
			checkEmail();
		});
		
	});

	function joinChk() {
		if(checkId() & checkPwd() & checkPwdChk() & checkName() & checkGender() 
				& checkPhone() & checkEmail() & checkAddr()) return true;
		else return false;
		
	};

</script>
<body>
	<h2>Register</h2>
	<div class=centermain>
	<form action="uaddimpl.mc" method="post" name="userInfo" onsubmit="return joinChk();">
			<label for="ID">ID</label>
			<div class="div_text">
				<input type="text" name ="userid" id="inputId" placeholder="ID"
					style="margin-bottom: 0.5em;"><br>
				<div id="idMsg"></div>
			</div>

			<label for="PASSWORD">PASSWORD</label>
			<div class=div_text>
				<input type="password" name ="pwd" id="inputPwd" placeholder="비밀번호">
				<div id="pwdChkMsg"></div>
			</div>

			<label for="PASSWORDCONFIRM">PASSWORD CONFIRM</label>
			<div class=div_text>
				<input type="password" id="inputPwdChk" placeholder="비밀번호 확인">
				<div id="pwdConfirmMsg"></div>
			</div>

			<label for="NAME">NAME</label>
			<div class=div_text>
				<input type="text" name="uname" id="inputName" placeholder="이름">
				<div id="nameMsg"></div>
			</div>

			<label for="GENDER">GENDER</label>
			<div class=div_text>
				<input type="radio" name="gender"  value="M">남성 
				<input type="radio" name="gender"  value="F">여성
				<div id="genderMsg"></div>
			</div>

			<label for="PHONE NUMBER">PHONE NUMBER</label>
			<div class=div_text>
				<input type="tel" name="phone" id="inputPhone" placeholder="핸드폰 번호"><br>
				<div id="phoneMsg"></div>
			</div>

			<label for="email">E-mail</label>
			<div class=div_text>
				<input type="email" name="email" id ="inputEmail" placeholder="이메일"><br>
				<div id = "emailMsg"></div>
			</div>

			<label for="address">ADDRESS</label>
			<div class=div_text>
				<input type="text" name="address" placeholder="주소" id="userAddr"
					readonly style="margin-bottom: 0.5em;"><br>
				<button class="btn" type="button" onclick="goPopup()">주소검색</button>
				<div id = "addrMsg"></div>
			</div>

			<div style="margin: 5em auto;">
				<input class="btn" type="submit" value="REGISTER NOW"
					style="display: inline-block; padding: 6px 12px; margin-bottom: 0.1em; font-size: 14px; font-weight: normal; line-height: 1.42857143; text-align: center; white-space: nowrap; vertical-align: middle; -ms-touch-action: manipulation; touch-action: manipulation; cursor: pointer; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; background-image: none; background-color: #CC3D3D; border: 1px solid transparent; border-radius: 2px; color: white;"><br>
			</div>

		</form>
	</div>
</body>