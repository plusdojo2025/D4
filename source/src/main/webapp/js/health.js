'use strict';

	window.addEventListener('DOMContentLoaded', function () {
 	 const form = document.forms["health"]
  
 	 form.onsubmit = function (event) {
	 const vegetable = form.vegetable.value;
	 const sleep_hour = form.sleep_hour.value;
     const sleep_minute = form.sleep_minute.value;   
	 const walk = form.walk.value.trim();	
	 const stress = form.stress.value; 	 
	 const stressLabel = {
		   "1":"低い",
		   "2":"普通",
		   "3":"高い"
	}[stress]	 
	 const weight = form.weight.value.trim();
	 
	 
	 
	/* 歩数　未入力または数値以外の入力をしたときの処理 */
	if (isNaN(walk)) {
	     alert("※運動量（歩数）は数字で入力してください。");
 	     event.preventDefault();
	     return false;
 	}
 	 
 	 //歩数　整数以外の時
 	if(!/^\d+$/.test(walk)){
	    alert("※運動量（歩数）は小数点なしの整数で入力してください");
	    event.preventDefault();
	    return false;
	}
 	   
 	/* 体重　未入力または数値以外の入力をしたときの処理 */
 	if ( isNaN(weight)) {
		alert("※体重は数字で入力してください。");
		event.preventDefault();
 		return false;
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
   
   
	 //歩数と体重　未入力の場合の処理
	 if(walk === '' || weight === ''){
	   alert("未入力の項目があります");
	  event.preventDefault();
	   return false;
	 }
	 
 	 
 	// 確認ダイアログ
    const isConfirmed = confirm(`以下の内容で送信しますか？\n\n 野菜摂取量: ${vegetable}\n 運動量（歩数）: ${walk} 歩\n ストレス度: ${stressLabel}\n 体重: ${weight} kg\n睡眠時間: ${sleep_hour} 時間 ${sleep_minute} 分`);

    if (!isConfirmed) {
    event.preventDefault(); // キャンセルされたら送信中止
    return false;
  }    
    
    return true;
  };
});