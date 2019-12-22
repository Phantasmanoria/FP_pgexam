# coding: utf-8
require 'optparse' #パーサー読み取り

# 外部クラス読み込み
path = File.expand_path('./lib')
require path + '/opt'
require path + '/input'
require path + "/analysis"
require path + "/classification"
require path + "/display"
require path + "/log"



# 全体実行部分
list = Input.new()
list.data
