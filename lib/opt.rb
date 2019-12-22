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
    params = {f:["sample.log"], # 初期値の設定
              m:["BOTH"]
             }
             
    begin
      opt.on('-m [MODE]', '--mode [mode]', ['HOUR', 'HOST', 'BOTH'], Array,
             'mode(HOUR or HOST or BOTH)(default:BOTH)')  {|v| params[:m] = v}
#      opt.on('-t', '--time=STARTTIME-ENDTIME')  {|v| params[:t] = v}
      opt.on('-f FILE,FILE,...', '--file=FILE,FILE,...', Array,
             'input files(default:sample.log)')  {|v| params[:f] = v}
      opt.parse!(ARGV)
    rescue => e
      puts "ERROR: #{e}.\n See #{opt}"
      exit
    end
    params
  end

  def check(params) # オプションの有効判定
    for f_name in params[:f] # -fでのファイル名が存在しないとエラー終了
      unless File.exist?(f_name)
        STDERR.print "ERROR! input_file #{f_name} is nothing!\n"
        exit 1
      end
    end
    if params[:m].nil? # -mでのモードが該当しないとエラー終了(optperseによりnilになる)
      STDERR.print "ERROR! mode is nothing!\n"
      exit 1
    end
    params[:m] = ["HOUR", "HOST"] if params[:m][0] == "BOTH" #BOTHの時は両方入れる
    params
  end
  
end

