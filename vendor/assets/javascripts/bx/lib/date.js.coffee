$.dateRawNow = ()->
  $.dateRawFormat(Date.today())

$.dateRawFormat = (date)->
  return null unless date?  
  date.toString("yyyyMMddHHmm")

