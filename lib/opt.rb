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

  private
  def get_opt # オプションから情報を入手
    opt = OptionParser.new
    params = {f:["sample.log"], # 初期値の設定
              m:["BOTH"],
              t:"0000000000-9999999999"
             }         
    begin
      opt.on('-m [MODE]', ['HOUR', 'HOST', 'BOTH'], Array,
             'mode (HOUR | HOST | BOTH) (default:BOTH)')  {|v| params[:m] = v}
      opt.on('-t [STARTTIME-ENDTIME]', /[0-9]{2,10}\-[0-9]{2,10}/,
             'time interval per hour(e.g. 2014040100-2019033123)(def:all)')  {|v| params[:t] = v}
      opt.on('-f [FILE,FILE,...]', Array,
             'input files (default:sample.log)')  {|v| params[:f] = v}
      opt.on('-s', 'save memory mode (default:off)')  {|v| params[:s] = v}
      opt.parse!(ARGV)
    rescue => e # エラー処理
      puts "ERROR: #{e}.\n See #{opt}!"
      exit
    end
    params
  end

  
  def check(params) # オプションの有効判定
    for f_name in params[:f] # -fでのファイル名が存在しないとエラー終了
      unless File.exist?(f_name)
        STDERR.print "ERROR: input_file #{f_name} is not exist!\n"
        exit 1
      end
    end

    if params[:m].nil? # -mでのモードが該当しないとエラー終了(optperseによりnilになる)
      STDERR.print "ERROR: invalid argument -m!(syntax error)\n"
      exit 1
    end
    params[:m] = ["HOUR", "HOST"] if params[:m][0] == "BOTH" #BOTHの時は両方入れる

    if params[:t].nil? # -tでのモードが該当しないとエラー終了(optperseによりnilになる)
      STDERR.print "ERROR: invalid argument -t!(syntax error)\n"
      exit 1
    else # -tの構文が正しい時, 日付的に問題ないか否か(TODO:日付存在確認)
      start_t,end_t = Convert.time_split(params[:t])      
      if start_t > end_t
        STDERR.print "ERROR: invalid argument -t!(time interval error)\n"
        exit 1
      end
    end

    params
  end
  
end

