//ポップアップを開く機能
function openPopup(id) {
  const popup = document.getElementById(id);
  if (!popup) return;
  popup.style.display = 'flex';

  // 背景クリックで閉じる
  function onBgClick(e) {
    if (e.target === popup) {
      closePopup(id);
    }
  }
  popup.addEventListener('click', onBgClick);

  // Escキーで閉じる
  function onEscKey(e) {
    if (e.key === 'Escape') {
      closePopup(id);
    }
  }
  document.addEventListener('keydown', onEscKey);

  // 閉じた時にイベントリスナーも外すために保持
  popup._onBgClick = onBgClick;
  popup._onEscKey = onEscKey;
}

//ポップアップを閉じる機能
function closePopup(id) {
  const popup = document.getElementById(id);
  if (!popup) return;
  popup.style.display = 'none';

  // イベントリスナー削除
  if (popup._onBgClick) {
    popup.removeEventListener('click', popup._onBgClick);
    popup._onBgClick = null;
  }
  if (popup._onEscKey) {
    document.removeEventListener('keydown', popup._onEscKey);
    popup._onEscKey = null;
  }
}

//アイコンの更新
function selectIcon(id, path) {
  document.getElementById('Icon').src = path;
  document.getElementById('IconId').value = path;
  closePopup('iconPopup');
}

//テーマの更新
function selectTheme(name) {
  document.getElementById('ThemeName').value = name;
  document.getElementById('Theme').textContent = name;
  closePopup('themePopup');
}

document.getElementById('UserInfo').onsubmit = function(event) {
	//pw
	const pw = document.getElementById('pw');
	//pwチェック用
	const newPw = document.getElementById('textbox2').value;
	const checkPw = document.getElementById('textbox3').value;
	//身長チェック用
	const height = document.getElementById('textbox4').value;
	//ニックネームチェック用
	const name = document.getElementById('textbox5').value;
	
	//PW変更なし
    if (newPw === '' && checkPw === ''){
    }
    //PW変更有(問題なし)
    else if(newPw === checkPw){
		pw.value = newPw;
	}
	
	else if (/^[\x20-\x7E]+$/.test(newPw)) {
		alert('パスワードには英数字と記号以外入力できません');
 		event.preventDefault();
 		return;
	}
	
	else if (/^[\x20-\x7E]+$/.test(checkPw)) {
		alert('パスワードには英数字と記号以外入力できません');
 		event.preventDefault();
 		return;
	}
	
	//PW変更エラー
	else{
		alert('新たなパスワードが確認用パスワードと一致しません！');
 		event.preventDefault();
 		return;
	}
	
    
    //入力制限(身長)
    if(height === ''){
		alert('身長の値を入力してください');
 		event.preventDefault();
 		return;
	}
   	else if (/[^0-9]/.test(height)) {
		alert('整数値以外は入力出来ません');
 		event.preventDefault();
 		return;
	}
	
	//入力制限(名前)
	if(name === ''){
		alert('ニックネームを設定してください');
 		event.preventDefault();
 		return;
	}
	if(name.length() >20){
		alert('ニックネームは20文字までです');
 		event.preventDefault();
 		return;
	}
	
	//変更前の確認
	if (!window.confirm(`変更します。よろしいですか？`)) {
		event.preventDefault();
		return;
    }
};

