/////////////////////////////////////////////////////////////////////////
//色変えマテリアルの説明
/////////////////////////////////////////////////////////////////////////

//--------------------------------.fxファイルの説明--------------------------------
//----------------------------------------------------------------------------------
//バージョンの宣言とかおまじない
#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"
//

//コントローラー名を宣言
#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"
//対応するコントローラーのモーフ名を下の３行で指定
float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "sampleR+"; >;//R+のモーフ名
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "sampleG+"; >;//G+のモーフ名
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "sampleB+"; >;//B+のモーフ名
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "sampleV-"; >;//V-のモーフ名

void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    //下の3行でマテリアルの色を計算
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;    //モデルの頂点色・テクスチャのRGB各色の平均値を計算
    m.baseColor = float3(monoColor, monoColor, monoColor);                  //モデルの頂点色・テクスチャのRGB各色をモノクローム化
    m.baseColor *= float3(0.01+ctrl_baseColorR01, 0.01+ctrl_baseColorG01, 0.01+ctrl_baseColorB01)*(1-ctrl_baseColorV01); //モノクローム化したモデルの頂点色・テクスチャのRGB各色にコントローラーのモーフ値を乗算
    
    ....
    ....
    ....
}
//----------------------------------------------------------------------------------
