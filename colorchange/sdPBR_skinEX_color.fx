#define SDPBR_MATERIAL_VER 100
#include "../../shader/sdPBRMaterialHead.fxsub"

#define MATERIAL_CONTROLLER "sdPBRColorController.pmx"

float ctrl_baseColorR : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinR+"; >;
float ctrl_baseColorG : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinG+"; >;
float ctrl_baseColorB : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinB+"; >;
float ctrl_baseColorV : CONTROLOBJECT < string name = MATERIAL_CONTROLLER; string item = "SkinV-"; >;


void SetMaterialParam(inout Material m, float3 n,float3 l, float3 Eye, float2 uv)
{
    float monoColor = (m.baseColor.r + m.baseColor.g + m.baseColor.b)/3;
    m.baseColor = float3(monoColor, monoColor, monoColor);
    m.baseColor *= float3(0.01+ctrl_baseColorR, 0.01+ctrl_baseColorG, 0.01+ctrl_baseColorB)*(1-ctrl_baseColorV);
    m.subsurface = 0.5;                                 //���̒l�œ������𒲐��ł��܂��B�Ⴍ����ƌł������̔畆�ɂȂ�܂�
    //m.baseColor *= pow(float3(1, 0,9, 0,9), GAMMA);    //��̂̔��F�̒����͌���baseColor�Ə�Z����ƍs���܂�
    m.specular = 0.35;                                  //����̔��}�e���A���̓f�t�H���g�Ŕ������ݒ�ł�
    m.roughness = 0.65;
    m.clearcoat = 0.3;
    m.clearcoatGloss = 0.3;
    m.normalLoops = 20;
    m.normalScale = 0.6;
}

//xNormal�Ȃǂ̃c�[�����g����Curvature(�ȗ�)�}�b�v�����AsdPBR��subsurface�}�b�v�Ɏw�肷���
//�畆�̕������Ƃɍׂ������ߋ��ݒ�ł��܂�
//m.subsurface�̒l���e�N�X�`���ɏ����Ă���l�ɏ�Z�����̂ŁAsubsurface�}�b�v���g���ꍇ��
//��{�I��m.subsurface��1.0�ɐݒ肵�āA����������������ꍇ����������悤�Ȋ����Œ������܂��傤

//���̃V���{����ON�ɂȂ��Ă����pre-integrated skin�V�F�[�f�B���O���f�����g���܂�
//pre-intergated skin�ɂ����m.subsurface�l���ȗ��Ƃ݂Ȃ��Čv�Z���s���܂�
#define PREINTEGRATED_SKIN

#define NORMAL_FROM NORMAL_FROM_FILE
#define NORMAL_FILE "../../texture/Skin_Human_002_NRM.png"


#include "../../shader/sdPBRMaterialTail.fxsub"
