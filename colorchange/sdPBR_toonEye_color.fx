#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    m.specular = 0;
    m.roughness = 1;
    m.toon = 1;
    m.SSDOVisibility = 0.3;
    m.shadowVisibility = 0.3;
}


#include "../../shader/sdPBRMaterialTail.fxsub"