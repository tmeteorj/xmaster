import pymysql
import random


def initXM():
    global xing, ming
    xing = []
    ming = []
    for line in open("xing.data", "r"):
        for x in line.strip().split(","): xing.append(x)
    for line in open("ming.data", "r"):
        for x in line.strip().split(","): ming.append(x)


def initCT():
    global city
    lines = open("city.data", "r").readlines()
    city = dict()
    for ci in range(34):
        c = lines[ci * 2].strip()
        t = lines[ci * 2 + 1].strip().split(",")
        city[c] = t


def randomInt(a, b):
    return random.randint(a, b)


def randomDay(year, month):
    if month in [1, 3, 5, 7, 8, 10, 12]:
        return randomInt(1, 31)
    elif month in [4, 6, 9, 11]:
        return randomInt(1, 30)
    elif year % 400 == 0 or (year % 100 != 0 and year % 4 == 0):
        return randomInt(1, 29)
    return randomInt(1, 28)


def randomTime(bot, top):
    year = randomInt(bot, top)
    month = randomInt(1, 12)
    day = randomDay(year, month)
    hour = randomInt(0, 23)
    minute = randomInt(0, 59)
    second = randomInt(0, 59)
    return "%04d-%02d-%02d %02d:%02d:%02d" % (year, month, day, hour, minute, second)


def randomName():
    global xing, ming
    return random.choice(xing) + random.choice(ming)


def randomID(n):
    s = ""
    for i in range(n):
        s = s + "%d" % (randomInt(0, 9))
    return s


def randomProvince():
    global city
    return random.choice(list(city.keys()))


def randomCity(pro):
    global city
    return random.choice(city[pro])


def createRKXX(n):
    global conn
    cursor = conn.cursor()
    for i in range(n):
        sql = "insert into bd_rkxx(GMSFHM) values('%s')" % (randomID(18))
        print(sql)
        cursor.execute(sql)

    print("create -- finished")

    conn.commit()
    cursor.close()

    updateRKXXMC("XM", n)
    updateRKXXMC("CYM", n)

    print("name -- finished")

    bot = randomInt(1920, 1990)
    top = randomInt(0, 50) + bot
    updateRKXXRQ("CSRQ", n, bot, top)
    updateRKXXRQ("SCSJ", n, bot, top)
    bot = top
    top = bot + randomInt(0, 50)
    updateRKXXRQ("ZHXGSJ", n, bot, top)

    print("datetime -- finished")

    updateRKXXDM("HH", n, 1, 1000000)
    updateRKXXDM("YHZGXDM", n, 1, 10)
    updateRKXXDM("XBDM", n, 1, 2)
    updateRKXXDM("MZDM", n, 1, 56)
    updateRKXXDM("CSD_GJHDQDM", n, 1, 300)
    updateRKXXDM("CSD_SSXQDM", n, 1, 34)
    updateRKXXDM("JG_GJHDQDM", n, 1, 300)
    updateRKXXDM("JG_SSXQDM", n, 1, 340)
    updateRKXXDM("XLDM", n, 1, 10)
    updateRKXXDM("HYZKDM", n, 1, 10)
    updateRKXXDM("HJDZ_SSXQDM", n, 1, 3400)
    updateRKXXDM("CYZK_ZYLBDM", n, 1, 10)
    updateRKXXDM("SG", n, 150, 190)
    updateRKXXDM("XXDM", n, 1, 10)
    updateRKXXDM("RKXXJBDM", n, 1, 10)
    updateRKXXDM("RKGLZXLBDM", n, 1, 10)
    updateRKXXDM("SJDM", n, 1, 34)
    updateRKXXDM("DSDM", n, 1, 340)
    updateRKXXDM("ZT", n, 1, 3)
    updateRKXXDM("ZHWHLX", n, 1, 5)
    updateRKXXDM("SJGSDWDM", n, 1, 10000)
    updateRKXXDM("RKBM", n, 1, 1000000)

    print("number -- finished")


def updateRKXXDM(col, n, bot, top):
    global conn
    cursor = conn.cursor()
    for i in range(1, n + 1):
        sql = "update bd_rkxx set %s='%d' where XH=%d" % (col, randomInt(bot, top), i)
        cursor.execute(sql.encode("utf8"))
    conn.commit()
    cursor.close()


def updateRKXXMC(col, n):
    global conn
    cursor = conn.cursor()
    for i in range(1, n + 1):
        sql = "update bd_rkxx set %s='%d' where XH=%d" % (col, randomName(), i)
        cursor.execute(sql.encode("utf8"))
    conn.commit()
    cursor.close()


def updateRKXXRQ(col, n, bot, top):
    global conn
    cursor = conn.cursor()
    for i in range(1, n + 1):
        sql = "update bd_rkxx set %s=str_to_date('%s','%%Y-%%m-%%d %%H:%%i:%%s') where XH=%d" % (
        col, randomTime(bot, top), i)
        cursor.execute(sql.encode("utf8"))
    conn.commit()
    cursor.close()


if __name__ == "__main__":
    global conn
    initXM()
    initCT()
    conn = pymysql.connect(host='127.0.0.1', port=3306, user='root', passwd='123', db='xmaster', charset="utf8")
    createRKXX(10000)
    conn.close()
