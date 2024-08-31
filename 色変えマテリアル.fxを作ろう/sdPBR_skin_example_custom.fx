#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"
////****追加行１ここから********************************************************************************************************////
#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"//この名前のコントローラーのモーフで操作する

float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinR+"; >;//RGBのR値を"SkinR01"という名前のモーフで操作する
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinG+"; >;//RGBのG値を"SkinG01"という名前のモーフで操作する
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinB+"; >;//RGBのB値を"SkinB01"という名前のモーフで操作する
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinV-"; >;//色の暗さを"SkinV01"という名前のモーフで操作する
////****追加行１ここまで********************************************************************************************************////
void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
////****追加行２ここから********************************************************************************************************////
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;//モノクロ化
    m.baseColor = float3(monoColor, monoColor, monoColor);//ベースカラーの色をモノクロにする
    m.baseColor *= float3(0.01+ctrl_baseColorR, 0.01+ctrl_baseColorG, 0.01+ctrl_baseColorB)*(1-ctrl_baseColorV);//モノクロ化したベースカラーにコントローラーのモーフ値を乗算する
////****追加行２ここまで********************************************************************************************************////
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
