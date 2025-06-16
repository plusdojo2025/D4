'use strict';

document.getElementById('friendInfo').onsubmit = function(event) {
    const submitter = event.submitter;

    if (!submitter) return;

    // 「戻る」以外のボタンなら確認
    if (submitter.value !== '戻る') {
        if (!window.confirm(`${submitter.value}します。よろしいですか？`)) {
            event.preventDefault();
        }
    }
};