#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"

float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "PlasticR+"; >;
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "PlasticG+"; >;
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "PlasticB+"; >;
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "PlasticV-"; >;


void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;
    m.baseColor = float3(monoColor, monoColor, monoColor);
    m.baseColor *= float3(0.01+ctrl_baseColorR, 0.01+ctrl_baseColorG, 0.01+ctrl_baseColorB)*(1-ctrl_baseColorV);
    m.subsurface = 1;
    m.specular = 0.5;
    m.specularTint = 0.5;
    m.clearcoat = 1;
    m.clearcoatGloss = 0.3;
    m.roughness = 0.5;
}

#include "../../shader/sdPBRMaterialTail.fxsub"

