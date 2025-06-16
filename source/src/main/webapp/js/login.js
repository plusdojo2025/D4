'use strict';

document.getElementById('loginForm').onsubmit = function(event) {
	//id
	const id = document.getElementById('textbox1');
	//pw
	const pw = document.getElementById('textbox2');
	
	if(id.value === ''){
		alert('IDが入力されていません');
 		event.preventDefault();
 		return;
	}
	
	if(pw.value === ''){
		alert('パスワードが入力されていません');
 		event.preventDefault();
 		return;
	}
	
	if(/[^a-zA-Z0-9]/.test(id)){
		alert('IDには英数字以外入力できません');
 		event.preventDefault();
 		return;
	}
	
	if(/[^a-zA-Z0-9]/.test(id)){
		alert('パスワードには英数字以外入力できません');
 		event.preventDefault();
 		return;
	}
	
	if(id.value.length > 20){
		alert('IDは20文字以内です');
 		event.preventDefault();
 		return;
	}
	
	if(pw.value.length > 20){
		alert('パスワードは20文字以内です');
 		event.preventDefault();
 		return;
	}
};