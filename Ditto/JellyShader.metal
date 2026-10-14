//
//  JellyShader.metal
//  MyApp
//
//  Created by 박소망 on 10/14/26.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>

using namespace metal;

[[ stitchable ]]
float2 jelly(
    float2 position,
    float2 size,
    float2 dragStart,
    float2 dragOffset,
    float radius
) {
    // 마우스로 잡은 지점과 현재 픽셀 사이의 거리
    float2 difference = position - dragStart;
    float distance = length(difference);

    // 잡은 지점 주변에만 영향을 주기
    float influence = max(0.0, 1.0 - distance / radius);

    // 경계에서 변화가 부드럽게 줄어들도록 계산
    influence = influence * influence * (3.0 - 2.0 * influence);
    influence = pow(influence, 0.7);

    // 원래 이미지에서 샘플링할 위치 계산
    return position - dragOffset * influence;
}
