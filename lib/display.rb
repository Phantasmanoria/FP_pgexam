# coding: utf-8

class Display

  def self.disp(data) #表示
    print "日時              |アクセス回数\n"
    print "------------------------\n"
    for d in data
      /([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})*$/ =~ d[0]
      print "#{$1}年#{$2}月#{$3}日#{$4}時|#{d[1]}\n"
    end
  end

end
