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
    m.subsurface = 0.5;

    m.specular = 0.25;
    m.sheen = 0.8;
    m.roughness = 0.9;
    m.normalLoops = 2;
    m.normalScale = 5;
    m.maskLoops = 2;
    /*
    m.heightLoops = 2;
    m.heightScale = 0.3;
    m.aoLoops = 2;
    m.aoScale = 1;
    */
}

#define TEXTURE_PACK0 "../../texture/lacepack.png"

#define NORMAL_FROM NORMAL_FROM_PACK0
#define NORMAL_CHANNEL rg

#define MASK_FROM MASK_FROM_PACK0
#define MASK_CHANNEL b

#define IGNORE_SP

#define ALPHA_CUTOFF_THRESHOLD 0.5
#define ALPHA_BINARY


#include "../../shader/sdPBRMaterialTail.fxsub"
