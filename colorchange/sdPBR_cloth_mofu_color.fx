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
    m.roughness = 0.6;
    m.anisotropic = 0.7;
    m.specular = IORtoSpecular(1.6);    //ポリエステル。(天然の毛は1.55付近)
    m.specularTint = 0.25;
    m.sheen = 1;
    m.sheenTint = 0.25;
    m.subsurface = 1; 

    m.mofuLoops = 1;        //毛の細かさ(数値が低いと粗い)
    m.mofuScale = 0.4;      //毛の最大長さ(MMD単位,1.0 = 8cm)
}

#define IGNORE_SP

//注意：MOFUとHEIGHTは同時に使えません
#define MOFU_FROM MOFU_FROM_FILE
#define MOFU_FILE "../../texture/fur.png"
#define MOFU_LOOPCOUNT 20    //ステップ数

#define MOFU_MOFU 1         //モフ毛による見た目への影響度(0～1)
#define MOFU_OCCLUSION 0.25 //毛によって地を暗くする度合い(0～1)

#include "../../shader/sdPBRMaterialTail.fxsub"
