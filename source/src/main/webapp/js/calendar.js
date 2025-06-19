document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.calendar-cell').forEach(td => {
    
    const newTd = td.cloneNode(true);
    td.parentNode.replaceChild(newTd, td);
  });

  // ここから新規登録
  document.querySelectorAll('.calendar-cell').forEach(td => {
    td.addEventListener('click', () => {
      const dateStr = td.getAttribute('data-date');
      if (!dateStr) return;

      const clickedDate = new Date(dateStr);
      const today = new Date();
      today.setHours(0,0,0,0);
      clickedDate.setHours(0,0,0,0);

      if (clickedDate > today) {
        alert('これからの日付は選択できません。');
        return;
      }

      if (typeof dataDates === 'undefined' || !Array.isArray(dataDates)) {
        window.location.href = `EvaluationServlet?date=${dateStr}`;
        return;
      }

      if (!dataDates.includes(dateStr)) {
        alert('その日はデータが登録されていません。');
        return;
      }

      window.location.href = `EvaluationServlet?date=${dateStr}`;
    });
  });
});
