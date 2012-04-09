$.dateRawNow = ()->
  $.dateRawFormat(Date.today())

$.dateRawFormat = (date)->
  return null unless date?  
  date.toString("yyyyMMdd")

$.dateFormatRaw = (value, format)->
  return null unless value?
  switch format
    when "raw"
      value
    when "dateLong"
      Date.parseExact(value, "yyyyMMdd").toString("dddd MMMM d, yyyy")
    when "dateUSA"
      Date.parseExact(value, "yyyyMMdd").toString("MM/dd/yyyy")
    when "date"
      Date.parseExact(value, "yyyyMMdd").toString("d MMM yy")
    else
      Date.parseExact(value, "yyyyMMdd").toString("d MMM yyyy")
