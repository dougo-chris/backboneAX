$.dateRawNow = ()->
  $.dateRawFormat(Date.today())

$.dateRawFormat = (date)->
  return null unless date?  
  date.toString("yyyyMMddHHmm")

$.dateFormatRaw = (value)->
  return null unless value?
  switch format
    when "raw"
      value
    when "dateLong"
      Date.parseExact(value, "yyyyMMddHHmm").toString("dddd MMMM d, yyyy")
    when "dateUSA"
      Date.parseExact(value, "yyyyMMddHHmm").toString("MM/dd/yyyy")
    when "date"
      Date.parseExact(value, "yyyyMMddHHmm").toString("d MMM yy")
    when "timeLong"
      Date.parseExact(value, "yyyyMMddHHmm").toString("h:mm tt")
    when "time"
      Date.parseExact(value, "yyyyMMddHHmm").toString("HH:mm")
    when "dateTimeLong"
      Date.parseExact(value, "yyyyMMddHHmm").toString("dddd MMMM d, yyyy h:mm tt")
    else
      Date.parseExact(value, "yyyyMMddHHmm").toString("d MMM yyyy")
