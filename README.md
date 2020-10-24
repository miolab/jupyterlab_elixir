# [WIP] JupyterLab Elixir

アドベントカレンダー 2020 用の下書きです

### 検証環境

- MacOS

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
