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
    m.subsurface = 0.2;

    m.specular = 0.25;
    m.roughness = 0.9;
    m.normalLoops = 5;
    m.normalScale = 5;
    m.aoLoops = 5;
}

#define TEXTURE_PACK0 "../../texture/denimpack.png"

#define NORMAL_FROM NORMAL_FROM_PACK0
#define NORMAL_CHANNEL rg

#define AO_FROM AO_FROM_PACK0
#define AO_CHANNEL bbb

#define IGNORE_SP

#include "../../shader/sdPBRMaterialTail.fxsub"
