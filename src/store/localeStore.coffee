_               = require 'underscore'
{EventEmitter}  = require 'events'

CHANGE_EVENT = 'change'

class Store extends EventEmitter
    constructor: ->
        @_locale = []
    emitChange: ->
        @emit CHANGE_EVENT
    addChangeListener: (cb)->
        this.on CHANGE_EVENT, cb
    removeChangeListener: (cb)->
        this.removeListener CHANGE_EVENT, cb
    addLocale: (raw)->
        @_locale = _.union @_locale, raw
    translate: (keys, locale)->
        _.chain keys
        .map (k)->
            val = lookup k, locale
            [k, val]
        .object()
        .value()

module.exports = (dispatcher)->
    store = new Store()
    store

lookup = (key, locale)->
    lowerkey = key.toLowerCase()
    if dictionary[lowerkey]? and dictionary[lowerkey][locale]? then dictionary[lowerkey][locale] else key

dictionary = 
    location: 
        en_US: 'Location'
        th_TH: 'สถานที่'
        zh_HK: '餐廳地點'
    address: 
        en_US: 'Address'
        th_TH: 'ที่อยู่'
        zh_HK: '地址'
    transportation:
        en_US: 'Transportation'
        th_TH: 'การเดินทาง'
        zh_HK: '交通方式'
    promotion: 
        en_US: 'Promotion'
        th_TH: 'โปรโมชั่นพิเศษ'
        zh_HK: 'EZTABLE 訂位專屬優惠'
    cuisine: 
        en_US: 'Cuisine'
        th_TH: 'อาหารประเภท'
        zh_HK: '菜色介紹'
    'suitable dining purpose':
        en_US: 'Suitable Dining Purpose'
        th_TH: 'เหตุผลที่ใช้บริการครั้งนี้'
        zh_HK: '推薦聚餐類型'
    type: 
        en_US: 'Type'
        th_TH: 'ประเภท'
        zh_HK: '料理種類'
    'recommended dishes':
        en_US: 'Recommended Dishes'
        th_TH: 'เมนูที่เเนะนำ'
        zh_HK: '推薦菜色'
    menu: 
        en_US: 'Menu'
        th_TH: 'เมนู'
        zh_HK: '菜單'
    'read menu':
        en_US: 'Read Menu'
        th_TH: 'อ่านเมนู'
        zh_HK: '閱讀菜單'
    details:
        en_US: 'Details'
        th_TH: 'รายละเอียด'
        zh_HK: '餐廳資訊'
    'price range':
        en_US: 'Price Range'
        th_TH: 'ราคาประมาณ'
        zh_HK: '每人消費價位'
    'open hour': 
        en_US: 'Open Hour'
        th_TH: 'เวลาที่เปิดบริการ'
        zh_HK: '營業時間'
    service:
        en_US: 'Service'
        th_TH: 'การบริการ'
        zh_HK: '提供服務'
    introduction:
        en_US: 'Introduction'
        th_TH: 'เเนะนำ'
        zh_HK: '餐廳簡介'
    website:
        en_US: 'Website'
        th_TH: 'เปิดดูเว็บไซด์'
        zh_HK: '餐廳網站'
    'visit website':
        en_US: 'Visit Website'
        th_TH: 'ดูเว็บไซด์'
        zh_HK: '拜訪網站'
    'book now':
        en_US: 'Book Now'
        th_TH: 'จองตอนนี้'
        zh_HK: '立即訂位'
    'our restaurants':
        en_US: 'Restaurant List'
        th_TH: 'รายชื่อร้านอาหาร'
        zh_HK: '餐廳列表'
    'earn 1-3% rebate from every reservation made with eztable app!':
        en_US: 'Earn 1-3% rebate from every reservation made with EZTABLE APP!'
        th_TH: 'รับเครดิตเงินคืน 1-3% จากทุกมื้ออาหารที่จองผ่าน EZTABLE APP!'
        zh_HK: '每筆訂位用餐享有 1-3% 的 EZCASH 現金回饋！'
