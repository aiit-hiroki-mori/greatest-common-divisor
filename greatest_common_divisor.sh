#!/bin/bash

# 正規表現による数字の確認
function is_natural_number () {
  NUM=$1
  NAME=$2

  if [[ ! $NUM =~ ^[0-9]+$ ]]; then
    echo "${NAME}: 自然数のみを入力してください" >&2
    exit 1
  fi

  if [[ $NUM = 0 ]]; then
    echo "${NAME}: 0は自然数ではありません。1以上の数字を入力してください" >&2
    exit 1
  fi
  
  if [[ $NUM =~ ^[0] ]]; then
    echo "${NAME}: 数値は先頭を0から始めることはできません" >&2
    exit 1
  fi
}

# ユークリッドの互除法
function gcd() {
  if [[ $2 = 0 ]]; then
    echo $1;
  else
    echo $(gcd $2 $(($1 % $2)))
  fi
}

# 引数取得
FIRST_NUM=$1
SECONT_NUM=$2

# 引数の存在確認
if [[ -z "${FIRST_NUM}" ]] || [[ -z "${SECONT_NUM}" ]]; then
  echo "引数は2つ必要です" >&2
  exit 1
fi

# 引数の形式確認
is_natural_number $FIRST_NUM '第1引数'
is_natural_number $SECONT_NUM '第2引数'

# 最大公約数
echo $(gcd $FIRST_NUM $SECONT_NUM)
