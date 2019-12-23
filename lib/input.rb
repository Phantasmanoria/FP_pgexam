# coding: utf-8


class Input # ログの読み込み

  def initialize(opt_f, opt_t)
    @data = input_file(opt_f, opt_t)
  end

  
  def data # 入力した中身
    @data
  end

  
  def input_file(files, opt_t) # ログの読み込み
    result = Array.new
    for file in files # オプションのファイルリストから順次読み込み
      File.foreach(file) do |line| # 1行ずつ読み取り(メモリ消費対策?)
        /^(.*) (.*) (.*) \[(.*)\] "(.*)" (.*) (.*) "(.*)" "(.*)"$/ =~ line
        result.push([$1, $2, $3, $4, $5, $6, $7, $8, $9]) if judge($4, opt_t) # 各内容をresultに格納
      end
    end
    result
  end

  
  def judge(access_time, interval_time) # 時間内の抽出(TODO:他項目のチェック)
    result_t = Convert.date_sort(access_time) #日時の変換
    result_t = result_t[/[0-9]{10}/] #最初のtの除去
    start_t,end_t = Convert.time_split(interval_time)
    return true if result_t.to_i >= start_t.to_i && result_t.to_i <= end_t.to_i #時間内判定
    return false
  end
  
end
