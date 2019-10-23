<%@page import="tinyHome.member.MemberBean"%>
<%@page import="tinyHome.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!-- 중복체크 -->
<script type="text/javascript">
//닉네임 중복체크
function nickCkOpen() {
	if(!document.updateFr.nick.value){
		alert("닉네임을 입력해주세요.");
		document.updateFr.nick.focus();
		return;
	}
	var fnick=document.updateFr.nick.value;
	window.open("joinNickCheck.jsp?usernick="+fnick,"","width=400,height=200");
}
function inputNickCk() {
	  document.updateFr.nickDupCk.value = "N";
}
//닉네임 중복체크

//메일 중복체크
function mailCkOpen() {
	if(!document.updateFr.mail.value){
		alert("메일를 입력해주세요.");
		document.updateFr.mail.focus();
		return;
	}
	var fmail=document.updateFr.mail.value;
	window.open("joinMailCheck.jsp?usermail="+fmail,"","width=400,height=200");
}
function inputMailCk() {
	  document.updateFr.mailDupCk.value = "N";
}
//메일 중복체크 
</script>
<!-- 중복체크 -->
<!-- 회원수정 무결성 확인 -->
<script type="text/javascript">
function valCk() {
	//비밀번호 유무
	if(!document.updateFr.pw.value){
		alert("비밀번호를 입력해주세요.");
		document.updateFr.pw.focus();
		return false;
	}
	//닉네임
	if(!document.updateFr.nick.value){
		alert("닉네임을 입력해주세요.");
		document.updateFr.nick.focus();
		return false;
	}
	if(document.updateFr.nick.value<2){
		alert("닉네임이 너무 짧습니다.");
		document.updateFr.nick.focus();
		return false;
	}
	//닉네임 중복버튼 눌렀는지
	if(document.updateFr.nickDupCk.value!="Y"){
		alert("닉네임 중복체크를 해주세요.");
		return false;
	}
	//연락처
	if(!document.updateFr.phone.value){
		alert("연락번호를 입력해주세요.");
		document.updateFr.phone.focus();
		return false;
	}
	if(document.updateFr.phone.value<7){
		alert("연락번호가 너무 짧습니다.");
		document.updateFr.phone.focus();
		return false;
	}
	if(isNaN(document.updateFr.phone.value)){
		alert("연락번호에 숫자만 입력가능합니다.");
		document.updateFr.phone.focus();
		return false;
	}
	//메일
	if(!document.updateFr.mail.value){
		alert("메일을 입력해주세요.");
		document.updateFr.mail.focus();
		return false;
	}
	//메일  중복버튼 눌렀는지
	if(document.updateFr.mailDupCk.value!="Y"){
		alert("메일 중복체크를 해주세요.");
		return false;
	}
	//우편번호
	if(!document.updateFr.post.value){
		alert("우편번호를 입력해주세요.");
		document.updateFr.post.focus();
		return false;
	}
	//주소
	if(!document.updateFr.addr.value){
		alert("주소를 입력해주세요.");
		document.updateFr.addr.focus();
		return false;
	}
	//상세주소
	if(!document.updateFr.daddr.value){
		alert("상세주소를 입력해주세요.");
		document.updateFr.daddr.focus();
		return false;
	}
}
</script>
<!-- 회원수정 무결성 확인 -->
</head>
<body>
<div class="box_round">
	<!-- 헤더파일 -->
	<jsp:include page="../include/top.jsp"/>
	<!-- 헤더파일 -->
<div class="scroll">
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	if (id==null) {
		response.sendRedirect("loginForm.jsp");
	}
	MemberDAO mdao = new MemberDAO();
	MemberBean mb = mdao.getMember(id);
%>
	<!-- 헤더위치 -->
	<fieldset class="submitfield">
		<legend>내 정보 수정</legend>
		<form action="updatePro.jsp" name="updateFr" method="post" onsubmit="return valCk();">
			<table>
				<tr>
					<td colspan="6">
					<input type="text" class="inputbox" name="id" value="<%=mb.getId() %>" readonly></td>
				</tr>
				<tr>
					<td colspan="6"><input type="password" class="inputbox" name="pw" placeholder="비밀번호 (특수문자 영문 숫자 조합 8글자 이상)" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$" maxlength="18"></td>
				</tr>
				<!-- <tr>
					<td colspan="6"><input type="password" class="inputbox" name="pw" placeholder="비밀번호 (특수문자 영문 숫자 조합 8글자 이상)"></td>
				</tr> 
				<tr>
					<td colspan="6"><input type="password" class="inputbox" name="newpw" placeholder="새 비밀번호 (특수문자 영문 숫자 조합 8글자 이상)" ></td>
				</tr>-->
				<tr>
					<td colspan="6"><input type="text" class="inputbox" value="<%=mb.getName() %>" readonly></td>
				</tr>
				<tr>
					<td colspan="4">
					<input type="text" name="nick" class="inputbox" placeholder="닉네임" onkeydown="inputNickCk();" value="<%=mb.getNick() %>"pattern="[a-zA-Z가-힣\s]{2,20}" maxlength="20" autofocus autocomplete="off"></td>
					<td colspan="2">
					<input type="button" name="nickCk" class="button" value="중복체크" onclick="nickCkOpen();"> 
					<input type="hidden" name="nickDupCk" value="Y" /></td>
				</tr>
				<tr>
					<td colspan="6"><input type="text" value="성별 <%=mb.getGender() %>" class="inputbox" readonly="readonly"></td>
				</tr>
				<tr>
					<td colspan="6"><input type="text" value="나이 <%=mb.getAge() %>" class="inputbox" readonly="readonly"></td>
				</tr>
				<tr>
					<td colspan="6"><input type="text" name="phone" class="inputbox" value="<%=mb.getPhone() %>"placeholder="연락번호 (-없이 입력해주세요.)" pattern="[0-9\$]{9,11}" maxlength="11" autocomplete="off"></td>
				</tr>
				<tr>
					<td colspan="4">
					<input type="text" name="mail" class="inputbox" placeholder="메일" value="<%=mb.getMail() %>"onkeydown="inputMailCk();" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" autocomplete="off"></td>
					<td colspan="2">
					<input type="button" name="mailCk" class="button" value="중복체크" onclick="mailCkOpen();"> 
					<input type="hidden" name="mailDupCk" value="Y" /></td>
				</tr>
				<tr>
					<td colspan="4"><input type="text" class="inputbox" name="post" value="<%=mb.getPost() %>" id="sample6_postcode" placeholder="우편번호"></td>
					<td colspan="2"><input type="button" class="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
				</tr>
				<tr>
					<td colspan="6"><input type="text" class="inputbox" name="addr" id="sample6_address" placeholder="주소"></td>
				</tr>
				<tr>
					<td colspan="4"><input type="text" class="inputbox"  name="daddr" id="sample6_detailAddress" placeholder="상세주소" autocomplete="off"></td>
					<td colspan="2"><input type="text" class="inputbox" id="sample6_extraAddress" placeholder="참고항목"></td>
				</tr>
				<!-- <tr>
					<td colspan="6">선택사항</td>
				</tr>
				<tr>
					<td colspan="6"><p>좋아하는 색깔</p>
						<label><input type="radio" name="color" value="red">빨간색</label>
						<label><input type="radio" name="color" value="brown">갈색</label>
						<label><input type="radio" name="color" value="orange">주황색</label>
						<label><input type="radio" name="color" value="yello">노란색</label>
						<label><input type="radio" name="color" value="green">초록색</label>
						<label><input type="radio" name="color" value="blue">파란색</label><br>
						<label><input type="radio" name="color" value="indigo">남색</label>
						<label><input type="radio" name="color" value="purple">보라색</label>
						<label><input type="radio" name="color" value="pink">분홍색</label>
						<label><input type="radio" name="color" value="white">흰색</label>
						<label><input type="radio" name="color" value="grey">회색</label>
						<label><input type="radio" name="color" value="black">검은색</label>
					</td>
				</tr>
				<tr>
					<td colspan="6"><p>취미/관심사</p> 
							<label><input type="checkbox" name="Hobbies" value="사진">사진</label> 
							<label><input type="checkbox" name="Hobbies" value="여행">여행</label> 
							<label><input type="checkbox" name="Hobbies" value="게임">게임</label> 
							<label><input type="checkbox" name="Hobbies" value="패션뷰티">패션뷰티</label> 
							<label><input type="checkbox" name="Hobbies" value="스포츠">스포츠</label><br>
							<label><input type="checkbox" name="Hobbies" value="TV">TV</label> 
							<label><input type="checkbox" name="Hobbies" id="" value="영화">영화</label>
							<label><input type="checkbox" name="Hobbies" id="" value="정치">정치</label> 
							<label><input type="checkbox" name="Hobbies" id="" value="과학">과학</label> 
							<label><input type="checkbox" name="Hobbies" id="" value="음악">음악</label> 
							<label><input type="checkbox" name="Hobbies" id="" value="독서">독서</label><Br>
							<label><input type="checkbox" name="Hobbies" id="" value="동물자연">동물자연</label>
							<label><input type="checkbox" name="Hobbies" id="" value="요리">요리</label> 
							<label><input type="checkbox" name="Hobbies" id="" value="수집">수집</label> 
							<label><input type="checkbox" name="Hobbies" id="" value="그림">그림</label> 
							<label><input type="checkbox" name="Hobbies" id="" value="역사">역사</label></td>
				</tr> -->
				<tr>
					<td colspan="6"><input type="submit" class="button" id="subbutton" value="수정"><input type="button" value="취소" class="button" id="subbutton" onclick="location.href='info.jsp'"></td>
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