function keyUpFirstAmount(obj) {
    // 국가 통화 단위
    let from_ccyKrName = $('#selectFirst > option:selected').attr('value')
    let to_ccyKrName = $('#selectSecond > option:selected').attr('value')
    // 매매 기준율
    let from_basicRate = $('#selectFirst > option:selected').attr('value2')
    let to_basicRate = $('#selectSecond > option:selected').attr('value2')
    // 변환시킬 금액
    let targetAmount = obj.value
    // 콤마제거
    targetAmount = uncomma(targetAmount)
    // 환전결과금액
    let resultAmount = exchange(targetAmount, from_basicRate, to_basicRate, from_ccyKrName, to_ccyKrName)
    let decimal = resultAmount.substring(resultAmount.length - 2, resultAmount.length)
    //콤마추가
    formatResultAmount = comma(resultAmount)

    let formatNum = comma(targetAmount)
    obj.value = formatNum

    document.getElementById('inputSecond').value = formatResultAmount

    // 환전결과 input value 삽입
    $('#excFirst').empty()
    $('#excFirst').append(numberToKorean(uncomma(formatNum)) + ' ' + $('#selectFirst > option:selected').attr('value'))
    $('#excSecond').empty()
    $('#excSecond').append(numberToKorean(resultAmount) + '.' + decimal + ' ' + $('#selectSecond > option:selected').attr('value'))
}

function keyUpSecondAmount(obj) {
    // 국가 통화 단위
    let from_ccyKrName = $('#selectSecond > option:selected').attr('value')
    let to_ccyKrName = $('#selectFirst > option:selected').attr('value')
    // 매매 기준율
    let from_basicRate = $('#selectSecond > option:selected').attr('value2')
    let to_basicRate = $('#selectFirst > option:selected').attr('value2')
    // 변환시킬 금액
    let targetAmount = obj.value
    // 콤마제거
    targetAmount = uncomma(targetAmount)
    // 환전결과금액
    let resultAmount = exchange(targetAmount, from_basicRate, to_basicRate, from_ccyKrName, to_ccyKrName)
    let decimal = resultAmount.substring(resultAmount.length - 2, resultAmount.length)
    //콤마추가
    formatResultAmount = comma(resultAmount)

    let formatNum = comma(targetAmount)
    obj.value = formatNum
    document.getElementById('inputFirst').value = formatResultAmount

    // 환전결과 input value 삽입
    $('#excSecond').empty()
    $('#excSecond').append(numberToKorean(targetAmount) + ' ' + $('#selectSecond > option:selected').attr('value'))
    $('#excFirst').empty()
    $('#excFirst').append(numberToKorean(resultAmount) + '.' + decimal + ' ' + $('#selectFirst > option:selected').attr('value'))
}

// 금액 변환
function exchange(targetAmount, from_basicRate, to_basicRate, from_ccyKrName, to_ccyKrName) {
    // 원화 변환식
    if (from_ccyKrName == "원" && to_ccyKrName != "엔")
        return (targetAmount / to_basicRate).toFixed(2)
    else if (to_ccyKrName == "원" && from_ccyKrName != "엔")
        return (targetAmount * from_basicRate).toFixed(2)
    // 엔화 변환식
    else if (from_ccyKrName == "엔")
        return (targetAmount * from_basicRate / to_basicRate / 100).toFixed(2)
    else if (to_ccyKrName == "엔")
        return (targetAmount * from_basicRate / to_basicRate * 100).toFixed(2)
    else
        return (targetAmount * from_basicRate / to_basicRate).toFixed(2)
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

function numberFormat(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function numberToKorean(number) {
    var inputNumber = number < 0 ? false : number;
    var unitWords = ['', '만 ', '억 ', '조 ', '경 '];
    var splitUnit = 10000;
    var splitCount = unitWords.length;
    var resultArray = [];
    var resultString = '';

    for (var i = 0; i < splitCount; i++) {
        var unitResult = (inputNumber % Math.pow(splitUnit, i + 1)) / Math.pow(splitUnit, i);
        unitResult = Math.floor(unitResult);
        if (unitResult > 0) {
            resultArray[i] = unitResult;
        }
    }

    for (var i = 0; i < resultArray.length; i++) {
        if (!resultArray[i]) continue;
        resultString = String(numberFormat(resultArray[i])) + unitWords[i] + resultString;
    }
    return resultString;
}

function changeFirstCountry() {
    keyUpFirstAmount(document.getElementById('inputFirst'))
}

function changeSecondCountry() {
    keyUpSecondAmount(document.getElementById('inputSecond'))
}

$(function () {
    $('#inputFirst').bind('focus', function (event) {  // 반복.
        $('#inputFirstContainer').css("border-color", "#008485");
    });
    $('#inputFirst').blur(function (event) {
        $('#inputFirstContainer').css("border-color", "#c7c7c7");
    });

    $('#inputSecond').bind('focus', function (event) {  // 반복.
        $('#inputSecondContainer').css("border-color", "#008485");
    });
    $('#inputSecond').blur(function (event) {
        $('#inputSecondContainer').css("border-color", "#c7c7c7");
    });
});

