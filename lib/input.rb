# coding: utf-8


class Input # ログの読み込み

  
  def initialize
    @data = Input_File()
  end

  def data
    @data
  end
    
  def Input_File #ログの読み込み
    result = Array.new()
    File.foreach('sample.log') do |line| #1行ずつ読み取り(メモリ消費対策?)
      /^(.*) (.*) (.*) \[(.*)\] "(.*)" (.*) (.*) "(.*)" "(.*)"$/ =~ line
      result.push([$1, $2, $3, $4, $5, $6, $7, $8, $9]) #各内容をresultに格納
    end
    result
  end

  
end
