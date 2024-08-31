#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"

float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinR+"; >;
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinG+"; >;
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinB+"; >;
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinV-"; >;


//Version4.20で導入された水滴モデルを導入し、コースティクスの付いた水滴肌マテリアル

void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;
    m.baseColor = float3(monoColor, monoColor, monoColor);
    m.baseColor *= float3(0.01+ctrl_baseColorR, 0.01+ctrl_baseColorG, 0.01+ctrl_baseColorB)*(1-ctrl_baseColorV);
    //m.subsurface = 0.5;
    //曲率に応じてsubsurfaceを調整
    float c = saturate(length(fwidth(n)) / length(fwidth(Eye*80))); //曲率[1/mm]  80はMMD長さ→mmへの変換係数
    m.subsurface = lerp(0.25,0.75,c);

    m.specular = 0.35;
    m.roughness = 0.55;
    m.clearcoat = 1;
    m.clearcoatGloss = 1;

    float L1 = 15;
    m.normalLoops = L1;
    m.normalScale = 0.7;
    m.roughnessLoops = L1;

    float2 L2 = 3;
    m.subNormalLoops = L2;
    m.subNormalScale = -1;
    m.subRoughnessLoops = L2;
    m.baseColorLoops = L2;
}

float _Subroughness_Blend(float a, float b)
{
    return (b>=0.01) ? 0 : a;
}

#define SUBNORMAL_DROPLET
#define PREINTEGRATED_SKIN


#define TEXTURE_PACK0 "../../texture/wetpack_caustics.dds"

#define SUBNORMAL_FROM FROM_PACK0
#define SUBNORMAL_CHANNEL rg

#define SUBROUGHNESS_FROM FROM_PACK0
#define SUBROUGHNESS_CHANNEL b
#define SUBROUGHNESS_BLEND _Subroughness_Blend

#define BASECOLOR_FROM FROM_PACK0
#define BASECOLOR_BLEND BLEND_MUL
#define BASECOLOR_CHANNEL aaa
//↓水滴を目立たせたい時はここを1.0より大きく上げたり、subNormalScaleを大きくしてみましょう
#define BASECOLOR_GAMMA 1.0

#define TEXTURE_PACK1 "../../texture/skin2pack.png"

#define NORMAL_FROM FROM_PACK1
#define NORMAL_CHANNEL rg

#define ROUGHNESS_FROM ROUGHNESS_FROM_PACK1
#define ROUGHNESS_CHANNEL b


#include "../../shader/sdPBRMaterialTail.fxsub"
