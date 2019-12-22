# coding: utf-8


class Input # ログの読み込み

  
  def initialize(opt)
    @data = input_file(opt)
  end

  def data # 入力した中身
    @data
  end
  
  def input_file(opt) # ログの読み込み
    result = Array.new
    for file in opt # オプションのファイルリストから順次読み込み
      File.foreach(file) do |line| # 1行ずつ読み取り(メモリ消費対策?)
        /^(.*) (.*) (.*) \[(.*)\] "(.*)" (.*) (.*) "(.*)" "(.*)"$/ =~ line
        result.push([$1, $2, $3, $4, $5, $6, $7, $8, $9]) # 各内容をresultに格納
      end
    end
    result
  end

  
end
