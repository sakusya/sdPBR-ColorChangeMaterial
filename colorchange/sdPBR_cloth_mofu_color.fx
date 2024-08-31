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
    m.specular = IORtoSpecular(1.6);    //�|���G�X�e���B(�V�R�̖т�1.55�t��)
    m.specularTint = 0.25;
    m.sheen = 1;
    m.sheenTint = 0.25;
    m.subsurface = 1; 

    m.mofuLoops = 1;        //�тׂ̍���(���l���Ⴂ�Ƒe��)
    m.mofuScale = 0.4;      //�т̍ő咷��(MMD�P��,1.0 = 8cm)
}

#define IGNORE_SP

//���ӁFMOFU��HEIGHT�͓����Ɏg���܂���
#define MOFU_FROM MOFU_FROM_FILE
#define MOFU_FILE "../../texture/fur.png"
#define MOFU_LOOPCOUNT 20    //�X�e�b�v��

#define MOFU_MOFU 1         //���t�тɂ�錩���ڂւ̉e���x(0�`1)
#define MOFU_OCCLUSION 0.25 //�тɂ���Ēn���Â�����x����(0�`1)

#include "../../shader/sdPBRMaterialTail.fxsub"
