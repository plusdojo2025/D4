function openPopup(id) {
  document.getElementById(id).style.display = 'block';
}
function closePopup(id) {
  document.getElementById(id).style.display = 'none';
}

function selectIcon(id, path) {
  document.getElementById('selectedIconId').value = id;
  document.getElementById('selectedIcon').src = path;
  closePopup('iconPopup');
}

function selectTheme(id, name) {
  document.getElementById('selectedThemeId').value = id;
  document.getElementById('selectedTheme').src = name;
  closePopup('themePopup');
}