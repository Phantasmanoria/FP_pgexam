# coding: utf-8
require 'optparse'

# 初期情報を取得
class Opt

  def initialize
    getOpt
    analysis(params)
  end
  
  # オプションから情報を入手
  def getOpt
    opt = OptionParser.new
    params = {}
    begin
      opt.on('-m [mode]', '--mode [mode]')  {|v| params[:m] = v}
      opt.on('-f [file]', '--file [file]')  {|v| params[:f] = v}
      opt.on('-t [time]', '--time [time]')  {|v| params[:t] = v}
      opt.parse!(ARGV)
    rescue => e
      puts "ERROR: #{e}.\n See #{opt}"
      exit
    end
    return params
  end

  def analysis(params)
    # 入力の解析
  end
  
end

