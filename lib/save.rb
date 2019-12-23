# coding: utf-8
require 'fileutils'

class Input_Save < Input # 機能改変も検討したがtmpが出されない従来法も良かったので追加として設計

  private
  def input_file(r_files, opt_t) # ログの読み込みと書き込み分散
    Dir.mkdir("tmp") unless Dir.exist?("./tmp") # 一時フォルダ作成
    w_files = ["tmp/input_1.tmp"]
    c = 0 # カウント用変数
    w_file = File.open("tmp/input_1.tmp", "w")
    for r_file in r_files # オプションのファイルリストから順次読み込み
      File.foreach(r_file) do |line| # 1行ずつ読み取り(メモリ対策?)
        /^(.*) (.*) (.*) \[(.*)\] "(.*)" (.*) (.*) "(.*)" "(.*)"$/ =~ line
        w_file.puts("#{$1} #{$4}") if judge($4, opt_t) # 各内容をファイル出力
        c += 1
        if c == 100000 # 10万毎に出力ファイルを分割(分割後の読み取りメモリ対策)
          w_file.close
          n = "tmp/input_#{w_files.length+1}.tmp"
          w_files.push(n)
          w_file = eval("File.open('#{n}', 'w+')")
          c = 0
        end
      end
    end
    w_file.close
    w_files # 各内容のリストではなく, 出力したファイル名の一覧を返す
  end

end



class Analysis_Save < Analysis

  private
  def hour(tmp_files) # 時間別のデータ分析
    Display.top("HOUR")
    result = {} # 結果を入れる関数
    for d in tmp_files do # tmpファイル毎に読み取り
      File.foreach(d) do |line|
        t = line[/^.* (.* .*)\n$/, 1] # 日時抽出
        t = Convert.date_sort(t) # 日時変換
        eval("result[:#{t}] = 0") if eval("result[:#{t}].nil?") # 値が存在していないなら0(後に+1される)
        eval("result[:#{t}] += 1") # 個数計算
      end
    end
    Display.hour(result.sort)
  end

  
  def host(tmp_files) # ホスト別のデータ分析
    Display.top("HOST")
    result = {}
    for d in tmp_files do # tmpファイル毎に読み取り
      File.foreach(d) do |line|
        h = "h" + line[/^(.*) .* .*\n$/, 1].gsub(/\./, "_") # eval回避の為の置換(. => _)
        eval("result[:#{h}] = 0") if eval("result[:#{h}].nil?") # 値が存在していないなら0(後に+1される)
        eval("result[:#{h}] += 1") # 個数計算
      end
    end
    Display.host(result.sort)
  end
  
end

class After_Save
  
  def self.remove
    FileUtils.rm_r("./tmp")
  end
  
end
