document.addEventListener("DOMContentLoaded", function () {
    const tabs = document.querySelectorAll("#tab-menu .tab");
    const contents = document.querySelectorAll(".tab-content");

    // 各グラフが描画済みかどうかを管理するフラグ
    let foodChartInitialized = false;
    let sleepChartInitialized = false;
    let walkChartInitialized = false;

    tabs.forEach(tab => {
    tab.addEventListener("click", function () {
        const tabName = tab.dataset.tab;

        if (tab.dataset.disabled === "1") {
            alert("このデータは非公開です");
            return;
        }

        tabs.forEach(t => t.classList.remove("active"));
        contents.forEach(c => c.classList.remove("active"));
        tab.classList.add("active");

        const targetId = "tab-" + tabName;
        const targetContent = document.getElementById(targetId);
        if (targetContent) {
            targetContent.classList.add("active");
        }

        // 各タブに対応するグラフを初回のみ描画
        if (tabName === "food" && !foodChartInitialized) {
            renderFoodChart();
            foodChartInitialized = true;
        } else if (tabName === "sleep" && !sleepChartInitialized) {
            renderSleepChart();
            sleepChartInitialized = true;
        } else if (tabName === "walk" && !walkChartInitialized) {
            renderWalkChart();
            walkChartInitialized = true;
        }
    });
});

    function formatMinutesToHourMin(min) {
        const h = Math.floor(min / 60);
        const m = min % 60;
        return `${h}h${m}m`;
    }

    function renderBarChart(id, label, myValue, friendValue, unit) {
        const ctx = document.getElementById(id)?.getContext("2d");
        if (!ctx) return;

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: [label],
                datasets: [
                    { label: '自分', data: [myValue], backgroundColor: 'rgba(54, 162, 235, 0.6)' },
                    { label: friendName, data: [friendValue], backgroundColor: 'rgba(255, 99, 132, 0.6)' }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 15,
                        title: {
                            display: true,
                            text: `${label}（${unit}）`
                        }
                    }
                },
                plugins: {
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                return `${context.dataset.label}: ${context.raw}${unit}`;
                            }
                        }
                    }
                }
            }
        });
    }

    // スコアグラフ（常に表示）
	renderBarChart("chart-average-score", "平均スコア", myAverageData[0], friendAverageData[0], "点");

    // 個別グラフ描画用関数（遅延描画）
    function renderFoodChart() {
        const ctx = document.getElementById("chart-food")?.getContext("2d");
        if (!ctx) return;

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: foodLabels,
                datasets: [
                    { label: '自分', data: myFoodData, backgroundColor: 'rgba(54, 162, 235, 0.6)' },
                    { label: friendName, data: friendFoodData, backgroundColor: 'rgba(255, 99, 132, 0.6)' }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: { display: true, text: '野菜摂取（単位）' }
                    }
                }
            }
        });
    }

    function renderSleepChart() {
        const ctx = document.getElementById("chart-sleep")?.getContext("2d");
        if (!ctx) return;

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: sleepLabels,
                datasets: [
                    { label: '自分', data: mySleepData, backgroundColor: 'rgba(54, 162, 235, 0.6)' },
                    { label: friendName, data: friendSleepData, backgroundColor: 'rgba(255, 99, 132, 0.6)' }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: { display: true, text: '睡眠時間（分）' }
                    }
                },
                plugins: {
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                const min = context.parsed.y;
                                return `${context.dataset.label}: ${formatMinutesToHourMin(min)}`;
                            }
                        }
                    }
                }
            }
        });
    }

    function renderWalkChart() {
        const ctx = document.getElementById("chart-walk")?.getContext("2d");
        if (!ctx) return;

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: sleepLabels,
                datasets: [
                    { label: '自分', data: myWalkData, backgroundColor: 'rgba(54, 162, 235, 0.6)' },
                    { label: friendName, data: friendWalkData, backgroundColor: 'rgba(255, 99, 132, 0.6)' }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: { display: true, text: '歩数' }
                    }
                }
            }
        });
    }
});
