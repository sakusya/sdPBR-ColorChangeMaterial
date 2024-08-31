/////////////////////////////////////////////////////////////////////////
//色変えマテリアルの説明、色変えマテリアルの作り方
/////////////////////////////////////////////////////////////////////////

//①色変えマテリアルにしたい.fxファイルをコピーして好きな名前に変える。オススメはファイル名の後ろに"_color"をつけると分かりやすい
//②sdPBRColorController.pmxのモーフを追加する(pmxEditor)
//③コピーした.fxファイルをテキストエディタで編集

//pmxEditerにsdPBRColorController.pmxを読み込み
//"モーフ"タブに移動
//SkinR+,SkinG+,SkinB+,SkinV-を選択して[右クリック]＞[複製]
//

//--------------------------------.fxファイルの説明・編集箇所--------------------------------
//----------------------------------------------------------------------------------
//(触らない)バージョンの宣言とかおまじないはそのまま
#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"
//(触らない)

//(ここから追加)コントローラー名を宣言する下の１行を追加 ※(".pmx"の拡張子まで含めること)
#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"
//対応するコントローラーのモーフ名を指定する下の3行を追加
float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "sampleR+"; >;//R+のモーフ名
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "sampleG+"; >;//G+のモーフ名
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "sampleB+"; >;//B+のモーフ名
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "sampleV-"; >;//V-のモーフ名

void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)//ここは追加しない
{//ここは追加しない
    //void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
    //{
    //のすぐ後ろに下の3行を追加
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;    //モデルの頂点色・テクスチャのRGB各色の平均値を計算
    m.baseColor = float3(monoColor, monoColor, monoColor);                  //モデルの頂点色・テクスチャのRGB各色をモノクローム化
    m.baseColor *= float3(0.01+ctrl_baseColorR01, 0.01+ctrl_baseColorG01, 0.01+ctrl_baseColorB01)*(1-ctrl_baseColorV01); //モノクローム化したモデルの頂点色・テクスチャのRGB各色にコントローラーのモーフ値を乗算
    //追加する行終わり
    ....
    ....
    ....
}
//----------------------------------------------------------------------------------
//----------------------------------------------------------------------------------