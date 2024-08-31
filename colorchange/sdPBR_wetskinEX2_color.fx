#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"

float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinR+"; >;
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinG+"; >;
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinB+"; >;
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinV-"; >;




void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;
    m.baseColor = float3(monoColor, monoColor, monoColor);
    m.baseColor *= float3(0.01+ctrl_baseColorR, 0.01+ctrl_baseColorG, 0.01+ctrl_baseColorB)*(1-ctrl_baseColorV);
    m.subsurface = 0.5;                                 
    m.specular = 0.35;                                  

    m.clearcoat = 1;
    m.clearcoatGloss = 1;

    m.normalLoops = 15;
    m.normalScale = 0.7;

    m.roughness = 0.65;
    m.roughnessLoops = 5;

    m.subNormalLoops = 5;
    m.subNormalScale = 1;
}

#define PREINTEGRATED_SKIN

#define TEXTURE_PACK0 "../../texture/skin2pack.png"

#define NORMAL_FROM NORMAL_FROM_PACK0
#define NORMAL_CHANNEL rg

#define SUBNORMAL_FROM SUBNORMAL_FROM_PACK0
#define SUBNORMAL_AUTOGEN
#define SUBNORMAL_AUTOGEN_CHANNEL a
#define SUBNORMAL_AUTOGEN_CHANNEL_COUNT 1

#define ROUGHNESS_FROM ROUGHNESS_FROM_PACK0
#define ROUGHNESS_CHANNEL a
#define ROUGHNESS_INVERT

#include "../../shader/sdPBRMaterialTail.fxsub"
