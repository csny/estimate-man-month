//
//  main.m
//  estimate_man-month2
//
//  Created by macbook on 2014/12/21.
//  Copyright (c) 2014年 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

const int tmpElement_n = 50;  // 会社数の仮の要素数
const int tmpElement_q = 200000;  // 必要人数の仮の要素数
int MAN_NEED, TOTALNUMBER_COMPANY;
int i;
// q=人数,r=費用 //w=重さ,v=価値
int q[tmpElement_n],r[tmpElement_n];

// メモ化テーブル
// dp[i][j]はi番目以降の会社から人数の和がj以上となるように選んだときの価値の和の最小値を表す。
// 人数のオーバー分として200人を想定してjの要素数に上乗せ
int dp[tmpElement_n + 1][tmpElement_q + 201];

// i番目以降の会社から人数の和がj以上になるように選んだときの、
// 取りうる費用の総和の最小値を返す関数
int rec(int i, int j) {
    if (dp[i][j] != -1000) {
        // すでに調べたことがあるならその結果を再利用
        return dp[i][j];
    }
    int res;
    const int infinite = 999999;
    if (j <= 0) {
        // 人数が条件MAN_NEEDを超えたら費用を0に、再起呼び出しはここで終了、折り返して計算。
        // ここを起点に投入した会社に応じて足し算
        // jがマイナスになる分は、循環する感じで要素数の一番大きい数字から使用される
        res = 0;
        //NSLog(@"j=%d",j);
    } else if (i == TOTALNUMBER_COMPANY) {
        // 会社がもう残っていない(且つj>0)ときは、最大値を入力、再起呼び出しはここで終了。
        // ここを起点に投入した会社に応じて足し算
        res = infinite;
    } else {
        // 会社iを入れるか入れないか選べるので、両方試して費用の和が小さい方を選ぶ
        // 前述の２つの条件のどちらかを満たすまで、再帰呼び出しを繰り返す
        /*
         res = min(
         rec(i + 1, j),
         rec(i + 1, j - w[i]) + v[i]
         );
         */
        if (rec(i + 1, j)<rec(i + 1, j - q[i]) + r[i]){
            res = rec(i + 1, j);
        } else {
            res = rec(i + 1, j - q[i]) + r[i];
        }
    }
    return dp[i][j] = res;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 入力
        scanf("%d",&MAN_NEED);
        scanf("%d",&TOTALNUMBER_COMPANY);
        for (int i = 0; i < TOTALNUMBER_COMPANY; i++){
            scanf("%d\n%d", &q[i],&r[i]);
        }
        // 処理開始
        // メモ初期化
        for(int i=0;i<tmpElement_n+1;i++){
            for(int j=0;j<tmpElement_q+201;j++){
                dp[i][j] = -1000;
            }
        }
        // 0番目の会社以降で人数MAN_NEED以上の場合の結果を表示する
        NSLog(@"%d",rec(0, MAN_NEED));
    }
    return 0;
}
