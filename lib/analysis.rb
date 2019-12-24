# coding: utf-8

class Analysis # 分析と結果表示(TODO: eval部分の統一 -> eval以外でないと困難の為保留)

  def initialize(data,opt_m)
    hour(data) if opt_m.include?("HOUR") # HOUR時にHOUR表示
    host(data) if opt_m.include?("HOST") # HOST時にHOST表示
  end

  private
  def hour(data) # 時間別のデータ分析
    Display.top("HOUR")
    res = count(data,"HOUR")
    Display.hour(res.sort)
  end

  
  def host(data) # ホスト別のデータ分析
    Display.top("HOST")
    res = count(data,"HOST")
    Display.host(res.sort_by{ |_, v| -v })
  end

  def count(data, mode)
    result = {} # 結果を入れる関数
    for d in data do
      a = Convert.date_sort(d[1]) if mode == "HOUR"# 日時変換
      a = "h" + d[0].gsub(/\./, "_") if mode == "HOST" # eval回避の為の置換(. => _)
      eval("result[:#{a}] = 0") if eval("result[:#{a}].nil?") # 値が存在していないなら0(後に+1される)
      eval("result[:#{a}] += 1") # 個数計算
    end
    result
  end
  
end

