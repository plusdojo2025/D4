'use strict';

document.getElementById('registForm').onsubmit = function(event) {
	//id
	const id = document.getElementById('textbox1').value;
	//pw
	const pw = document.getElementById('textbox2').value;
	//pw2
	const pw2 = document.getElementById('textbox3').value;
	//height
	const height = document.getElementById('textbox4').value;
	//weight
	const weight = document.getElementById('textbox5').value;
	//name
	const name = document.getElementById('textbox6').value;
	
	//未入力
	if(id === ''){
		alert('IDが入力されていません');
 		event.preventDefault();
 		return;
	}
	if(name === ''){
		alert('ニックネームが入力されていません');
 		event.preventDefault();
 		return;
	}
	if(pw === ''){
		alert('パスワードが入力されていません');
 		event.preventDefault();
 		return;
	}
	if(pw2 === ''){
		alert('確認用パスワードが入力されていません');
 		event.preventDefault();
 		return;
	}
	if(height === ''){
		alert('身長が入力されていません');
 		event.preventDefault();
 		return;
	}
	if(weight === ''){
		alert('体重が入力されていません');
 		event.preventDefault();
 		return;
	}
	
	
	//文字の種類による制限
	if(/[^a-zA-Z0-9]/.test(id)){
		alert('IDには英数字以外入力できません');
 		event.preventDefault();
 		return;
	}
	if(/[^a-zA-Z0-9!-/:-@#]/.test(pw)){
		alert('パスワードには英数字以外入力できません');
 		event.preventDefault();
 		return;
	}
	if(/[^a-zA-Z0-9!-/:-@#]/.test(pw2)){
		alert('確認用パスワードには英数字以外入力できません');
 		event.preventDefault();
 		return;
	}
	if(/[^0-9]/.test(height)){
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
	if (parseFloat(height) >= 999) {
	  alert("身長に入力した値を確認してください");
	  event.preventDefault();
	  return;
	}
	
	if (parseFloat(weight) <= 0) {
	  alert("体重は正の数で入力してください");
	  event.preventDefault();
	  return;
	}
	if (parseFloat(weight) >= 999) {
	  alert("体重に入力した値を確認してください");
	  event.preventDefault();
	  return;
	}
	
	//文字数制限
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
	if(pw2.length > 20){
		alert('確認用パスワードは20文字以内です');
 		event.preventDefault();
 		return;
	}
	if(name.length > 20){
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