# mthesis
* 尾大経情院生用のLaTeXフォーマットです
    * upLaTeX、pLaTeXでのコンパイルを想定しています
        * デフォルトではuplatex
    * 画像挿入等必要なパッケージは各々自分で選んで適宜書き加えること（dviodfmxとか)
    * 余白・行数等の設定、その他見出しのスタイルは.styファイルで行っています
        * これも必要に応じて書き換えて使ってください  

## 準備
* LaTeX 環境
    * Dockerがおすすめ
* 各種エディター
    * VSCodeとかEmacsとかVimとか好きなやつ  

## Dockerを使ってかんたんにコンパイル
* bashとdockerさえあれば1コマンドで.texファイルをPDFにできます
~~~ bash
$ bash tex2pdf.sh mthesis.tex
~~~
* pLatexの場合は-pオプションつけるだけ
~~~ bash
$ bash tex2pdf.sh -p mthesis.tex
~~~
