# coding: utf-8


class Input # ログの読み込み

  
  def initialize
    @data = Input_File()
  end

  def data
    @data
  end
    
  def Input_File
    result = Array.new()
    File.foreach('sample.log') do |line|
      /^(.*) (.*) (.*) \[(.*)\] "(.*)" (.*) (.*) "(.*)" "(.*)"$/ =~ line
      result.push([$1, $2, $3, $4, $5, $6, $7, $8, $9])
    end
    result
  end

  
end
