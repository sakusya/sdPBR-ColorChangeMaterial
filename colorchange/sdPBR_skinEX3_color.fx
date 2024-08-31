#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"

float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinR+"; >;
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinG+"; >;
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinB+"; >;
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinV-"; >;


//skinEX2をベースに曲率を推定する部分を入れたバリエーション
//中の詰まっている感じが出ます
void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;
    m.baseColor = float3(monoColor, monoColor, monoColor);
    m.baseColor *= float3(0.01+ctrl_baseColorR, 0.01+ctrl_baseColorG, 0.01+ctrl_baseColorB)*(1-ctrl_baseColorV);
    float c = saturate(length(fwidth(n)) / length(fwidth(Eye*80))); //曲率[1/mm]  80はMMD長さ→mmへの変換係数
    //曲率そのままだとポリ割りが目立つ事が多いので0～1 → 0.25～0.75にリマップして薄める
    //あんまり良い事ではないんだけどガタガタするよりはヨシ
    m.subsurface = lerp(0.25,0.75,c);
    m.specular = 0.35;
    m.roughness = 0.5;
    m.clearcoat = 1;
    m.clearcoatGloss = 0.8;
    m.normalLoops = 15;
    m.normalScale = 0.8;
    m.roughnessLoops = 15;
}

#define PREINTEGRATED_SKIN
#define TEXTURE_PACK0 "../../texture/skin2pack.png"

#define NORMAL_FROM NORMAL_FROM_PACK0
#define NORMAL_CHANNEL rg

#define ROUGHNESS_FROM ROUGHNESS_FROM_PACK0
#define ROUGHNESS_CHANNEL b


#include "../../shader/sdPBRMaterialTail.fxsub"
