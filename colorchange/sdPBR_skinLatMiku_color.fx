#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"

float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinR+"; >;
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinG+"; >;
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinB+"; >;
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinV-"; >;


//Lat式ミクさんの顔を描くためのマテリアル
//わざとライティングをほぼサボリます
//MMDの平行光源の色だけが考慮されます

float3 _LatMikuAmb :AMBIENT   < string Object = "Light"; >;
static float3 LatMikuAmb = pow((_LatMikuAmb+0.001),2.2);

void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;
    m.baseColor = float3(monoColor, monoColor, monoColor);
    m.baseColor *= float3(0.01+ctrl_baseColorR, 0.01+ctrl_baseColorG, 0.01+ctrl_baseColorB)*(1-ctrl_baseColorV);
    m.emissiveColor = m.baseColor * LatMikuAmb;
    m.baseColor = 0;
    m.lightVisibility = 0;
    m.shadowVisibility = 0;
    m.SSDOVisibility = 0;
    m.ambientVisibility = 0;
}

#include "../../shader/sdPBRMaterialTail.fxsub"