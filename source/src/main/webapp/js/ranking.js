document.addEventListener("DOMContentLoaded", function () {
    // タブ切替
    const tabs = document.querySelectorAll(".tab");
    const contents = document.querySelectorAll(".tab-content");

    tabs.forEach(tab => {
        tab.addEventListener("click", function () {
            tabs.forEach(t => t.classList.remove("active"));
            contents.forEach(c => c.classList.remove("active"));
            tab.classList.add("active");
            const targetId = "tab-" + tab.dataset.tab;
            document.getElementById(targetId).classList.add("active");
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

    // 平均タブ：食事・睡眠・運動の3分割グラフ
    renderBarChart("chart-average-food", "食事", myAverageData[0], friendAverageData[0], "単位");
    renderBarChart("chart-average-sleep", "睡眠", myAverageData[1], friendAverageData[1], "分");
    renderBarChart("chart-average-walk", "運動", myAverageData[2], friendAverageData[2], "歩");

    // 食事の推移
    new Chart(document.getElementById("chart-food").getContext("2d"), {
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

    // 睡眠の推移
    new Chart(document.getElementById("chart-sleep").getContext("2d"), {
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

    // 運動の推移
    new Chart(document.getElementById("chart-walk").getContext("2d"), {
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
});
