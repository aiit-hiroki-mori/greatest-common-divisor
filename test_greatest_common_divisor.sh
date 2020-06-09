#!/bin/bash

# エラー用配列
error_array=()
# 実行ファイルパス
ABS_PATH=$(cd $(dirname $0); pwd)/greatest_common_divisor.sh

# 正常系
## 同じ数字同士: 1-1, 10-10
RESULT=$(bash ${ABS_PATH} 1 1)
if [[ $? -eq 0 ]] && [[ $RESULT -eq 0 ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 同じ数字同士(1-1)") 
fi

RESULT=$(bash ${ABS_PATH} 10 10)
if [[ $? -eq 0 ]] && [[ $RESULT -eq 10 ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 同じ数字同士(10-10)") 
fi

## 最大公約数が1のみ: 5-37
RESULT=$(bash ${ABS_PATH} 5 37)
if [[ $? -eq 0 ]] && [[ $RESULT -eq 1 ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 最大公約数が1のみ(5-7)") 
fi

## 片方がある数の倍数: 35-5
RESULT=$(bash ${ABS_PATH} 35 5)
if [[ $? -eq 0 ]] && [[ $RESULT -eq 5 ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 片方がある数の倍数(35-5)") 
fi

## 大きい桁数: 5555-3695
RESULT=$(bash ${ABS_PATH} 5555 3695)
if [[ $? -eq 0 ]] && [[ $RESULT -eq 5 ]]; then
  echo "OK"
else
  error_array=("${error_array[@]}" "FAIL: 大きい桁数(5555-3695)") 
fi

# エラー系
## 引数が2つ不足
RESULT=$(bash ${ABS_PATH} 2>&1 > /dev/null)
if [[ $? -eq 1 ]] && [[ $RESULT == "引数は2つ必要です" ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 引数が2つ不足") 
fi

## 引数が1つ不足
RESULT=$(bash ${ABS_PATH} 10 2>&1 > /dev/null)
if [[ $? -eq 1 ]] && [[ $RESULT == "引数は2つ必要です" ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 引数が1つ不足") 
fi

# 第1引数の値が0である
RESULT=$(bash ${ABS_PATH} 0 10 2>&1 > /dev/null)
if [[ $? -eq 1 ]] && [[ $RESULT == "第1引数: 0は自然数ではありません。1以上の数字を入力してください" ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 第1引数の値が0である") 
fi

# 第2引数の値が0である
RESULT=$(bash ${ABS_PATH} 10 0 2>&1 > /dev/null)
if [[ $? -eq 1 ]] && [[ $RESULT == "第2引数: 0は自然数ではありません。1以上の数字を入力してください" ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 第2引数の値が0である") 
fi

# 第1引数がマイナスである
RESULT=$(bash ${ABS_PATH} -1 10 2>&1 > /dev/null)
if [[ $? -eq 1 ]] && [[ $RESULT == "第1引数: 自然数のみを入力してください" ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 第1引数がマイナスである") 
fi

# 第2引数がマイナスである
RESULT=$(bash ${ABS_PATH} 10 -1 2>&1 > /dev/null)
if [[ $? -eq 1 ]] && [[ $RESULT == "第2引数: 自然数のみを入力してください" ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 第2引数がマイナスである") 
fi

# 第1引数が0始まりの数値である
RESULT=$(bash ${ABS_PATH} 05 10 2>&1 > /dev/null)
if [[ $? -eq 1 ]] && [[ $RESULT == "第1引数: 数値は先頭を0から始めることはできません" ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 第1引数が0始まりの数値である") 
fi

# 第2引数が0始まりの数値である
RESULT=$(bash ${ABS_PATH} 10 05 2>&1 > /dev/null)
if [[ $? -eq 1 ]] && [[ $RESULT == "第2引数: 数値は先頭を0から始めることはできません" ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 第2引数が0始まりの数値である") 
fi

# 第1引数が数字ではない文字列
RESULT=$(bash ${ABS_PATH} a 10 2>&1 > /dev/null)
if [[ $? -eq 1 ]] && [[ $RESULT == "第1引数: 自然数のみを入力してください" ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 第1引数が数字ではない文字列") 
fi

# 第2引数が数字ではない文字列
RESULT=$(bash ${ABS_PATH} 10 あ 2>&1 > /dev/null)
if [[ $? -eq 1 ]] && [[ $RESULT == "第2引数: 自然数のみを入力してください" ]]; then
  echo "OK"
else
  echo "NG"
  error_array=("${error_array[@]}" "FAIL: 第2引数が数字ではない文字列") 
fi

for msg in "${error_array[@]}"
do
  echo "$msg" >&2
done

# エラーがない場合はステータス0で正常終了となる
exit ${#error_array[@]}
