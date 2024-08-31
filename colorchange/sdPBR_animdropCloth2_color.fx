#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"

float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "ClothR+"; >;
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "ClothG+"; >;
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "ClothB+"; >;
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "ClothV-"; >;


void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;
    m.baseColor = float3(monoColor, monoColor, monoColor);
    m.baseColor *= float3(0.01+ctrl_baseColorR, 0.01+ctrl_baseColorG, 0.01+ctrl_baseColorB)*(1-ctrl_baseColorV);
    m.baseColor *= 0.8;
    m.subsurface = 0.2;
    m.roughness = 1;
    m.specular = 0.5;
    m.sheen = 1;

    //水滴用ノーマル・ラフネスマップ
    m.subNormalLoops = 8;
    m.subNormalScale = 0.7;
    m.roughnessLoops = 8;
}

#define SUBNORMAL_DROPLET
#define ANIMATED_TEXTURE_PACK1 "../../texture/animdrop.png"
#define SUBNORMAL_FROM FROM_PACK1
#define ROUGHNESS_FROM FROM_PACK1
#define ROUGHNESS_CHANNEL b


#include "../../shader/sdPBRMaterialTail.fxsub"
