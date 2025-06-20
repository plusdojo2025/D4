'use strict';

document.getElementById('searchFriend_form').onsubmit = function(event) {
	const id = document.getElementById('searchFriend_form').friendId.value;
    if (id === ''){
    	alert('IDを入力してください');
      	event.preventDefault();
    }
    else if(/[^a-zA-Z0-9]/.test(id)){
		alert('IDには英数字以外入力できません');
 		event.preventDefault();
	}
	
};