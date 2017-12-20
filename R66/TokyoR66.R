
# 初心者セッション①：データ読込 ---------------------------------------------------------

## CSVの読み込み
read.csv() #ベースパッケージ
readr::read_csv() #read.csvよりもデータ型をうまくやってくれる。しかも早い
data.table::fread() #高速で読むこむけど、data.tableになる。data.frameにしたければ、data.table = FALSEで。

## 処理時間を測りたいとき
system.time() #()に時間を測りたい関数を入れる

## クラウドからデータをとるときにつかうパッケージ
DBI:: # クラウドへの接続の際のアカウント処理とか
dbplyr:: # dplyrのデータベース特化版
sparklyr:: # sparkとかAWS S3で使える
bigquery:: # googleのbigquery

## webスクレイピング用のパッケージ
rvest::
rSelenium::
rtweet::

## githubにプレゼン資料あげます



# 初心者セッション②：パイプ処理とverb関数群 ---------------------------------------------------------

.[,1] #パイプ処理の途中で、データの名前自体を選びたいときは"."で

mutate(a = 1:nrow(.),
       a = a^2) # aは二つ目の式で上書きされる。二つaのカラムができるわけではない


# 初心者セッション③：可視化 -----------------------------------------------------------

anyNA() # data.frameのすべての列のすべての行にNAがあるかチェックする

## 好きな色で、色指定したいとき
colour.picker # RStudioアドイン。GUIで色を選ぶ
colours <- c(...) # 選んだ色でオブジェクトを作る
+ scale_color_manual(value = colours) # オブジェクトで色をしていする。scale_fill_manualもある。

## プレゼンにハンズオン資料があるらしい


# 応用編：flexdashboard本格入門 ---------------------------------------------------


# 応用編：そろそろ手を出すpurrr -------------------------------------------------------

library(tidyverse)

iris %>% 
  split(.$Species) %>% 
  map(~ lm(Petal.Width ~ Sepal.Length, data = .))

iris %>% 
  split(.$Species) %>% 
  map_dfc(~ mean(.$Sepal.Width))

# 二つの引数を
map2_int(.x = 1:3, .y = 4:6, .f = `+`)
map2_int(.x = 1:3, .y = 4:6, ~ .x + .y)

# 引数を二つ使うときはmap3
map2(.x = c(0, -1, 1),
     .y = c(1, 1.5, 2),
     .f = rnorm, n = 3)
map2(.x = c(0, -1, 1),
     .y = c(1, 1.5, 2),
     ~ rnorm(n = 3, mean = .x, sd = .y))

# 3つ以上の引数を使うならpmap関数(引数の名前で指定する)(引数の位置でも指定できるがおすすめできない)

# walk関数は、コンソールには表示されない、for side-effect

# 複数のデータに一つの関数をあてるのはmap
# 一つのデータに複数の関数をあてるのはinvoke

# keepとdiscard：predicate関数を使って、そのデータを残す/除外するを決める
# invoke：一つのデータに複数の関数をあてる。第一引数が関数、第二引数がデータ
# partial：

# mutateのなかの.と.xの違い → データフレームと使うときは、mapではなく、pmapをつかったほうがいい
# 接尾辞ifとat、dfとchr → 接尾辞ifとかatを使う&戻り値の型を指定したいときは、 %>% してas_vector()とかを使えばいい


# 応用編：変化検知 ----------------------------------------------------------------

library(changepoint)

data <- c(rnorm(100, 0, 1),
          rnorm(100, 5, 1))
model <- cpt.mean(data, method = "AMOC", minseglen = 10) # 単一変化点は"AMOC"メソッド

cpts(model)
param.est(model)
plot()

## 練習
data(Nile)
ts.plot(Nile)

# 複数変化点の場合、"PELT"メソッドで一択
cpt.var

## 練習
data(ftse100)
plot(ftse100, "l")


# 確率分布を4つから指定できる
cpt.meanvar

## 練習
data(HC1) # 時系列データじゃなくても、変化点検出できる
ts.plot(HC1)

# 変化点の数を増やせば、尤度は増える。よって、無限に変化点を増やさないようペナルティ項を入れたい

## method: "PELT"
## penalty: "CROPS"
## pen.value: データの範囲をベクトルで c(5, 500)みたいな

## CROPSですべての変化点をだせる
## 診断グラフで、最適な変化点を選ぶ