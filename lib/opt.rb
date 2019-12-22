# coding: utf-8
require 'optparse'

# 初期情報を取得
class Opt

  def initialize
    @params = check(get_opt)
  end

  def param # オプションの表示
    @params
  end
  

  def get_opt # オプションから情報を入手
    opt = OptionParser.new
    params = {f:["sample.log"]} # 初期値の設定
    begin
#      opt.on('-m', '--mode [mode]')  {|v| params[:m] = v}
#      opt.on('-t', '--time=STARTTIME-ENDTIME')  {|v| params[:t] = v}
      opt.on('-f FILE,FILE,...', '--file=FILE,FILE,...', Array, 'input files(default:sample.log)')  {|v| params[:f] = v}
      opt.parse!(ARGV)
    rescue => e
      puts "ERROR: #{e}.\n See #{opt}"
      exit
    end
    return params
  end

  def check(params) # オプションの有効判定
    for f_name in params[:f] # -fでのファイル名が存在しないとエラー終了
      unless File.exist?(f_name)
        STDERR.print "ERROR! input_file #{f_name} is nothing!\n"
        exit 1
      end
    end
    params
  end
  
end

