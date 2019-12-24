# FP_pgexam

## 内容

諸事情のため割愛

## 実行環境

```sh
%cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.2 LTS"
%ruby --version
ruby 2.5.3p105 (2018-10-18 revision 65156) [x86_64-linux]
```

## インストール・実行方法

```sh
%git clone git@github.com:Phantasmanoria/FP_pgexam.git
%cd FP_pgexam 
%ruby run.rb
```

## 使い方

```sh
%ruby run.rb --help
Usage: run [options]
    -f [FILE,FILE,...]               input files (default:sample.log)
    -m [MODE]                        mode (HOUR | HOST | BOTH) (default:BOTH)
    -t [STARTTIME-ENDTIME]           time interval per hour(e.g. 2014040100-2019033123)(def:all)
    -s                               save memory mode (default:off)
```

### ファイルオプション(-f)

デフォルトではrun.rbと同じ場所にある`sample.log`に指定されてます.  
読み込みを行うファイルの指定が出来ます.  
複数のファイルから読み込む時は`,`で続けて記入してください.  

### モードオプション(-m)

デフォルトでは`BOTH`に指定されています.  
`HOUR`は各時間帯毎のアクセス件数を表示させる機能です.  
`HOST`はリモートホスト毎のアクセス件数を表示させる機能です.  
`BOTH`は2つの機能をどちらも実行します.  

### タイムオプション(-t)

デフォルトでは`全期間`に指定されています.  
アクセス件数を表示させるための期間を設定できます.  
`-`で区切って開始時間と終了時間を設定してください(例:2014040100-2019033123).  
また, 終了時刻は`指定した時の59分まで`なので注意してください.  
<br>
例えば以下の時間の指定は以下のようになります.  

```
2014年4月1日0時 -> 2014 04 01 00 -> 2014040100
```

また, この日時に関して, ある程度省略が可能です.  
今日が2019年12月25日だとして, 今月の15日0時から20日20時までの時間を設定したいなら,  
日付からのみを書いた`1500-2019`でも有効です.  
この省略は`時`から(2桁), `日`から(4桁), `月`から(6桁)が可能です(逆はありません).  

### save memoryオプション(-s)

デフォルトでは`off`に指定しています.  
メモリ消費を抑えるような設定になっています.  
途中の処理内容のファイル書き出しを行うので, 入力ファイルのサイズ以上の空きを用意してください.  


## 課題(TODO)

- 全体
  - eval多すぎ
  - 変数名同じの多すぎ
	- 同じ時は意味は同じにしている
  - 関数に渡す前と後で変数名違う
	- その時の意味で変数名変更してる
  - analysisとdisplayをrun内でできるように
    - 分岐を考えると分析をrunで見えるように一度戻るよりそのまま通したほうがワークフロー的に良さげかも
- input.rb
  - 時間以外の入力チェック
- opt.rb
  - 日時の存在確認
- convert.rb
  - 日時変換のJST以外の対応
- opt.rb
  - 日時の存在確認
- save.rb
  - 破壊的メソッドの使用(メモリ消費対策)
  - 継承無しで使えるかどうか(設計から)
	- 継承してるけどあんまり意味ない現実はある
	- 継承後の内容もある程度統合できそう
- analysis.rb
  - 機能統合(宣言をeval以外で行えるように)
  
