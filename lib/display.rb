# coding: utf-8

class Display # 表示部分

  def self.top(mode) # 頭部分
    if mode == "HOUR"
      print "date              |Access times\n" # ljustとかで整えたほうが良さそう
      print "-------------------------------\n"
    end
    if mode == "HOST"
      print "Host name      |Access times\n" # ljustとかで整えたほうが良さそう
      print "----------------------------\n"
    end
  end

  
  def self.hour(data) 
    for d in data
      /([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})*$/ =~ d[0] # 表示部分の抽出
      print "#{$1}年#{$2}月#{$3}日#{$4}時|#{d[1]}\n" # 表示
    end
  end

  
  def self.host(data) 
    for d in data
      host = d[0].match(/([0-9_]*)$/) # 一致
      host = host[0].gsub(/_/, ".") # 置換(_ -> .)
      host = host.rjust(15," ") # 見た目調節
      print "#{host}|#{d[1]}\n" # 表示
    end
  end

end
