# coding: utf-8


class Input # ログの読み込み

  def initialize
    Input_File()
  end

  def Input_File
    File.foreach('sample.log') do |line|
      puts line
    end
  end
  
end
