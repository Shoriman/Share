# -*- coding: utf-8 -*-

# import library list
import numpy as np
import pickle
import sys, os
import math
import matplotlib.pyplot as plt


psep = '/'
Lform = 'csv'
dPath = '/Users/nishimoto/cell migration/data'
disps = []
listOfDist = []
interval = 6

# 指定されたパスから変位(.csv)をndarrayに格納
for Dname in os.listdir(dPath):
    fPath = dPath + psep + Dname
    for Oname in os.listdir(fPath):
        oPath = fPath + psep + Oname
        # 変位の格納されたcsvファイルならdispsにアペンド
        if ('.csv' in oPath):
            cordi = np.loadtxt(oPath, delimiter = ',')
            disps.append(cordi)
        else:
            continue

# 距離を計算しリストに格納
for j in range(len(disps)):
    for i in range(len(disps[j]) - interval):
        dy = disps[j][i + interval][1] - disps[j][i][1]
        dx = disps[j][i + interval][0] - disps[j][i][0]
        listOfDist.append(0.645 * math.sqrt(dy ** 2 + dx ** 2))

# 距離のリストを数値の小さい順にソート
listOfDist.sort(key=float)

# 距離のリストを１次元配列に変換する
arrOfDist = np.array(listOfDist, np.float32)

# ===============判別分析==================
icVar = [0] # クラス間分散の分子のリスト

for t in xrange(1, len(listOfDist)):
    # t(=threshold)で2つのクラスに分ける
    class1 = arrOfDist[:t]
    class2 = arrOfDist[t:]

    # 各クラスの要素数と平均を計算
    n1 = len(class1)
    n2 = len(class2)

    m1 = sum(class1) / len(class1)
    m2 = sum(class2) / len(class2)

    # クラス間分散の分子を計算
    icVar.append(n1 * n2 * (m1 - m2) ** 2)

# クラス間分散の分子が最大となるthresholdを求める
threshold  = arrOfDist[np.argmax(icVar)]

# 判別分析法で求めたthresholdを返す
print threshold

# ヒストグラムの表示
fig = plt.figure()
ax = fig.add_subplot(1,1,1)

ax.hist(arrOfDist, bins = 100)
plt.xticks([0, 5, 13.6063, 10, 15, 20, 25], [0, 5, 13.6063, 10, 15, 20, 25])
ax.set_title('Distribution of Moving Amount')
ax.set_xlabel('Moving Amount (pixel)')
ax.set_ylabel('Frequency')
fig.show()
