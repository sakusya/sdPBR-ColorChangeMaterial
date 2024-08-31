#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    m.subsurface = 0.5;
    m.sssColor = float3(0.89,0.45,0.27);
    m.specular = 0.35;
    m.roughness = 0.65;
    m.clearcoat = 0.3;
    m.clearcoatGloss = 0.3;
    m.normalLoops = 20;
    m.normalScale = 0.6;
}

#define NORMAL_FROM NORMAL_FROM_FILE
#define NORMAL_FILE "../../texture/Skin_Human_002_NRM.png"

#include "../../shader/sdPBRMaterialTail.fxsub"
