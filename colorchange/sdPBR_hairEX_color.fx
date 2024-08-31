#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"

float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "HairR+"; >;
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "HairG+"; >;
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "HairB+"; >;
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "HairV-"; >;


void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;
    m.baseColor = float3(monoColor, monoColor, monoColor);
    m.baseColor *= float3(0.01+ctrl_baseColorR, 0.01+ctrl_baseColorG, 0.01+ctrl_baseColorB)*(1-ctrl_baseColorV);
    m.roughness = 0.35;
    m.anisotropic = 0.85;
    m.specular = 0.45;
    m.specularTint = 0.33;
    m.anisoAngleX = 0.25;
    m.normalScale = 0.5;
    m.normalLoops = 3;
}

#define ANISOTROPIC_FUZZ

#define TEXTURE_PACK0 "../../texture/hair_normal.jpg"
#define NORMAL_FROM NORMAL_FROM_PACK0
//#define SPECULAR_FROM SPECULAR_FROM_PACK0

//#define SUBNORMAL_FROM SUBNORMAL_FROM_TEX
//#define SUBNORMAL_AUTOGEN

#include "../../shader/sdPBRMaterialTail.fxsub"