<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="../css/default.css" rel="stylesheet">
<link href="../css/front.css" rel="stylesheet">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TinyHome</title>
<!-- 우편주소 api -->
<!-- autoload=false 파라미터를 이용하여 자동으로 로딩되는 것을 막습니다. -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

	//주소
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample6_extraAddress").value = extraAddr;

						} else {
							document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
	}//주소
</script>
<!-- 우편주소 api -->
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript"></script>
<!-- 중복체크 -->
<script type="text/javascript">
//아이디 중복체크
function idCkOpen() {
	if(!document.joinFr.id.value){
		alert("아이디를 입력해주세요.");
		document.joinFr.id.focus();
		return;
	}
	var fid=document.joinFr.id.value;
	window.open("joinIdCheck.jsp?userid="+fid,"","width=400,height=200");
}
function inputIdCk() {
	document.joinFr.idDupCk.value ="N";
}
//아이디 중복체크

//닉네임 중복체크
function nickCkOpen() {
	if(!document.joinFr.nick.value){
		alert("닉네임을 입력해주세요.");
		document.joinFr.nick.focus();
		return;
	}
	var fnick=document.joinFr.nick.value;
	window.open("joinNickCheck.jsp?usernick="+fnick,"","width=400,height=200");
}
function inputNickCk() {
	  document.joinFr.nickDupCk.value = "N";
}
//닉네임 중복체크

//메일 중복체크
function mailCkOpen() {
	if(!document.joinFr.mail.value){
		alert("메일를 입력해주세요.");
		document.joinFr.mail.focus();
		return;
	}
	var fmail=document.joinFr.mail.value;
	window.open("joinMailCheck.jsp?usermail="+fmail,"","width=400,height=200");
}
function inputMailCk() {
	  document.joinFr.mailDupCk.value = "N";
}
//메일 중복체크 
</script>
<!-- 중복체크 -->
<!-- 회원가입 무결성 확인 -->
<script type="text/javascript">
function valCk() {
	//아이디 유무
	if(!document.joinFr.id.value){
		alert("아이디를 입력해주세요.");
		document.joinFr.id.focus();
		return false;
	}
	//아이디 길이
	if(document.joinFr.id.value.length<4){
		alert("아이디가 너무 짧습니다.");
		document.joinFr.pw.focus();
		return false;
	}
	//아이디  중복버튼 눌렀는지
	if(document.joinFr.idDupCk.value!="Y"){
		alert("아이디 중복체크를 해주세요.");
		return false;
	}
	//비밀번호 유무
	if(!document.joinFr.pw.value){
		alert("비밀번호를 입력해주세요.");
		document.joinFr.pw.focus();
		return false;
	}
	//비밀번호 길이
	if(document.joinFr.pw.value.length<8){
		alert("비밀번호가 너무 짧습니다.");
		document.joinFr.pw.focus();
		return false;
	}
	//비밀번호 확인
	if(!document.joinFr.pw2.value){
		alert("비밀번호를 입력해주세요.");
		document.joinFr.pw2.focus();
		return false;
	}
	if(document.joinFr.pw.value!=document.joinFr.pw2.value){
		alert("비밀번호를 동일하게 입력해주세요.");
		document.joinFr.pw.focus();
		return false;
	}
	//이름 유무
	if(!document.joinFr.name.value){
		alert("이름을 입력해주세요.");
		document.joinFr.name.focus();
		return false;
	}
	//닉네임
	if(!document.joinFr.nick.value){
		alert("닉네임을 입력해주세요.");
		document.joinFr.nick.focus();
		return false;
	}
	if(document.joinFr.nick.value<2){
		alert("닉네임이 너무 짧습니다.");
		document.joinFr.nick.focus();
		return false;
	}
	//닉네임 중복버튼 눌렀는지
	if(document.joinFr.nickDupCk.value!="Y"){
		alert("닉네임 중복체크를 해주세요.");
		return false;
	}
	//주민번호 앞 
	if(!document.joinFr.ju1.value){
		alert("주민등록번호 앞자리를 입력해주세요.");
		document.joinFr.ju1.focus();
		return false;
	}
	if(document.joinFr.ju1.value<6){
		alert("주민등록번호 앞자리를 입력해주세요.");
		document.joinFr.ju1.focus();
		return false;
	}
	if(isNaN(document.joinFr.ju1.value)){
		alert("주민등록번호에 숫자만 입력가능합니다.");
		document.joinFr.ju1.focus();
		return false;
	}
	//주민번호 뒤
	if(!document.joinFr.ju2.value){
		alert("주민등록번호 뒷자리를 입력해주세요.");
		document.joinFr.ju2.focus();
		return false;
	}
	if(isNaN(document.joinFr.ju2.value)){
		alert("주민등록번호에 숫자만 입력가능합니다.");
		document.joinFr.ju2.focus();
		return false;
	}
	//성별
	if(document.joinFr.gender.selectedIndex==0){
		alert("성별을 선택해주세요.");
		document.joinFr.gender.focus();
		return false;
	}
	//나이
	if(!document.joinFr.age.value){
		alert("나이를 입력해주세요.");
		document.joinFr.age.focus();
		return false;
	}
	if(isNaN(document.joinFr.age.value)){
		alert("나이에 숫자만 입력가능합니다.");
		document.joinFr.ju2.focus();
		return false;
	}
	//연락처
	if(!document.joinFr.phone.value){
		alert("연락번호를 입력해주세요.");
		document.joinFr.phone.focus();
		return false;
	}
	if(document.joinFr.phone.value<7){
		alert("연락번호가 너무 짧습니다.");
		document.joinFr.phone.focus();
		return false;
	}
	if(isNaN(document.joinFr.phone.value)){
		alert("연락번호에 숫자만 입력가능합니다.");
		document.joinFr.phone.focus();
		return false;
	}
	//메일
	if(!document.joinFr.mail.value){
		alert("메일을 입력해주세요.");
		document.joinFr.mail.focus();
		return false;
	}
	//메일  중복버튼 눌렀는지
	if(document.joinFr.mailDupCk.value!="Y"){
		alert("메일 중복체크를 해주세요.");
		return false;
	}
	//우편번호
	if(!document.joinFr.post.value){
		alert("우편번호를 입력해주세요.");
		document.joinFr.post.focus();
		return false;
	}
	//주소
	if(!document.joinFr.addr.value){
		alert("주소를 입력해주세요.");
		document.joinFr.addr.focus();
		return false;
	}
	//상세주소
	if(!document.joinFr.daddr.value){
		alert("상세주소를 입력해주세요.");
		document.joinFr.daddr.focus();
		return false;
	}
}
</script>
<!-- 회원가입 무결성 확인 -->
<!-- 기타 이벤트 함수 -->
<script type="text/javascript">
function ju1fun() {
	if (document.joinFr.ju1.value.length == 6) {
		document.joinFr.ju2.focus();
	}
}
function ju2fun() {
	if (document.joinFr.ju2.value.length == 1) {
		var val = document.joinFr.ju2.value.charAt(0);
		switch (val) {
		case "2":
		case "4":
			document.joinFr.gender.selectedIndex=1;
			break;
		case "1":
		case "3":
			document.joinFr.gender.selectedIndex=2;
			break;
		}
		
	}
}
function agefun() {
	var age=document.joinFr.ju1.value.substr(0,2);
	var ch=document.joinFr.ju2.value.charAt(0);
	var year = new Date().getFullYear();
	if(ch=='1' ||ch=='2'){age=year-(1900+Number(age))+1;}
	else if(ch=='3'||ch=='4'){age=year-(2000+Number(age))+1;}
	document.joinFr.age.value=age;
}

</script>
<!-- 기타 이벤트 함수 -->
</head>
<body>

<%
String id = (String)session.getAttribute("id");
if(id!=null){
	response.sendRedirect("../main/main.jsp");
}
%>
<div class="box_round">
	<!-- 헤더파일 -->
	<jsp:include page="../include/top.jsp"/>
	<!-- 헤더파일 -->
<div class="scroll">
	<!-- 헤더위치 -->
	<fieldset class="submitfield">
		<legend>회원가입</legend>
		<form action="joinPro.jsp" name="joinFr" method="post" onsubmit="return valCk();">
			<table>
				<tr>
					<td class="td_col" colspan="5">
					<input type="text" class="inputbox" name="id" placeholder="아이디" onkeydown="inputIdCk();" pattern="[A-za-z0-9]{4,12}" maxlength="12" autofocus autocomplete="off"></td>
					<td colspan="1">
					<input type="button" class="button" name="idCk" value="중복체크" onclick="idCkOpen();"> 
					<input type="hidden" name="idDupCk" value="N" /></td>
				</tr>
				<tr>
					<td colspan="6"><input type="password" class="inputbox" name="pw" placeholder="비밀번호 (특수문자 영문 숫자 조합 8글자 이상)" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$" maxlength="18"></td>
				</tr>
				<tr>
					<td colspan="6"><input type="password" class="inputbox" name="pw2" placeholder="비밀번호 확인 (특수문자 영문 숫자 조합 8글자 이상)" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$" maxlength="18"></td>
				</tr>
				<tr>
					<td colspan="6"><input type="text" class="inputbox" name="name" placeholder="이름" autocomplete="off"></td>
				</tr>
				<tr>
					<td class="td_col" colspan="3">
					<input type="text" name="nick" class="inputbox" placeholder="닉네임" onkeydown="inputNickCk();" pattern="[A-za-z0-9가-힣\s]{2,20}" maxlength="20" autofocus autocomplete="off"></td>
					<td colspan="3">
					<input type="button" class="button" name="nickCk" value="중복체크" onclick="nickCkOpen();"> 
					<input type="hidden" name="nickDupCk" value="N" /></td>
				</tr>
				<tr>
					<td class="td_col" colspan="3"><input type="text" class="inputbox" name="ju1" onkeyup="ju1fun();" placeholder="주민번호 앞"  pattern="[0-9\$]{6}" maxlength="6" autocomplete="off"></td>
					<td class="td_col" colspan="3"><input type="text" class="inputbox" name="ju2" onkeyup="ju2fun();" onblur="agefun();" placeholder="주민번호 뒤" pattern="[1-4]" maxlength="1"></td>
				</tr>
				<tr>
					<td colspan="6">
					<select name="gender" class="inputbox">
						<option name="gender">성별</option>
						<option name="gender" value="여자">여자</option>
						<option name="gender" value="남자">남자</option>
					</select></td>
				</tr>
				
				<tr>
					<td colspan="6">
						<input type="text" class="inputbox" name="age" onfocus="agefun();" placeholder="나이">
					</td>
				</tr>
				
				<tr>
					<td colspan="6"><input type="text" class="inputbox" name="phone" placeholder="연락번호 (-없이 입력해주세요.)" pattern="[0-9\$]{9,11}" maxlength="11" autocomplete="off"></td>
				</tr>
				<tr>
					<td class="td_col" colspan="3">
					<input type="text" name="mail" class="inputbox" placeholder="메일" onkeydown="inputMailCk();" pattern="[A-za-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" autocomplete="off"></td>
					<td colspan="3">
					<input type="button" class="button" name="mailCk" value="중복체크" onclick="mailCkOpen();"> 
					<input type="hidden" name="mailDupCk" value="N" /></td>
				</tr>
				<tr>
					<td class="td_col" colspan="3"><input type="text" class="inputbox" name="post" id="sample6_postcode" placeholder="우편번호"></td>
					<td colspan="3"><input type="button" class="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
				</tr>
				<tr>
					<td colspan="6"><input type="text" class="inputbox" class="inputbox" name="addr" id="sample6_address" placeholder="주소"></td>
				</tr>
				<tr>
					<td class="td_col" colspan="3"><input type="text" class="inputbox" name="daddr"id="sample6_detailAddress" placeholder="상세주소" autocomplete="off"></td>
					<td colspan="3"><input type="text" class="inputbox" id="sample6_extraAddress" placeholder="참고항목"></td>
				</tr>
				<tr>
				
					<td colspan="6"><input type="submit" class="button" id="subbutton" value="가입">
					<input type="button" class="button" id="subbutton" value="취소" onclick="location.href='../index.jsp'">
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	</div>
	<!-- 푸터파일 -->
	<jsp:include page="../include/bottom.jsp"/>
	<!-- 푸터파일 -->
</div>
</body>
</html>