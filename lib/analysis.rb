# coding: utf-8


class Analisys
  @Mon={ #月変換用変数
    Jan:"01", Feb:"02", Mar:"03", Apr:"04", May:"05", Jun:"06",
    Jul:"07", Aug:"08", Sep:"09", Oct:"10", Nov:"11", Dec:"12"
  }
  
  def self.hour(data) #時間別のデータ分析
    result = {} #結果を入れる関数
    for d in data do
      /^([0-9]{2})\/([A-Za-z]*)\/([0-9]{4}):([0-9]{2}):.*$/ =~ d[3] #時刻から解析
      month = eval("@Mon[:#{$2}]") #月変換
      t = "t#{$3}#{month}#{$1}#{$4}" #ハッシュ名の決定
      eval("result[:#{t}] = 0") if eval("result[:#{t}].nil?") #値が存在していないなら0(後に+1される)
      eval("result[:#{t}] += 1") #個数計算
    end
    result
  end

  
  def self.host(data) #ホスト別のデータ分析
    result = {}
    for d in data do
      h = "h" + d[0].gsub(/\./, "_") #eval回避の為の置換(. => _)
      eval("result[:#{h}] = 0") if eval("result[:#{h}].nil?") #値が存在していないなら0(後に+1される)
      eval("result[:#{h}] += 1") #個数計算
    end
    result  
  end
  
end

