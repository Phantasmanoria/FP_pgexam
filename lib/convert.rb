# coding: utf-8

class Convert
  @Mon={ # 月変換用変数
    Jan:"01", Feb:"02", Mar:"03", Apr:"04", May:"05", Jun:"06",
    Jul:"07", Aug:"08", Sep:"09", Oct:"10", Nov:"11", Dec:"12"
  }

  def self.date_sort(date)
      /^([0-9]{2})\/([A-Za-z]*)\/([0-9]{4}):([0-9]{2}):.*$/ =~ date # 時刻から解析
      month = eval("@Mon[:#{$2}]") # 月変換
      t = "t#{$3}#{month}#{$1}#{$4}" # ハッシュ名の決定(命名規約によりtを最初に挿入)
      t    
  end

  def self.time_split(two_time)
    /^([0-9]{10})\-([0-9]{10})$/ =~ two_time
    return $1,$2
  end
end
