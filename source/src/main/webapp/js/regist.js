'use strict';

document.getElementById('loginForm').onsubmit = function(event) {
	//id
	const id = document.getElementById('textbox1');
	//pw
	const pw = document.getElementById('textbox2');
	//pw2
	const pw2 = document.getElementById('textbox3');
	//height
	const height = document.getElementById('textbox4');
	//weight
	const weight = document.getElementById('textbox5');
	//name
	const name = document.getElementById('textbox6');
	
	//未入力
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
	if(pw2.value === ''){
		alert('確認用パスワードが入力されていません');
 		event.preventDefault();
 		return;
	}
	if(height.value === ''){
		alert('身長が入力されていません');
 		event.preventDefault();
 		return;
	}
	if(weight.value === ''){
		alert('体重が入力されていません');
 		event.preventDefault();
 		return;
	}
	if(name.value === ''){
		alert('ニックネームが入力されていません');
 		event.preventDefault();
 		return;
	}
	
	//文字の種類による制限
	if(/[^a-zA-Z0-9]/.test(id)){
		alert('IDには英数字以外入力できません');
 		event.preventDefault();
 		return;
	}
	if(/[^a-zA-Z0-9]/.test(pw)){
		alert('パスワードには英数字以外入力できません');
 		event.preventDefault();
 		return;
	}
	if(/[^a-zA-Z0-9]/.test(pw2)){
		alert('確認用パスワードには英数字以外入力できません');
 		event.preventDefault();
 		return;
	}
	if(/[0-9]/.test(height)){
		alert('身長には整数以外入力できません');
 		event.preventDefault();
 		return;
	}
	if (isNaN(weight)) {
	  alert("体重には数値のみ入力してください");
	  event.preventDefault();
	  return;
	}
	
	// 身長と体重は負数ではない
	if (parseInt(height) <= 0) {
	  alert("身長は正の数で入力してください");
	  event.preventDefault();
	  return;
	}
	if (parseFloat(weight) <= 0) {
	  alert("体重は正の数で入力してください");
	  event.preventDefault();
	  return;
	}
	
	//文字数制限
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
	if(pw2.value.length > 20){
		alert('確認用パスワードは20文字以内です');
 		event.preventDefault();
 		return;
	}
	if(name.value.length > 20){
		alert('ニックネームは20文字以内です');
 		event.preventDefault();
 		return;
	}
	
	//pwとpw2の一致
	if(pw !== pw2){
		alert('パスワードと確認用パスワードが一致しません');
 		event.preventDefault();
 		return;
	}
	
	//変更前の確認
	if (!window.confirm(`送信します。よろしいですか？`)) {
		event.preventDefault();
		return;
    }
	
};