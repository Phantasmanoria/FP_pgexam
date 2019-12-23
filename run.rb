# coding: utf-8
require 'optparse' #optパーサー読み取り

#外部クラス読み込み
path = File.expand_path('./lib')
require path + '/opt'
require path + '/input'
require path + "/analysis"
require path + "/classification"
require path + "/display"
require path + "/log"
require path + "/convert"



#全体実行部分
option = Opt.new
params = option.param
list = Input.new(params[:f], params[:t])
a_list = Analysis.new(list.data, params[:m])
#list = res.hour(a_list.data).sort
#Display.hourdisp(list) if params[:m].include?("HOUR") # HOUR時にHOUR表示


#Display.hourdisp(Analysis.hour(list.data).sort) if params[:m].include?("HOUR") # HOUR時にHOUR表示
#Display.hostdisp(Analysis.host(list.data).sort) if params[:m].include?("HOST") # HOST時にHOST表示

