# Weather Alert

1日の始まりに天気に関する不安を解消するアプリです。  
1日における天候に関する注意事項を警告してくれます。  

## 作成動機

「午後から天候が悪化することを知らず、洗濯物を干したまま家を出てしまった。」、「傘をもたずに家を出て、出先から帰る頃には雨が降っていた。」などといった経験は誰しもがあると思います。これらの悩みをなくすことを目的に作成しました。

## 設計

ディレクトリ構成
- classes/location.rb
- classes/geocode_api_client.rb
- classes/openweathermap_api_client.rb
- classes/weather_forecast.rb
- config.rb
- weather_forecast_tool.rb

外部API
- OpenWeatherMap(https://openweathermap.org/)  
  天気予報API  
  APIキーの取得をする必要あり、フリーで使えます。

- Geocoding API(https://developers.google.cn/maps/documentation/geocoding/overview?hl=ja)  
  住所→座標 変換API  
  APIキーを取得する必要あり、一定のリクエスト数までフリーで使えます。

## 使用方法

リポジトリを下記コマンドでローカルに落とす。  
```
git clone https://github.com/seiyawati/weather-alert-tool.git
```

お使いのPCにDockerをインストールしてください。  
Windows: https://docs.docker.jp/docker-for-windows/install.html  
Mac: https://docs.docker.jp/docker-for-mac/install.html  

コンテナをビルドして立ち上げる
```
docker-compose up -d --build
```
コンテナに入る
```
docker-compose exec app bash
```

OpenWeatherMapとGoogle Cloud Platformで取得したAPIキーを環境変数に格納する。   
```
vim ~/.bashrc
```
.bashrcに環境変数を格納する
```
export WEATHER_API_KEY="あなたのAPIキー"
export GOOGLE_API_KEY="あなたのAPIキー"
```
反映させる  
```
source ~/.bashrc
```

パラーメータに以下のコマンドライン引数を使用します。
- 第1引数：出発地点の住所（東京都世田谷区松原）
- 第2引数：出先の住所（東京都港区六本木）
- 第3引数：外出予定時間（9）時間

コマンドライン引数のルール
- 住所は市区町村まであった方が正確（ex. 東京都世田谷区松原）
- 外出予定時間は時を半角数字で入力する（ex. 9）

実行コマンド
```
ruby weather_forecast_tool.rb 東京都世田谷区松原 東京都港区六本木 5
```

実行結果(ex)
```
------------------------------------------------
東京都世田谷区松原の現在の天候（現在地）
天気：雨
天気詳細：強い雨
------------------------------------------------
------------------------------------------------
東京都港区六本木の現在の天候（出先）
天気：雨
天気詳細：強い雨
------------------------------------------------
------------------------------------------------
注意事項！
これから天候が悪化するので洗濯物を回収してから出掛けましょう！
出先で天候が悪化するので傘を持って出掛けましょう！
------------------------------------------------
```

ヘルプコマンド
```
ruby weather_forecast_tool.rb help
```
