'use strict';

document.getElementById('searchFriend_form').onsubmit = function(event) {
	const id = document.getElementById('searchFriend_form').friendId.value;
    if (id === ''){
    	alert('IDを入力してください');
      	event.preventDefault();
    }
    else if (/[^a-zA-Z0-9ぁ-んァ-ン一-龥々ー]/.test(id)) {
		alert('IDに記号は使えません');
 		event.preventDefault();
	}
};