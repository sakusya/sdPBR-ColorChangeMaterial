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
    m.subsurface = 0.9;
    //m.baseColor *= float3(0.9, 0.75,0.7); //ì˙èƒÇØÇà”éØÇµÇΩÅAÇÊÇËîZÇ¢îßêFÇ…ÇµÇΩÇ¢èÍçáÇÕÇ±Ç¡ÇøÇ‡Ç«Ç§Çº
    m.sssColor = pow(float3(1, 0.8, 0.64), GAMMA);
    m.specular = 0.5;
    m.specularTint = 0;
    m.roughness = 1;
    m.subNormalLoops = 10;
    m.subNormalScale = -1;
    m.normalLoops = 20;
    m.normalScale = 0.6;
    m.roughnessLoops = 10;
}

//#define SUBNORMAL_DROPLET
#define NORMAL_FROM FROM_FILE
#define NORMAL_FILE "../../texture/Skin_Human_002_NRM.png"

#define TEXTURE_PACK0 "../../texture/wetpack.png"
#define SUBNORMAL_FROM FROM_PACK0
#define SUBNORMAL_CHANNEL rg

#define ROUGHNESS_FROM FROM_PACK0
#define ROUGHNESS_CHANNEL b


#include "../../shader/sdPBRMaterialTail.fxsub"
