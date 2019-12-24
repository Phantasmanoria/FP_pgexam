# coding: utf-8
require 'optparse' # optパーサー読み取り
require 'fileutils' # ファイル操作


#外部クラス読み込み
path = File.expand_path('./lib')
require path + '/opt'
require path + '/input'
require path + "/analysis"
require path + "/save"
require path + "/display"
require path + "/log"
require path + "/convert"



#全体実行部分
FileUtils.rm_r("./tmp") if Dir.exist?("./tmp") # 前処理(一時ファイル削除)

option = Opt.new # オプションの設定
params = option.param # オプションの読み取り

if params[:s].nil? # メモリセーブオプションで分岐を行う
  list = Input.new(params[:f], params[:t]) # 情報読み取り
  Analysis.new(list.data, params[:m]) # 情報分析と結果表示
else
  list = Input_Save.new(params[:f], params[:t]) # 情報読み取り
  Analysis_Save.new(list.data, params[:m]) # 情報分析と結果表示
end


FileUtils.rm_r("./tmp") if Dir.exist?("./tmp") # 後処理(一時ファイル削除)
