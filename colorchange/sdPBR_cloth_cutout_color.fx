//������̃��l�ȉ��̕������J�b�g����}�e���A��
//�t�����⃌�[�X�̕����̎��͂������Ȃ�悤�Ȏ�����

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
    m.subsurface = 0.1;
    m.roughness = 0.9;
    m.specular = 0.15;
    m.sheen = 0.5;
    m.sheenTint = 0.5;
    m.anisotropic = 0.5;
}


//���̃��l�ȉ��̕��͕̂`�悵�Ȃ�
//���C�g���疳������镪�����`�悵�Ȃ����Ƃɂ��ă��C�e�B���O�Ƃ̈�ѐ���ۂ�
#define ALPHA_CUTOFF_THRESHOLD LIGHTALPHA_THRESHOLD

//�c���������̃��l��1.0�Ƃ݂Ȃ�
#define BINARY_ALPHA

#include "../../shader/sdPBRMaterialTail.fxsub"
