document.getElementById('loginForm').onsubmit = function(event) {
	//id
	const id = document.getElementById('textbox1');
	//pw
	const pw = document.getElementById('textbox2');
	
	if(id.value === ''){
		alert('IDが入力されていません');
 		event.preventDefault();
 		retrun;
	}
	
	if(pw.value === ''){
		alert('パスワードが入力されていません');
 		event.preventDefault();
 		retrun;
	}
	
	if(/[^a-zA-Z0-9]/.test(id)){
		alert('英数字以外は入力できません');
 		event.preventDefault();
 		retrun;
	}
	
	if(/[^a-zA-Z0-9]/.test(id)){
		alert('英数字以外は入力できません');
 		event.preventDefault();
 		retrun;
	}
	
	if(id.value.length > 20){
		alert('IDは20文字以内です');
 		event.preventDefault();
 		retrun;
	}
	
	if(pw.value.length > 20){
		alert('パスワードは20文字以内です');
 		event.preventDefault();
 		retrun;
	}
};