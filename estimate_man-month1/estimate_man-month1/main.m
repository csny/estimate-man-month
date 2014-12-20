//
//  main.m
//  estimate_man-month1
//
//  Created by macbook on 2014/12/16.
//  Copyright (c) 2014年 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

const int tmpElement_n = 50;  // 会社数の仮の要素数
int MAN_NEED, TOTALNUMBER_COMPANY;
int i;
// q=人数,r=費用 //w=重さ,v=価値
int q[tmpElement_n],r[tmpElement_n];

// i番目以降の会社から人数の和がj以上になるように選んだときの、
// 取りうる費用の総和の最小値を返す関数
int rec(int i, int j) {
    int res;
    const int infinite = 999999;
    if (j <= 0) {
        // 人数が条件MAN_LIMITを超えたら費用を0に、再起呼び出しはここで終了、折り返して計算。
        // ここを起点に投入した会社に応じて足し算
        res = 0;
    } else if (i == TOTALNUMBER_COMPANY) {
        // 会社がもう残っていない(且つj>0)ときは、最大値を入力、再起呼び出しはここで終了。
        // ここを起点に投入した会社に応じて足し算
        res = infinite;
    } else {
        // 会社iを入れるか入れないか選べるので、両方試して予算の和が小さい方を選ぶ
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
    return res;
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
        NSLog(@"%d",rec(0, MAN_NEED));
    }
    return 0;
}
