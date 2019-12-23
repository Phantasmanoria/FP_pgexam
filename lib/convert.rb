# coding: utf-8

class Convert
  @Mon={ # 月変換用変数
    Jan:"01", Feb:"02", Mar:"03", Apr:"04", May:"05", Jun:"06",
    Jul:"07", Aug:"08", Sep:"09", Oct:"10", Nov:"11", Dec:"12"
  }

  def self.date_sort(date) # 日時変換(TODO:JST以外の対応)
      /^([0-9]{2})\/([A-Za-z]*)\/([0-9]{4}):([0-9]{2}):.*$/ =~ date # 時刻から解析
      month = eval("@Mon[:#{$2}]") # 月変換
      t = "t#{$3}#{month}#{$1}#{$4}" # ハッシュ名の決定(命名規約によりtを最初に挿入)
      t    
  end

  
  def self.time_split(two_date) # 時間分割と時間補正を両方行う
    now=Time.now # 現在時刻の取得
    now=now.strftime("%Y%m%d%H") # 表示調整
    t = two_date.match(/^([0-9]{2,10})\-([0-9]{2,10})$/) # 時間分割
    result = [t[1], t[2]]
    for d in 1..2
      for s in [2,4,6,10]
        if t[d].size == s
          result[d-1] = now.slice(0,10-s) + t[d] #省かれていた部分を現在時間から追加
        end
      end
    end    
    result
  end
  
end
