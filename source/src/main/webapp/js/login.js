'use strict';

document.getElementById('loginForm').onsubmit = function(event) {
	//id
	const id = document.getElementById('textbox1').value;
	//pw
	const pw = document.getElementById('textbox2').value;
	
	if(id === ''){
		alert('IDが入力されていません');
 		event.preventDefault();
 		return;
	}
	
	if(pw === ''){
		alert('パスワードが入力されていません');
 		event.preventDefault();
 		return;
	}
	
	if(/[^a-zA-Z0-9]/.test(id)){
		alert('IDには英数字以外入力できません');
 		event.preventDefault();
 		return;
	}
	
	if(/[^a-zA-Z0-9!-/:-@#]/.test(pw)){
		alert('パスワードには英数字と記号以外入力できません');
 		event.preventDefault();
 		return;
	}
	
	if(id.length > 20){
		alert('IDは20文字以内です');
 		event.preventDefault();
 		return;
	}
	
	if(pw.length > 20){
		alert('パスワードは20文字以内です');
 		event.preventDefault();
 		return;
	}
};