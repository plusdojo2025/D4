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
  document.getElementById('IconId').value = id;
  document.getElementById('Icon').src = path;
  closePopup('iconPopup');
}

//テーマの更新
function selectTheme(name) {
  document.getElementById('ThemeName').value = name;
  document.getElementById('Theme').textContent = name;
  closePopup('themePopup');
}

function checkPassword() {
  const newPw = document.getElementById('textbox2');
  const checkPw = document.getElementById('textbox3');
  const pw = document.getElementById('pw').value;

  const pwVal = newPw.value.trim();
  const checkPwVal = checkPw.value.trim();

  //現在のパスワードを使う
  if (pwVal === '' && checkPwVal === '') {
    newPw.value = pw;
    checkPw.value = pw;
    return true;
  }

  // 一致確認
  if (pwVal !== checkPwVal) {
    alert('新しいパスワードと確認用パスワードが一致しません。');
    return false;
  }

  return true;
}
