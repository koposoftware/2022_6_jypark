AOS.init();
$(function () {
    let today = new Date();
    let year = today.getFullYear();
    let month = today.getMonth() + 1;
    let day = today.getDate();
    $('#demo').daterangepicker({
        "locale": {
            "format": "YYYY-MM-DD",
            "separator": " ~ ",
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": ["월", "화", "수", "목", "금", "토", "일"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            "firstDay": 1
        },
        "startDate": year + '-' + (month - 1) + '-' + day,
        "endDate": year + '-' + month + '-' + day,
        "drops": "down"
    }, function (start, end, label) {
        $("#demo").attr('value', start);
        console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
    });
});

function getTransactionList() {
    var accountNo = $("#selectAccountForm > option:selected").attr("value");
    var test = accountNo.replaceAll("-", "");
    const table_show = document.getElementById('showTable');
    table_show.classList.remove('d-none');
    $.ajax({
        url: '/transactionHistory/' + test,
        type: 'GET',
        data: {
            date: $("#demo").val(),
        },
        success: function (data) {
            $('#tbody').empty();
            $(data).each(function () {
                let str = '';
                str += '<tr class="text-center border-bottom fs-6" style="border-color: black; font-family: hana">';
                str += '<td class="p-4">';
                str += this.transferDate;
                str += '</td>';
                str += '<td class="p-4">';
                str += this.transferMemo;
                str += '</td>';
                if (this.transferType == 'W') {
                    str += '<td class="text-hanared p-4">';
                    str += '- ' + this.transferAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                    str += '</td>';
                } else {
                    str += '<td class="p-4" style="color: blue">';
                    str += '+ ' + this.transferAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                    str += '</td>';
                }
                str += '<td class="text-hanagreen p-4">';
                str += this.balance.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                str += '</td>';
                str += '</tr>';
                $('#tbody').append(str);
            })
        },
        error: function () {
            alert('실패');
        }
    })
};