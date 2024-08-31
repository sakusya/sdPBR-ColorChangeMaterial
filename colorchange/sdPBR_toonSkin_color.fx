#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    m.specular = 0.1;
    m.roughness = 0.5;
    m.toon = 0.9;
}


#include "../../shader/sdPBRMaterialTail.fxsub"