# OS自作

- 『ゼロからのOS自作入門』
- [MikanOS](https://github.com/uchan-nos/mikanos)

## 開発環境

著書では、Ubuntu 18.04、またはWSLでの開発を想定している。
ここでは、Dockerを使ったMac OSでの開発環境について書く。

```bash
# docker imageのビルド
docker build -t mikanos:latest -f .

# docker内で起動したGUIアプリの描画をするためにXQuartzをインストール
brew install xquartz
```

事前に、XQuartzを起動する。
ここで、XQuartzの設定で"セキュリティ"の"接続の認証"、"ネットワーク・クライアントからの接続を許可"が共に有効にであることを確認する。

```bash
# ホスト側のIPアドレスを登録
IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $IP

# docker containerの起動
docker container run --privileged --rm -it -e DISPLAY=$(hostname):0 -v $PWD:/workspace/mikanos -v $HOME/.Xauthority:/root/.Xauthority mikanos:latest /bin/bash
```

