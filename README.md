# JupyterLab Elixir

「fukuoka.ex Elixir／Phoenix Advent Calendar 2020」投稿記事のサポート用リポジトリ

- [JupyterLab + Poetry + Docker環境で、Elixirを実行する](https://qiita.com/im_miolab/items/01ba3987330a587bd757)

## 概要

__JupyterLab__ で、Python __以外__ の開発言語も実行できるようにする。

- 実行環境の構築は __Docker__ で行い、Pythonバージョン及びライブラリ管理は __Poetry__ で行います。
- Poetryでは仮想環境の構築はスキップします。（Dockerコンテナの構築やってるため）
- Elixirの対話型実行環境 __「IEx」__ をJupyterLabで実行します。
  - JupyterカーネルのIElixirを使います。

### モチベーション

- JupyterLabではコマンドの実行結果をそのままファイル形式で保存できます。
- そのため、たとえばElixirならIEx実行コマンドのコード管理にも役立てられる、ということがJupyterLabを実行するメリットのひとつです。
- また、`Boyle` により、すぐにElixirライブラリの試用が可能となります。  
  （mixファイルの準備とかimport hogeとかしなくてもいい）

### 実行環境

- MacOS
- Docker (docker-compose)

## 環境構築


- 任意のプロジェクト名でディレクトリを作ります
- ディレクトリ直下に、以下の3ファイルを用意します

  ```terminal
  .
  ├── Dockerfile
  ├── docker-compose.yml
  └── pyproject.toml
  ```

## 実行

```terminal
$ cd hogehoge（ファイルを用意したディレクトリ）

$ docker-compose build

$ docker-compose up
```

- コンテナが起動したら、ブラウザで [localhost:8890](http://localhost:8890) を確認します。

  <img width="599" alt="jupyter_ex1" src="https://user-images.githubusercontent.com/33124627/102766011-d1593b80-43c0-11eb-8d06-2246098404f3.png">

  - Elixirカーネルを追加することができました。

  <img width="716" alt="jupyter_ex2" src="https://user-images.githubusercontent.com/33124627/102766016-d4542c00-43c0-11eb-917b-ce48e606436d.png">

  - Elixirのコマンド実行もできています。

  - JupyterLabでの実行結果をファイルで保存できるので便利。

### ElixirのライブラリをJupyterLabで使う

- `Boyle.install({:math, "~> 0.5.0"})` のようにコードを書くことで、ライブラリの使用が可能となります。

  <img width="745" alt="math_ex" src="https://user-images.githubusercontent.com/33124627/102885673-18b1fb80-4497-11eb-95a6-f3dad9a1c8e3.png">

  - [math (Hex)](https://hex.pm/packages/math)

---

### 参考

- GitHub

  - [Jupyter kernels](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels)

    - [IElixir](https://github.com/pprzetacznik/IElixir)

      - [example Using](https://github.com/pprzetacznik/IElixir/blob/master/resources/example.ipynb)

      - [ZeroMQ header files missing](https://github.com/pprzetacznik/IElixir#zeromq-header-files-missing)

      ```terminal
      ===> /IElixir/deps/erlzmq/c_src/erlzmq_nif.c:24:10: fatal error: zmq.h: No such file or directory
        #include "zmq.h"
                  ^~~~~~~
      compilation terminated.
      ```

      - [Boyle usage](https://github.com/pprzetacznik/IElixir/blob/master/resources/boyle%20example.ipynb)

        - https://github.com/pprzetacznik/IElixir/blob/master/resources/boyle%20example%20-%20matrex%20installation%20and%20usage.ipynb

        - https://github.com/pprzetacznik/IElixir/blob/master/resources/inlineplot%20example%20-%20gnuplot.ipynb

- Docker

  - [Python](https://hub.docker.com/_/python)
