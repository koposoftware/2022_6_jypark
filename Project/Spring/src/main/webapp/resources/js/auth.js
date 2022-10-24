$(document).ready(function () {
    getSessionTime()
});

function getSessionTime() {
    $.ajax({
        url: '/loginSessionTime',
        type: 'POST',
        success: function (data) {
            let remainSecond = data;
            interval = setInterval(function () {
                remainMinute_ = parseInt(remainSecond / 60);
                remainSecond_ = remainSecond % 60;

                if (remainSecond > 0) {
                    $("#mySessionTime").empty();
                    $("#mySessionTime").append("로그아웃 남은 시간 " + remainMinute_.toString().padStart(2, '0') + ":" + remainSecond_.toString().padStart(2, '0'));
                    remainSecond--;
                }
            }, 1000)
        }
    })
}