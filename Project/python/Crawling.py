from logging import exception
from re import search
import cx_Oracle
from selenium import webdriver
from selenium.webdriver.support.select import Select
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
import time
from datetime import datetime

# # 오늘 날짜 구하기
# today = datetime.today().strftime("%Y%m%d")

# delete_data(today)

# # 셀레니움 연결설정
# options = webdriver.ChromeOptions()
# options.add_argument('headless')
# # options.add_argument("user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36")
# path = "C:\crawling\chromedriver.exe"
# driver = webdriver.Chrome(path, options=options)
# driver.implicitly_wait(10)
# driver.get("https://www.kebhana.com/cms/rate/index.do?contentUrl=/cms/rate/wpfxd651_07i.do")
# cx_Oracle.init_oracle_client(lib_dir=r"C:\crawling\instantclient_21_6")

# while(True):
#     # 검색할 날짜 입력
#     elem = driver.find_element(By.XPATH, r'//*[@id="tmpInqStrDt_d"]')
#     elem.clear()

#     elem.send_keys(today) 
#     time.sleep(2)

#     # 조회할 통화 선택
#     select = Select(driver.find_element(By.ID, "curCd"))

#     ccy_list = {"USD","JPY","EUR","CNY","HKD","THB","TWD","PHP","SGD","AUD","VND","GBP","CAD","MYR","RUB"
#     ,"ZAR","NOK","NZD","DKK","MXN","MNT","BHD","BDT"
#     ,"BRL","BND","SAR","LKR","SEK","CHF","AED","DZD"
#     ,"OMR","JOD","ILS","EGP","INR","IDR","CZK","CLP","KZT"
#     ,"QAR","KES","COP","KWD","TZS","TRY","PKR","PLN","HUF"}

#     num = 1
#     for ccy_code in ccy_list:
#         select.select_by_value(ccy_code)

#         time.sleep(2)

#         # 조회 버튼 클릭
#         btn = driver.find_element(By.XPATH, r'//*[@id="HANA_CONTENTS_DIV"]/div[2]/a')
#         btn.send_keys(Keys.ENTER)

#         time.sleep(2)

#         # BeautifulSoup으로 html 데이터 파싱
#         html = driver.page_source
#         soup = BeautifulSoup(html, 'lxml')

#         date = soup.select_one('#searchContentDiv > div.printdiv > p > span.fl > strong:nth-child(2)').text # 조회 날짜
#         currency = soup.select_one('#searchContentDiv > div.printdiv > p > span.fl > strong:nth-child(4)').text # 조회 통화

#         time.sleep(2)

#         rows = soup.select('#searchContentDiv > div.printdiv > table > tbody > tr')
#         oneNations = []
#         rows.reverse()
#         cols = rows[len(rows) - 1].select('td')

#         renewal_rate = str(today) + " " + cols[1].text  # 기준일시
#         buy_exc_rate = cols[2].text
#         buy_exc_rate = buy_exc_rate.replace(",", "")
#         sell_exc_rate = cols[3].text
#         sell_exc_rate = sell_exc_rate.replace(",", "")
#         send_exc_rate = cols[4].text
#         send_exc_rate = send_exc_rate.replace(",", "")
#         rec_exc_rate = cols[5].text
#         rec_exc_rate = rec_exc_rate.replace(",", "")
#         basic_rate = cols[8].text
#         basic_rate = basic_rate.replace(",", "")
#         exchange_rate = cols[10].text
#         exchange_rate = exchange_rate.replace(",", "")
#         usd_rate = cols[11].text
#         usd_rate = usd_rate.replace(",", "")
#         oneNation_info = []

#         oneNation_info.append(ccy_code)         #통화코드
#         oneNation_info.append(renewal_rate)     #기준일시
#         oneNation_info.append(buy_exc_rate)     #현찰 사실때
#         oneNation_info.append(sell_exc_rate)    #현찰 파실때
#         oneNation_info.append(send_exc_rate)    #송금 보낼때
#         oneNation_info.append(rec_exc_rate)     #송금 받을때
#         oneNation_info.append(basic_rate)       #매매 기준율
#         oneNation_info.append(exchange_rate)    #환가료율
#         oneNation_info.append(usd_rate)         #미화 환산율

#         oneNations.append(oneNation_info)
        
#         # 오라클 연결 및 데이터 삽입
#         connection = cx_Oracle.connect(user='admin', password='Wnsdud2260341008', dsn='semifinal_medium')
#         cursor = connection.cursor() # 커서 생성

#         try:
#             sql = "INSERT INTO EXC_RATE(CCY_CODE, BASIC_DATE, BUY_EXC_RATE, SELL_EXC_RATE, SEND_EXC_RATE, REC_EXC_RATE, BASIC_RATE, EXCHANGE_RATE, USD_RATE) VALUES (:1, TO_DATE(:2, 'YYYYMMdd HH24:MI:SS'), :3, :4, :5, :6, :7, :8, :9)"
#             cursor.bindarraysize = len(oneNation_info)
#             cursor.execute(sql, oneNation_info)
#             connection.commit()
#             print("good")
#         except:
#             print("time")
#             time.sleep(300)
#         finally:
#             cursor.close()
#             connection.close()


# 오늘 날짜 구하기
today = datetime.today().strftime("%Y%m%d")
today = int(today)

# 셀레니움 연결설정
options = webdriver.ChromeOptions()
options.add_argument('headless')
# options.add_argument("user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36")
path = "C:\crawling\chromedriver.exe"
driver = webdriver.Chrome(path, options=options)
driver.implicitly_wait(10)
driver.get("https://www.kebhana.com/cms/rate/index.do?contentUrl=/cms/rate/wpfxd651_07i.do")
cx_Oracle.init_oracle_client(lib_dir=r"C:\crawling\instantclient_21_6")
#####################
## 8월 24, 26일 따로 해야함
#####################
search_date = 20221020
# today = 20220809
while(search_date < today):
    # 검색할 날짜 입력
    elem = driver.find_element(By.XPATH, r'//*[@id="tmpInqStrDt_d"]')
    elem.clear()
    print(search_date)
    elem.send_keys(search_date) 
    time.sleep(3)

    # 조회할 통화 선택
    select = Select(driver.find_element(By.ID, "curCd"))

    ccy_list = {"USD","JPY","EUR","CNY","HKD","THB","TWD","PHP","SGD","AUD","VND","GBP","CAD","MYR","RUB"
    ,"ZAR","NOK","NZD","DKK","MXN","MNT","BHD","BDT"
    ,"BRL","BND","SAR","LKR","SEK","CHF","AED","DZD"
    ,"OMR","JOD","ILS","EGP","INR","IDR","CZK","CLP","KZT"
    ,"QAR","KES","COP","KWD","TZS","TRY","PKR","PLN","HUF"}
    
    num = 1
    for ccy_code in ccy_list:
        select.select_by_value(ccy_code)

        time.sleep(3)

        # 조회 버튼 클릭
        btn = driver.find_element(By.XPATH, r'//*[@id="HANA_CONTENTS_DIV"]/div[2]/a')
        btn.send_keys(Keys.ENTER)

        time.sleep(4)

        # BeautifulSoup으로 html 데이터 파싱
        html = driver.page_source
        soup = BeautifulSoup(html, 'lxml')

        date = soup.select_one('#searchContentDiv > div.printdiv > p > span.fl > strong:nth-child(2)').text # 조회 날짜
        currency = soup.select_one('#searchContentDiv > div.printdiv > p > span.fl > strong:nth-child(4)').text # 조회 통화

        time.sleep(3)

        rows = soup.select('#searchContentDiv > div.printdiv > table > tbody > tr')
        oneNations = []
        rows.reverse()
        cols = rows[len(rows) - 1].select('td')

        renewal_rate = str(search_date) + " " + cols[1].text  # 기준일시
        buy_exc_rate = cols[2].text
        buy_exc_rate = buy_exc_rate.replace(",", "")
        sell_exc_rate = cols[3].text
        sell_exc_rate = sell_exc_rate.replace(",", "")
        send_exc_rate = cols[4].text
        send_exc_rate = send_exc_rate.replace(",", "")
        rec_exc_rate = cols[5].text
        rec_exc_rate = rec_exc_rate.replace(",", "")
        basic_rate = cols[8].text
        basic_rate = basic_rate.replace(",", "")
        exchange_rate = cols[10].text
        exchange_rate = exchange_rate.replace(",", "")
        usd_rate = cols[11].text
        usd_rate = usd_rate.replace(",", "")
        oneNation_info = []

        oneNation_info.append(ccy_code)         #통화코드
        oneNation_info.append(renewal_rate)     #기준일시
        oneNation_info.append(buy_exc_rate)     #현찰 사실때
        oneNation_info.append(sell_exc_rate)    #현찰 파실때
        oneNation_info.append(send_exc_rate)    #송금 보낼때
        oneNation_info.append(rec_exc_rate)     #송금 받을때
        oneNation_info.append(basic_rate)       #매매 기준율
        oneNation_info.append(exchange_rate)    #환가료율
        oneNation_info.append(usd_rate)         #미화 환산율

        oneNations.append(oneNation_info)
        
        # 오라클 연결 및 데이터 삽입
        connection = cx_Oracle.connect(user='admin', password='Wnsdud2260341008', dsn='semifinal_medium')
        cursor = connection.cursor() # 커서 생성

        try:
            sql = "INSERT INTO EXC_RATE(CCY_CODE, BASIC_DATE, BUY_EXC_RATE, SELL_EXC_RATE, SEND_EXC_RATE, REC_EXC_RATE, BASIC_RATE, EXCHANGE_RATE, USD_RATE) VALUES (:1, TO_DATE(:2, 'YYYYMMdd HH24:MI:SS'), :3, :4, :5, :6, :7, :8, :9)"
            cursor.bindarraysize = len(oneNation_info)
            cursor.execute(sql, oneNation_info)
            connection.commit()
        except:
            print(search_date)
            search_date += 1
        finally:
            cursor.close()
            connection.close()
    search_date += 1
