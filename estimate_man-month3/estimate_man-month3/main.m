//
//  main.m
//  estimate_man-month3
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

// 漸化式
//dp[会社数][j] = 999999 (0 < j <=必要人数)
//dp[i][j] = 0 (0 <= i <会社数) (-200 < j <= 0)
//dp[i][j] = max{dp[i+1][j], dp[i+1][j−w[i]]+v[i]} (0 <= i <会社数) (0 < j <=必要人数)
// メモ化テーブル
// dp[i][j]はi番目以降の会社から人数の和がj以上となるように選んだときの価値の和の最小値を表す。
// 人数のオーバー分として200人を想定してjの要素数に上乗せ
int dp[tmpElement_n + 1][tmpElement_q + 201];


void solve_dp2() {
    // 定数999999の分
    for (int j = 1; j <= MAN_NEED; j++) {
        dp[TOTALNUMBER_COMPANY][j] = 999999;
    }
    // 定数0の分
    for (int i = TOTALNUMBER_COMPANY - 1; i >= 0; i--) {
        dp[i][0] = 0;
        // jがマイナスになる分として、要素数の上から200を使用
        for (int j = tmpElement_q+1; j <= 200200; j++) {
            dp[i][j] = 0;
        }
    }
    // 再帰呼び出しの分
    for (int i = TOTALNUMBER_COMPANY - 1; i >= 0; i--) {
        for (int j = 1; j <= MAN_NEED; j++) {
                if (dp[i+1][j]<dp[i + 1][j - q[i]] + r[i]){
                    dp[i][j] = dp[i+1][j];
                } else {
                    dp[i][j] = dp[i + 1][j - q[i]] + r[i];
                }
        }
    }
    //cout << dp[0][W] << endl;
    NSLog(@"%d",dp[0][MAN_NEED]);
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
        // 0番目の会社以降で人数MAN_NEED以上の場合の結果を表示する
        solve_dp2();
    }
    return 0;
}
