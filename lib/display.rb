# coding: utf-8

class Display

  def self.hourdisp(data) #表示
    print "日時              |アクセス回数\n" #ljustとかで整えたほうが良さげ?
    print "------------------------\n"
    for d in data
      /([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})*$/ =~ d[0] #表示部分の抽出
      print "#{$1}年#{$2}月#{$3}日#{$4}時|#{d[1]}\n" #表示
    end
    puts
  end

  def self.hostdisp(data) #表示
    print "ホスト名       |アクセス回数\n"
    print "------------------------\n"
    for d in data
      host = d[0].match(/([0-9_]*)$/) #一致
      host = host[0].gsub(/_/, ".") #置換(_ -> .)
      host = host.ljust(15," ") #見た目調節
      print "#{host}|#{d[1]}\n" #表示
    end
    puts
  end

end
