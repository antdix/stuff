import json
import sys
import datetime
import time
import os
import urllib
import urllib.request
import urllib.error
import requests
import pandas as pd

import MySQLdb
import re
from typing import Iterable, Dict, Union, List

my_app_key = ""
bet_url="https://api.betfair.com/exchange/betting/json-rpc/v1"
acceptStr = "application/json"

def myprint(x):
    print(x)
    sys.stdout.flush()

def getSSOID():
    my_username = ""
    my_password = ""

    payload = 'username=' + my_username + '&password=' + my_password
    headers = {'X-Application': my_app_key, 'Content-Type': 'application/x-www-form-urlencoded'}
    resp = requests.post('https://identitysso-cert.betfair.com/api/certlogin',data=payload,cert=('client-2048.crt','client-2048.key'),headers=headers)
    json_resp=resp.json()
    SSOID = json_resp['sessionToken']
    return SSOID


def keepAlive(SSOID):
    headers = {'Accept': acceptStr, 'X-Application': my_app_key, 'X-Authentication': SSOID, 'content-type': 'application/json'}
    resp = requests.post('https://identitysso-cert.betfair.com/api/keepAlive',headers=headers)
    json_resp=resp.json()
    myprint (json_resp['status'])


def getBetSize(SSOID):
    account_url="https://api.betfair.com/exchange/account/json-rpc/v1"
    headers = {'Accept': acceptStr, 'X-Application': my_app_key, 'X-Authentication': SSOID, 'content-type': 'application/json'}
    user_req='{"jsonrpc": "2.0", "method": "AccountAPING/v1.0/getAccountFunds"}'

    headers = {'X-Application': my_app_key, 'X-Authentication': SSOID, 'content-type': 'application/json'}
    user_req = '{"jsonrpc": "2.0", "method": "AccountAPING/v1.0/getAccountFunds", "params": {"wallet":"UK"}, "id": 1}'
    req = requests.post(account_url, data=user_req.encode('utf-8'), headers=headers)
    accountInfo = req.json()
    result = accountInfo["result"]
    available = float(result['availableToBetBalance'])
    exposure = float(result['exposure'])
    total = available - exposure
    betsize = total * 0.01
    if (betsize < 2.0):
        betsize = 2.0
    if (betsize > 20.0):
        betsize = 20.0
    #myprint ("Betsize is {}".format(betsize))
    return (betsize)

def CheckLayBet(SSOID,market,selection):

    headers = {'X-Application': my_app_key, 'X-Authentication': SSOID, 'content-type': 'application/json'}


    user_req='{"jsonrpc": "2.0", "method": "SportsAPING/v1.0/listCurrentOrders"}'

    #myprint (user_req)
    req = urllib.request.Request(bet_url, data=user_req.encode('utf-8'), headers=headers)
    response= urllib.request.urlopen(req)
    jsonResponse = response.read()
    pkg = jsonResponse.decode('utf-8')
    result = json.loads(pkg)
    #myprint (result)

    orders = result['result']['currentOrders']
    for x in range(len(orders)):
        if (orders[x]['marketId'] == market):
            side = orders[x]['side']
            horse = orders[x]['selectionId']
            if (side == "LAY" and str(horse) == selection or selection == "AnyHorse"):
                if (str(orders[x]['status']) == "EXECUTABLE"):
                    return ("Unmatched",horse)
                else:
                    betPlaced = str("%.2f" % orders[x]['averagePriceMatched'])
                    return (str(betPlaced),horse)


    return ("No","None")

def getLiability(SSOID,market,selection):

    headers = {'X-Application': my_app_key, 'X-Authentication': SSOID, 'content-type': 'application/json'}
    user_req='{"jsonrpc": "2.0", "method": "SportsAPING/v1.0/listCurrentOrders"}'

    #myprint (user_req)
    req = urllib.request.Request(bet_url, data=user_req.encode('utf-8'), headers=headers)
    response= urllib.request.urlopen(req)
    jsonResponse = response.read()
    pkg = jsonResponse.decode('utf-8')
    result = json.loads(pkg)
    #myprint (result)

    total = 0.0
    original = 0.0
    originalLay = 0.0
    orders = result['result']['currentOrders']
    for x in range(len(orders)):
        if (orders[x]['marketId'] == market):
            side = str(orders[x]['side'])
            horse = orders[x]['selectionId']
            if (side == "BACK" and str(horse) == selection):
                if (str(orders[x]['status']) != "EXECUTABLE"):
                    size = orders[x]['priceSize']['size'] 
                    price = orders[x]['averagePriceMatched']
                    liability = size * (price - 1.0)
                    total = total - liability
                    #myprint ("Side {} Size {} price {} liability {} total {}".format(side,size,price,liability,total))
            if (side == "LAY" and str(horse) == selection):
                if (str(orders[x]['status']) != "EXECUTABLE"):
                    size = orders[x]['priceSize']['size'] 
                    price = orders[x]['averagePriceMatched']
                    liability = size * (price - 1.0)
                    total = total + liability
                    original = original + liability
                    originalLay = originalLay + size 
                    #myprint ("Side {} Size {} price {} liability {} total {}".format(side,size,price,liability,total))


    return (total, original, originalLay)

def CheckBackBet(SSOID,market,selection):

    headers = {'X-Application': my_app_key, 'X-Authentication': SSOID, 'content-type': 'application/json'}


    user_req='{"jsonrpc": "2.0", "method": "SportsAPING/v1.0/listCurrentOrders"}'

    #myprint (user_req)
    req = urllib.request.Request(bet_url, data=user_req.encode('utf-8'), headers=headers)
    response= urllib.request.urlopen(req)
    jsonResponse = response.read()
    pkg = jsonResponse.decode('utf-8')
    result = json.loads(pkg)
    #myprint (result)

    total = 0.0
    orders = result['result']['currentOrders']
    for x in range(len(orders)):
        if (orders[x]['marketId'] == market):
            side = str(orders[x]['side'])
            horse = orders[x]['selectionId']
            if (side == "BACK" and str(horse) == selection):
                if (str(orders[x]['status']) != "EXECUTABLE"):
                    total = total + orders[x]['priceSize']['size']


    return (total)


def PlaceBackBet(SSOID,market,horse,price,betsize):

    headers = {'X-Application': my_app_key, 'X-Authentication': SSOID, 'content-type': 'application/json'}

    #amount = CheckBackBet(SSOID,market,horse)
    #betAmount = float(betsize) - amount
    #betStrAmount = str(betAmount)
    betAmount = float(betsize)
    iAmount = int (betAmount * 100.0)
    betAmount = iAmount * 0.01
    betStrAmount = str(betAmount)

    user_req='{"jsonrpc": "2.0", "method": "SportsAPING/v1.0/placeOrders", \
            "params": {"marketId":"'+market+'",\
            "instructions":[{"selectionId":"'+horse+'","handicap":"0","side":"BACK","orderType":"LIMIT","limitOrder":{"size":"'+betStrAmount+'","price":"'+price+'"}}]}, "id": 1}'

    #myprint (user_req)

    if (betAmount >= 2.0):
        req = urllib.request.Request(bet_url, data=user_req.encode('utf-8'), headers=headers)
        response= urllib.request.urlopen(req)
        jsonResponse = response.read()
        pkg = jsonResponse.decode('utf-8')
        result = json.loads(pkg)
        myprint ("Placing bet size {} on {}".format(betAmount, horse))
        myprint (result)

def getMarketCatalogue(SSOID):
    eventTypeID = '["7"]' #ID for Horse Racing
    countryCode= '["GB","IE"]' #Country Codes. Betfair use Alpha-2 Codes under ISO 3166-1
    marketTypeCode='["WIN"]' #Market Type
    MarketStartTime = (datetime.datetime.now() - datetime.timedelta(minutes=20))
    MarketStartTime = MarketStartTime.strftime('%Y-%m-%dT%H:%M:%SZ')
    MarketEndTime = (datetime.datetime.now() + datetime.timedelta(hours=1))
    MarketEndTime = MarketEndTime.strftime('%Y-%m-%dT%H:%M:%SZ')
    maxResults = str(1000)
    sortType = 'FIRST_TO_START' #Sorts the Output
    Metadata = 'RUNNER_METADATA' #Provides metadata
    priceProjection = '["EX_ALL_OFFERS"]'#Best odds


    headers = {'X-Application': my_app_key, 'X-Authentication': SSOID, 'content-type': 'application/json'}

    user_req='{"jsonrpc": "2.0", "method": "SportsAPING/v1.0/listMarketCatalogue",\
           "params": {"filter":{"eventTypeIds":'+eventTypeID+',"marketTypeCodes":'+marketTypeCode+',\
           "marketCountries":'+countryCode+',\
           "marketStartTime":{"from":"'+MarketStartTime+'", "to":"'+MarketEndTime+'"}},\
           "sort":"'+sortType+'", "maxResults":"'+maxResults+'", "marketProjection":["'+Metadata+'","MARKET_START_TIME","EVENT"]}, "id": 1}'

    req = urllib.request.Request(bet_url, data=user_req.encode('utf-8'), headers=headers)
    response= urllib.request.urlopen(req)
    jsonResponse = response.read()
    pkg = jsonResponse.decode('utf-8')
    result = json.loads(pkg)
    marketCatalogue = result['result']

    return (marketCatalogue)

def getMarketStatus(SSOID, market):
    priceProjection = '["EX_ALL_OFFERS"]'#Best odds
    marketId = str(market['marketId'])
    backList = []
    backValueList = []
    horseList = []
    horseBackList = []
    sortedList = []

    headers = {'X-Application': my_app_key, 'X-Authentication': SSOID, 'content-type': 'application/json'}

    #myprint (marketId)
    for w in range(len(market['runners'])):
        selectionID = market['runners'][w]['selectionId']
        price_req = '{"jsonrpc": "2.0", "method": "SportsAPING/v1.0/listRunnerBook", "params": {"locale":"en", \
                        "marketId":"'+str(market['marketId'])+'",\
                        "selectionId":"'+str(selectionID)+'",\
                        "priceProjection":{"priceData":'+priceProjection+'},"orderProjection":"ALL"},"id":1}'

        #myprint (price_req)
        req = urllib.request.Request(bet_url, data=price_req.encode('utf-8'), headers=headers)
        price_response= urllib.request.urlopen(req)
        price_jsonResponse = price_response.read()
        price_pkg = price_jsonResponse.decode('utf-8')
        price_result = json.loads(price_pkg)
        #myprint (price_result)
        try:
            back = float(price_result['result'][0]['runners'][0]['ex']['availableToBack'][0]['price'])
        except:
            back = 1000.0

        dictItem = {"selectionID":selectionID, "back" : back}
        horseBackList.append(dictItem)

    sortedList = sorted(horseBackList, key = lambda i: i['back'])
    #myprint (sortedList)
    for w in range(len(market['runners'])):
        selectionID = market['runners'][w]['selectionId']
        betPlaced,horseid = CheckLayBet(SSOID,marketId,str(selectionID))
        #myprint ("Horse {} betPlaced {}".format (betPlaced,horseid))
        if (selectionID == horseid and betPlaced != "Unmatched"):
            horseList.append(selectionID)
            for t in range(len(sortedList)):
                if (sortedList[t]['selectionID'] == selectionID):
                    backList.append(t)
                    backValueList.append(sortedList[t]['back'])

    return (backList,horseList,backValueList)

# main starts here

pid = os.getpid()
print (pid)

f = open ("newStopPID.txt","w")
f.write(str(pid))
f.close()

SSOID = getSSOID()
myprint (SSOID)
doit = 1
while (doit == 1):
    curhour = int(datetime.datetime.now().strftime('%H'))
    curmin = int(datetime.datetime.now().strftime('%M'))
    if (curhour > 22 and curmin > 15):
        doit = 0
    if (curhour < 8 and curmin > 15):
        doit = 0
    timenow = datetime.datetime.now().strftime('%Y-%m-%dT%H:%M:%SZ')
    myprint (timenow)

    marketList = getMarketCatalogue(SSOID)
    numBets = 0
    for hrow in range(len(marketList)):
        backList,horseList,backValueList = getMarketStatus(SSOID, marketList[hrow])
        myprint (backList)
        numBets = numBets + len(backList)
        for trow in range(len(horseList)):
            liability,original,originalLay = getLiability(SSOID, str(marketList[hrow]['marketId']), str(horseList[trow]))
            origLayEquiv = (liability / originalLay) + 1
            # following 4 lines for testing
            #origLayEquiv = 25.0
            #originalLay = 5.0
            #liability = 120.0
            #original = 120.0
            cashout = (origLayEquiv / backValueList[trow]) * originalLay
            if (backValueList[trow] < 10.0):
                reqCOPercent = backValueList[trow] * 0.1
                curCOPercent = liability / original
                myprint ("reqCOPercent {} curCOPercent {} original {}".format(reqCOPercent, curCOPercent, original))
                betAmount = (curCOPercent - reqCOPercent) * cashout
                ibetAmount = int (betAmount * 100.0)
                betAmount = float(ibetAmount) * 0.01
                myprint ("Horse {} back {} backValue {} Liability {} originalLayEquiv {} cashout {} betAmount {}".format(horseList[trow], backList[trow], backValueList[trow], liability,origLayEquiv,cashout,betAmount))

                if (betAmount > 2.0):
                    myprint ("Betting now")
                    PlaceBackBet(SSOID,str(marketList[hrow]['marketId']),str(horseList[trow]),"1.1",str(betAmount))


    if (numBets == 0):
        keepAlive(SSOID)
        time.sleep(60)


