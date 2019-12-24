# coding: utf-8

class Analysis # 分析と結果表示(TODO: eval部分の統一 -> eval以外でないと困難の為保留)

  def initialize(data,opt_m)
    hour(data) if opt_m.include?("HOUR") # HOUR時にHOUR表示
    host(data) if opt_m.include?("HOST") # HOST時にHOST表示
  end

  private
  def hour(data) # 時間別のデータ分析
    Display.top("HOUR")
    result = {} # 結果を入れる関数
    for d in data do
      t = Convert.date_sort(d[1]) # 日時変換
      eval("result[:#{t}] = 0") if eval("result[:#{t}].nil?") # 値が存在していないなら0(後に+1される)
      eval("result[:#{t}] += 1") # 個数計算
    end
    Display.hour(result.sort)
  end

  
  def host(data) # ホスト別のデータ分析
    Display.top("HOST")
    result = {}
    for d in data do
      h = "h" + d[0].gsub(/\./, "_") # eval回避の為の置換(. => _)
      eval("result[:#{h}] = 0") if eval("result[:#{h}].nil?") # 値が存在していないなら0(後に+1される)
      eval("result[:#{h}] += 1") # 個数計算
    end
    Display.host(result.sort_by{ |_, v| -v })
  end
  
end

