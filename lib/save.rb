# coding: utf-8

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
        if c == 100000 # 一定毎に出力ファイルを分割(分割後の読み取りメモリ対策)(規定10万)
          w_file.close
          n = "tmp/input_#{w_files.length+1}.tmp"
          w_files.push(n)
          w_file = eval("File.open('#{n}', 'w+')")
          c = 0
        end
      end
    end

    w_file.close
    w_files # 各内容のリストではなく, 出力した一時ファイル名の一覧を返す
  end

end



class Analysis_Save < Analysis

  private
  def hour(in_files) # 時間別のデータ分析
    Display.top("HOUR")
    ana_files = count(in_files,"HOUR")
    unify_sort(ana_files)
  end

  
  def host(in_files) # ホスト別のデータ分析
    Display.top("HOST")
    ana_files = count(in_files,"HOST")
    unify_sort(ana_files)
  end


  def count(data, mode)
    w_files = []
    result = {} # 結果を入れる関数
    mode.downcase! # モード名の小文字化
    for d in data do # tmpファイル毎に読み取り
      n = "tmp/ana_#{mode}_#{w_files.length+1}.tmp"
      w_files.push(n)
      w_file = eval("File.open('#{n}', 'w')")

      File.foreach(d) do |line|
        if mode == "hour"
          a = line[/^.* (.* .*)\n$/, 1] # 日時抽出
          a = Convert.date_sort(a) # 日時変換
        end
        if mode == "host"
          a = "h" + line[/^(.*) .* .*\n$/, 1]
          a.gsub!(/\./, "_") # eval回避の置換(. => _)
        end
        eval("result[:#{a}] = 0") if eval("result[:#{a}].nil?") # 値が存在していないなら0(後に+1される)
        eval("result[:#{a}] += 1") # 個数計算
      end

      for d in result.sort do # 各ファイル毎のソート結果をana.tmpリストファイルに書き込み
        w_file.puts("#{d[0]} #{d[1]}")
      end
      w_file.close
      result = {} # 初期化
    end
    w_files
  end

  def unify_sort(ana_files) # 分割された分析済ファイルをメモリ考慮しつつ出力

    mode = ana_files[0][/hour/] unless ana_files[0][/hour/].nil? # 後のモード判別
    mode = ana_files[0][/host/] unless ana_files[0][/host/].nil?

    candidate = [] # 出力する候補
    top = "" # 出力する文字列
    n = 0 # 出力する値
    files_line = [] # 各ファイルの出力行
    for a in 1..ana_files.size do
      files_line.push(0)
    end

    loop {
      for a in 0..ana_files.size-1 do # 各ファイルの候補読み取り(下限に来てたらdummy挿入)
        d = Convert.read_line(ana_files[a],files_line[a])
        unless d.nil?
          candidate.push([d[0], d[1]])
        else
          candidate.push(["z","dummy"])
        end
      end

      break if check(candidate) # 候補が残ってないかチェック

      top = (candidate.sort_by {|x| x[0]})[0][0] # 出力すべき文字列を発見

      for a in 0..candidate.size-1 do # 複数に同じ文字列がある時の処理
        if candidate[a][0] == top 
          n += candidate[a][1].to_i # アクセス数の統合
          files_line[a] += 1 # 該当したファイルの読み込み行を1つずらす
        end
      end

      eval("Display.#{mode}([[top, n]])") # 表示を渡す
      
      candidate = [] # 初期化
      n = 0
    }
    
  end

  
  def check(list) # list内[1]が全部dummyならtrueを返す
    
    c = 0
    for a in list do
      c += 1 if a[1] == "dummy"
    end

    if list.size.to_i == c.to_i
      true
    else
      false
    end
  end
  
end

