#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    //基本の設定
    m.subsurface = 0.5;
    m.roughness = 1;
    m.specular = 0.35;
    m.clearcoat = 0.3;
    m.clearcoatGloss = 0.3;

    //肌のノーマル・ラフネスマップ
    m.normalLoops = 15;
    m.normalScale = 0.8;
    m.roughnessLoops = 15;

    //水滴用サブノーマル・サブラフネスマップ
    m.subNormalLoops = 8;
    m.subNormalScale = 0.7;
    m.subRoughnessLoops = 8;
}

#define PREINTEGRATED_SKIN

#define ANIMATED_TEXTURE_PACK1 "../../texture/animdrop.png"
#define SUBNORMAL_FROM FROM_PACK1
#define SUBROUGHNESS_FROM FROM_PACK1
#define SUBROUGHNESS_CHANNEL b

#define TEXTURE_PACK0 "../../texture/skin2pack.png"
#define NORMAL_FROM NORMAL_FROM_PACK0
#define ROUGHNESS_FROM ROUGHNESS_FROM_PACK0
#define ROUGHNESS_CHANNEL b

#include "../../shader/sdPBRMaterialTail.fxsub"
