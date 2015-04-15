_               = require 'underscore'
{EventEmitter}  = require 'events'

CHANGE_EVENT = 'change'

class Store extends EventEmitter
    constructor: ->
        @_attr = {}
    emitChange: ->
        @emit CHANGE_EVENT
    addChangeListener: (cb)->
        this.on CHANGE_EVENT, cb
    removeChangeListener: (cb)->
        this.removeListener CHANGE_EVENT, cb
    getAttr: (id)->
        @_attr[id]
    getAll: ->
        _.chain(@_attr)
        .toArray()
        .pluck @locale
        .value()
    addAttr: (raw)->
        raw.forEach (r)=>
            @_attr[r.id] = r

module.exports = (dispatcher)->
    store = new Store()
    store.addAttr types
    store

types = [
    {
        "id": 100,
        "category": "Cuisine Region",
        "zh_TW": "西式料理",
        "en_US": "Western",
        "th_TH": "ตะวันตก",
        "zh_HK": "西式料理",
        "alias": ""
    },
    {
        "id": 101,
        "category": "Cuisine Region",
        "zh_TW": "亞洲料理",
        "en_US": "Asian",
        "th_TH": "เอเชีย",
        "zh_HK": "亞洲料理",
        "alias": ""
    },
    {
        "id": 102,
        "category": "Cuisine Region",
        "zh_TW": "中東料理",
        "en_US": "Middle East Cuisine",
        "th_TH": "ตะวันออก",
        "zh_HK": "中東料理",
        "alias": ""
    },
    {
        "id": 103,
        "category": "Cuisine Region",
        "zh_TW": "東南亞料理",
        "en_US": "Southeast Asian Cuisine",
        "th_TH": "ตะวันออกเฉียงใต้",
        "zh_HK": "東南亞料理",
        "alias": ""
    },
    {
        "id": 104,
        "category": "Cuisine Region",
        "zh_TW": "多國料理",
        "en_US": "International",
        "th_TH": "นานาชาติ",
        "zh_HK": "多國料理",
        "alias": ""
    },
    {
        "id": 201,
        "category": "Cuisine Nationality",
        "zh_TW": "美式料理",
        "en_US": "American Cuisine",
        "th_TH": "อเมริกา",
        "zh_HK": "美國菜",
        "alias": ""
    },
    {
        "id": 202,
        "category": "Cuisine Nationality",
        "zh_TW": "愛爾蘭料理",
        "en_US": "Irish",
        "th_TH": "ไอริช",
        "zh_HK": "愛爾蘭菜",
        "alias": ""
    },
    {
        "id": 203,
        "category": "Cuisine Nationality",
        "zh_TW": "法國料理",
        "en_US": "French Cuisine",
        "th_TH": "ฝรั่งเศส",
        "zh_HK": "法國菜",
        "alias": ""
    },
    {
        "id": 204,
        "category": "Cuisine Nationality",
        "zh_TW": "西班牙料理",
        "en_US": "Spanish Cuisine",
        "th_TH": "สเปน",
        "zh_HK": "西班牙菜",
        "alias": ""
    },
    {
        "id": 205,
        "category": "Cuisine Nationality",
        "zh_TW": "義大利料理",
        "en_US": "Italian Cuisine",
        "th_TH": "อิตาลี",
        "zh_HK": "義大利菜",
        "alias": ""
    },
    {
        "id": 206,
        "category": "Cuisine Nationality",
        "zh_TW": "德國料理",
        "en_US": "German Cuisine",
        "th_TH": "เยอรมัน",
        "zh_HK": "德國菜",
        "alias": ""
    },
    {
        "id": 207,
        "category": "Cuisine Nationality",
        "zh_TW": "葡萄牙料理",
        "en_US": "Portugal Cuisine",
        "th_TH": "โปรตุเกส",
        "zh_HK": "葡萄牙菜",
        "alias": ""
    },
    {
        "id": 208,
        "category": "Cuisine Nationality",
        "zh_TW": "日式料理",
        "en_US": "Japanese Cuisine",
        "th_TH": "ญี่ปุ่น",
        "zh_HK": "日本菜",
        "alias": ""
    },
    {
        "id": 209,
        "category": "Cuisine Nationality",
        "zh_TW": "中式料理",
        "en_US": "Chinese Cuisine",
        "th_TH": "จีน",
        "zh_HK": "中國菜",
        "alias": ""
    },
    {
        "id": 210,
        "category": "Cuisine Nationality",
        "zh_TW": "韓式料理",
        "en_US": "Korean Cuisine",
        "th_TH": "เกาหลี",
        "zh_HK": "韓國菜",
        "alias": ""
    },
    {
        "id": 211,
        "category": "Cuisine Nationality",
        "zh_TW": "粵式料理",
        "en_US": "Cantonese Cuisine",
        "th_TH": "กวางตุ้ง",
        "zh_HK": "廣東菜",
        "alias": ""
    },
    {
        "id": 212,
        "category": "Cuisine Nationality",
        "zh_TW": "印度料理",
        "en_US": "Indian Cuisine",
        "th_TH": "อินเดีย",
        "zh_HK": "印度菜",
        "alias": ""
    },
    {
        "id": 213,
        "category": "Cuisine Nationality",
        "zh_TW": "星馬料理",
        "en_US": "Malay/Malaysia/Singapore Cuisine",
        "th_TH": "มาเลเซีย",
        "zh_HK": "星馬菜",
        "alias": ""
    },
    {
        "id": 214,
        "category": "Cuisine Nationality",
        "zh_TW": "越南料理",
        "en_US": "Vietnam Cuisine",
        "th_TH": "เวียดนาม",
        "zh_HK": "越南菜",
        "alias": ""
    },
    {
        "id": 215,
        "category": "Cuisine Nationality",
        "zh_TW": "泰式料理",
        "en_US": "Thai Cuisine",
        "th_TH": "ไทย",
        "zh_HK": "泰國菜",
        "alias": ""
    },
    {
        "id": 216,
        "category": "Cuisine Nationality",
        "zh_TW": "印尼料理",
        "en_US": "Indonesian",
        "th_TH": "อินโดนีเซีย",
        "zh_HK": "印尼菜",
        "alias": ""
    },
    {
        "id": 217,
        "category": "Cuisine Nationality",
        "zh_TW": "俄羅斯料理",
        "en_US": "Russian Cuisine",
        "th_TH": "รัซเซีย",
        "zh_HK": "俄羅斯菜",
        "alias": ""
    },
    {
        "id": 218,
        "category": "Cuisine Nationality",
        "zh_TW": "墨西哥料理",
        "en_US": "Mexican Cuisine",
        "th_TH": "เม็กซิโก",
        "zh_HK": "墨西哥菜",
        "alias": ""
    },
    {
        "id": 219,
        "category": "Cuisine Nationality",
        "zh_TW": "創意料理",
        "en_US": "Fusion cuisine",
        "th_TH": "ฟิวชั่นคูซีน",
        "zh_HK": "創意料理",
        "alias": ""
    },
    {
        "id": 220,
        "category": "Cuisine Nationality",
        "zh_TW": "英式料理",
        "en_US": "British Cuisine",
        "th_TH": "บริติช ",
        "zh_HK": "英國菜",
        "alias": ""
    },
    {
        "id": 221,
        "category": "Cuisine Nationality",
        "zh_TW": "澳洲料理",
        "en_US": "Australian Cuisine",
        "th_TH": "ออสเตรเลีย",
        "zh_HK": "澳洲菜",
        "alias": ""
    },
    {
        "id": 222,
        "category": "Cuisine Nationality",
        "zh_TW": "土耳其料理",
        "en_US": "Turkish Cuisine",
        "th_TH": "ตุรกี",
        "zh_HK": "土耳其菜",
        "alias": ""
    },
    {
        "id": 223,
        "category": "Cuisine Nationality",
        "zh_TW": "希臘料理",
        "en_US": "Greek Cuisine",
        "th_TH": "กรีก",
        "zh_HK": "希臘菜",
        "alias": ""
    },
    {
        "id": 224,
        "category": "Cuisine Nationality",
        "zh_TW": "巴西料理",
        "en_US": "Brazilian Cuisine",
        "th_TH": "บราซิล",
        "zh_HK": "巴西菜",
        "alias": ""
    },
    {
        "id": 225,
        "category": "Cuisine Nationality",
        "zh_TW": "台式料理",
        "en_US": "Taiwanese Cuisine",
        "th_TH": "ไต้หวัน",
        "zh_HK": "台灣菜",
        "alias": ""
    },
    {
        "id": 226,
        "category": "Cuisine Nationality",
        "zh_TW": "地中海料理",
        "en_US": "Mediterranean Cuisine",
        "th_TH": "เมดิเตอร์เรเนียน",
        "zh_HK": "地中海菜",
        "alias": ""
    },
    {
        "id": 227,
        "category": "Cuisine Nationality",
        "zh_TW": "黎巴嫩料理",
        "en_US": "Lebanese Cuisine",
        "th_TH": "เลบานอน",
        "zh_HK": "黎巴嫩菜",
        "alias": ""
    },
    {
        "id": 228,
        "category": "Cuisine Nationality",
        "zh_TW": "新疆料理",
        "en_US": "Shinjang Cuisine",
        "th_TH": "ซินเจียง",
        "zh_HK": "新疆菜",
        "alias": ""
    },
    {
        "id": 229,
        "category": "Cuisine Nationality",
        "zh_TW": "蒙古料理",
        "en_US": "Mongolia Cuisine",
        "th_TH": "มองโกเลีย",
        "zh_HK": "蒙古菜",
        "alias": ""
    },
    {
        "id": 230,
        "category": "Cuisine Nationality",
        "zh_TW": "川菜",
        "en_US": "Sichuan Cuisine",
        "th_TH": "เสฉวน",
        "zh_HK": "川菜",
        "alias": ""
    },
    {
        "id": 231,
        "category": "Cuisine Nationality",
        "zh_TW": "湘菜",
        "en_US": "Hunan Cuisine",
        "th_TH": "หูหนาน",
        "zh_HK": "湘菜",
        "alias": ""
    },
    {
        "id": 232,
        "category": "Cuisine Nationality",
        "zh_TW": "潮州菜",
        "en_US": "Chiuchow Cuisine",
        "th_TH": "เเต้จิ๋ว",
        "zh_HK": "潮洲打冷",
        "alias": ""
    },
    {
        "id": 233,
        "category": "Cuisine Nationality",
        "zh_TW": "上海菜",
        "en_US": "Shanghai Cuisine",
        "th_TH": "เซียงไฮ้",
        "zh_HK": "上海菜",
        "alias": ""
    },
    {
        "id": 234,
        "category": "Cuisine Nationality",
        "zh_TW": "京菜",
        "en_US": "Beijing Cuisine",
        "th_TH": "ปักกิ่ง",
        "zh_HK": "北京菜",
        "alias": ""
    },
    {
        "id": 235,
        "category": "Cuisine Nationality",
        "zh_TW": "瑞士料理",
        "en_US": "Swiss Cuisine",
        "th_TH": "สวิตเซอร์เเลนด์",
        "zh_HK": "瑞士菜",
        "alias": ""
    },
    {
        "id": 301,
        "category": "Cuisine Type",
        "zh_TW": "下午茶",
        "en_US": "Afternoon Tea",
        "th_TH": "ยามบ่าย",
        "zh_HK": "下午茶",
        "alias": ""
    },
    {
        "id": 302,
        "category": "Cuisine Type",
        "zh_TW": "酒吧",
        "en_US": "Bar",
        "th_TH": "บาร์",
        "zh_HK": "酒吧",
        "alias": ""
    },
    {
        "id": 303,
        "category": "Cuisine Type",
        "zh_TW": "燒烤",
        "en_US": "Barbecue",
        "th_TH": "บาร์บีคิว",
        "zh_HK": "燒烤",
        "alias": ""
    },
    {
        "id": 304,
        "category": "Cuisine Type",
        "zh_TW": "早午餐",
        "en_US": "Brunch",
        "th_TH": "อาหารเช้าเที่ยง",
        "zh_HK": "早午餐",
        "alias": ""
    },
    {
        "id": 305,
        "category": "Cuisine Type",
        "zh_TW": "自助餐",
        "en_US": "Buffet",
        "th_TH": "บุฟเฟ่ต์",
        "zh_HK": "自助餐",
        "alias": ""
    },
    {
        "id": 306,
        "category": "Cuisine Type",
        "zh_TW": "漢堡",
        "en_US": "Burger",
        "th_TH": "เบอร์เกอร์",
        "zh_HK": "漢堡包",
        "alias": ""
    },
    {
        "id": 307,
        "category": "Cuisine Type",
        "zh_TW": "咖哩",
        "en_US": "Curry",
        "th_TH": "เเกงกะหรี่",
        "zh_HK": "咖哩",
        "alias": ""
    },
    {
        "id": 308,
        "category": "Cuisine Type",
        "zh_TW": "點心",
        "en_US": "Dim Sum",
        "th_TH": "ติ่มซำ",
        "zh_HK": "點心",
        "alias": ""
    },
    {
        "id": 309,
        "category": "Cuisine Type",
        "zh_TW": "火鍋",
        "en_US": "Hot Pot",
        "th_TH": "ฮอทพอท",
        "zh_HK": "火鍋",
        "alias": ""
    },
    {
        "id": 310,
        "category": "Cuisine Type",
        "zh_TW": "懷石料理",
        "en_US": "Kaiseki Ryori",
        "th_TH": "ไคเซกิ เรียวริ",
        "zh_HK": "懷石料理",
        "alias": ""
    },
    {
        "id": 311,
        "category": "Cuisine Type",
        "zh_TW": "義大利麵",
        "en_US": "Pasta",
        "th_TH": "พาสต้า",
        "zh_HK": "意粉",
        "alias": ""
    },
    {
        "id": 312,
        "category": "Cuisine Type",
        "zh_TW": "比薩",
        "en_US": "Pizza",
        "th_TH": "พิซซ่า",
        "zh_HK": "薄餅",
        "alias": ""
    },
    {
        "id": 313,
        "category": "Cuisine Type",
        "zh_TW": "拉麵",
        "en_US": "Ramen",
        "th_TH": "ราเม็ง",
        "zh_HK": "拉麵",
        "alias": ""
    },
    {
        "id": 314,
        "category": "Cuisine Type",
        "zh_TW": "海鮮",
        "en_US": "Seafood",
        "th_TH": "ซีฟู๊ด",
        "zh_HK": "海鮮",
        "alias": ""
    },
    {
        "id": 315,
        "category": "Cuisine Type",
        "zh_TW": "麻辣火鍋",
        "en_US": "Spicy Hot Pot",
        "th_TH": "สไปซี่ฮ๊อทพ๊อท",
        "zh_HK": "麻辣火鍋",
        "alias": ""
    },
    {
        "id": 316,
        "category": "Cuisine Type",
        "zh_TW": "牛排",
        "en_US": "Steak",
        "th_TH": "สเต็ก",
        "zh_HK": "牛扒",
        "alias": ""
    },
    {
        "id": 317,
        "category": "Cuisine Type",
        "zh_TW": "串燒",
        "en_US": "Skewered Barbecue",
        "th_TH": "ปิ้งย่างบีบีคิว",
        "zh_HK": "串燒",
        "alias": ""
    },
    {
        "id": 318,
        "category": "Cuisine Type",
        "zh_TW": "壽司",
        "en_US": "Sushi",
        "th_TH": "ซูชิ",
        "zh_HK": "壽司",
        "alias": ""
    },
    {
        "id": 319,
        "category": "Cuisine Type",
        "zh_TW": "鐵板燒",
        "en_US": "Teppanyaki",
        "th_TH": "เทปันยากิ",
        "zh_HK": "鐵板燒",
        "alias": ""
    },
    {
        "id": 320,
        "category": "Cuisine Type",
        "zh_TW": "素食",
        "en_US": "Vegetarian",
        "th_TH": "เจ",
        "zh_HK": "素食",
        "alias": ""
    },
    {
        "id": 401,
        "category": "Suitable Purpose",
        "zh_TW": "浪漫約會",
        "en_US": "Romance",
        "th_TH": "โรเเมนติก",
        "zh_HK": "浪漫約會",
        "alias": ""
    },
    {
        "id": 402,
        "category": "Suitable Purpose",
        "zh_TW": "商業聚餐",
        "en_US": "Business Bites",
        "th_TH": "นัดคุยธุรกิจ",
        "zh_HK": "商業聚會",
        "alias": ""
    },
    {
        "id": 403,
        "category": "Suitable Purpose",
        "zh_TW": "家庭聚餐",
        "en_US": "Family Gathering",
        "th_TH": "ครอบครัว",
        "zh_HK": "家庭聚會",
        "alias": ""
    },
    {
        "id": 404,
        "category": "Suitable Purpose",
        "zh_TW": "團體聚餐",
        "en_US": "Group Gathering",
        "th_TH": "นัดสังสรรค์",
        "zh_HK": "放工一聚",
        "alias": ""
    },
    {
        "id": 405,
        "category": "Suitable Purpose",
        "zh_TW": "朋友聚餐",
        "en_US": "With Friends",
        "th_TH": "นัดรวมเเก๊งค์",
        "zh_HK": "三五之己",
        "alias": ""
    },
    {
        "id": 501,
        "category": "View",
        "zh_TW": "海景",
        "en_US": "Harbour View",
        "th_TH": "ริมทะเล",
        "zh_HK": "海景",
        "alias": ""
    },
    {
        "id": 502,
        "category": "View",
        "zh_TW": "夜景",
        "en_US": "Sky View",
        "th_TH": "ร้านบนดาดฟ้า",
        "zh_HK": "夜景",
        "alias": ""
    },
    {
        "id": 503,
        "category": "View",
        "zh_TW": "河畔景觀",
        "en_US": "Riverside View",
        "th_TH": "ริมเเม่น้ำ",
        "zh_HK": "河畔景觀",
        "alias": ""
    }
]
